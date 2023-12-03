import 'package:flutter/cupertino.dart' as cupertino;
import 'package:flutter/material.dart';
import 'package:mn_calculator/pages/utils.dart';

class NormalCalculator extends StatefulWidget {
  const NormalCalculator({super.key});

  @override
  State<NormalCalculator> createState() => _NormalCalculatorState();
}

class _NormalCalculatorState extends State<NormalCalculator> {
  UtilManager um = UtilManager();
  bool letAddPoint = true;
  String finalResult = "0";
  final ScrollController _scrollController = ScrollController();
  List<String> calculatorKeys = [
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  List<String> screenKeys = [
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '+'
  ];
  List<String> operations = ["/", "x", "-", "+"];
  List<String> actionButtons = ['C', '+/-', '%', 'DEL', "="];
  List<String> currentOp = [];
  String currentSel = "add";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.position.maxScrollExtent;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height * 0.9,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(2),
            child: Container(
              /// Calculator Display
              height: height *0.3,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  /// Current Calculation Screen
                  Container(
                    alignment: Alignment.bottomRight,
                    height: height *0.11,
                    width: width,
                    child: SizedBox(
                      height: 50,
                      child: ListView.builder(
                        controller: _scrollController,
                        reverse: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: currentOp.length,
                        itemBuilder: (context, index) => Text(
                          ['/', 'x', '-', '+', '+/-']
                                  .contains(currentOp.reversed.toList()[index])
                              ? " ${currentOp.reversed.toList()[index]} "
                              : currentOp.reversed.toList()[index],
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.bottomRight,
                    height: height *0.14,
                    width: width,
                    child: Text(
                      finalResult,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 29,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          // Screen Keys
          SizedBox(
            height: height *0.55,
            child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(2),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 120,
                    mainAxisExtent: 90,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    childAspectRatio: 19 / 13),
                itemCount: calculatorKeys.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        if (screenKeys.contains(calculatorKeys[index])) {
                          if (operations.contains(calculatorKeys[index])) {
                            currentOp.add(calculatorKeys[index]);
                            letAddPoint = true;
                          } else if (calculatorKeys[index] != ".") {
                            currentOp.add(calculatorKeys[index]);
                          } else if (calculatorKeys[index] == "." &&
                              letAddPoint) {
                            currentOp.add(calculatorKeys[index]);
                            letAddPoint = false;
                          }
                        } else if (actionButtons
                            .contains(calculatorKeys[index])) {
                          // A Switch Case to handle the C, +/-, %, DEL and = operations
                          switch (calculatorKeys[index]) {
                            case "C":
                              {
                                currentOp.clear();
                                letAddPoint = true;
                                finalResult = "0";
                              }
                              break;

                            case "+/-":
                              {
                                int lastSignIndex = currentOp.lastIndexWhere(
                                    (element) =>
                                        element == "+" ||
                                        element == "-" ||
                                        element == "x" ||
                                        element == "/");
                                currentOp[lastSignIndex + 1] =
                                    "-${currentOp[lastSignIndex + 1]}";
                              }
                              break;

                            case "%":
                              {
                                // Getting the index of last Operator
                                int lastSignIndex = currentOp.lastIndexWhere(
                                    (element) =>
                                        element == "+" ||
                                        element == "-" ||
                                        element == "x" ||
                                        element == "/");
                                String lastSign = currentOp[lastSignIndex];

                                // Temporarily replacing the last Operator to get the second last
                                currentOp[lastSignIndex] = "~";

                                // Getting the index of Second last Operator
                                int secondLastSignIndex =
                                    currentOp.lastIndexWhere((element) =>
                                        element == "+" ||
                                        element == "-" ||
                                        element == "x" ||
                                        element == "/");

                                // If there is just one operator then secondLastSignIndex will be -1.
                                // So we check if its true then the start index will be 0 since there
                                // are no more signs.
                                secondLastSignIndex = secondLastSignIndex != -1
                                    ? secondLastSignIndex
                                    : 0;

                                // Reassigning the last operator
                                currentOp[lastSignIndex] = lastSign;

                                // Getting the item before and after the operator as itemA and itemB
                                double itemA = double.parse(currentOp
                                    .getRange(
                                        secondLastSignIndex, lastSignIndex)
                                    .join());
                                double itemB = double.parse(currentOp
                                    .getRange(
                                        lastSignIndex + 1, currentOp.length)
                                    .join());

                                // Calculating the percentage
                                double parcentage = (itemA * itemB) / 100;

                                // Splitting and Assigning the parcentage value at last
                                List<String> parcentResult =
                                    "$parcentage".split("");
                                currentOp.replaceRange(lastSignIndex + 1,
                                    currentOp.length, parcentResult);
                                setState(() {});
                              }
                              break;

                            case "DEL":
                              {
                                currentOp.last == "."
                                    ? letAddPoint = true
                                    : null;
                                currentOp.removeLast();
                              }
                              break;

                            case "=":
                              {
                                (currentOp.last == "." ||
                                        currentOp.last == "+" ||
                                        currentOp.last == "-" ||
                                        currentOp.last == "/" ||
                                        currentOp.last == "x")
                                    ? currentOp.removeLast()
                                    : null;

                                setState(() {
                                  List<String> co = [];
                                  co.addAll(currentOp);
                                  finalResult = getResult(co);
                                });
                              }
                              break;

                            default:
                              {
                                // print(currentOp);
                              }
                              break;
                          }
                        }
                      });
                    },
                    borderRadius: BorderRadius.circular(10),
                    splashColor: Colors.greenAccent,
                    child: Ink(
                      decoration: BoxDecoration(
                        color: calculatorKeys[index] == "="
                            ? Colors.green
                            : ['C', '+/-', '%', 'DEL']
                                    .contains(calculatorKeys[index])
                                ? Colors.pink
                                : ['/', 'x', '-', '+']
                                        .contains(calculatorKeys[index])
                                    ? Colors.teal
                                    : Colors.black12,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: calculatorKeys[index] == 'DEL'
                            ? const Icon(
                                Icons.backspace_outlined,
                                color: Colors.white,
                                size: 28,
                              )
                            : calculatorKeys[index] == '/'
                                ? const Icon(
                                    cupertino.CupertinoIcons.divide,
                                    color: Colors.white,
                                    size: 28,
                                  )
                                : calculatorKeys[index] == '-'
                                    ? const Icon(
                                        cupertino.CupertinoIcons.minus,
                                        color: Colors.white,
                                        size: 28,
                                      )
                                    : Text(
                                        calculatorKeys[index],
                                        style: TextStyle(
                                            color: [
                                              'C',
                                              '+/-',
                                              '%',
                                              'DEL',
                                              '/',
                                              'x',
                                              '-',
                                              '+',
                                              '='
                                            ].contains(calculatorKeys[index])
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 30),
                                      ),
                      ),
                    ),
                  );
                }),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  int searchItem(List<String> list, String item) {
    for (int i = 0; i < list.length; i++) {
      if (list[i] == item) return i;
    }
    return -1;
  }

  double partCalculator({
    required String operation,
    required String itemA,
    required String itemB,
  }) {
    double? a = double.tryParse(itemA);
    double? b = double.tryParse(itemB);
    // print("This is from Calculator Fucntion: a:$a,b:$b");
    if (a == null || b == null) {
      return 0;
    } else if (operation == "+") {
      return a + b;
    } else if (operation == "-") {
      return a - b;
    } else if (operation == "x") {
      return a * b;
    } else if (operation == "/") {
      return a / b;
    } else {
      return 0;
    }
  }

  List<String> calculator(List<String> currentOperations, int operator) {
    int start, end;

    // Left side of current sign
    start = operator - 1;
    // print("$currentOperations, index: $a");
    while (start > 0) {
      if (currentOperations[start] == "+" ||
          currentOperations[start] == "-" ||
          currentOperations[start] == "x" ||
          currentOperations[start] == "/") {
        start++;
        break;
      }
      start--;
    }

    // Right side of current sign
    end = operator + 1;
    while (end < currentOperations.length) {
      if (currentOperations[end] == "+" ||
          currentOperations[end] == "-" ||
          currentOperations[end] == "x" ||
          currentOperations[end] == "/") {
        break;
      }
      end++;
    }
    String itemA = currentOperations.getRange(start, operator).join("");
    String itemB = currentOperations.getRange(operator + 1, end).join("");
    String tempRes =
        "${partCalculator(operation: currentOperations[operator], itemA: itemA, itemB: itemB)}";
    currentOperations.replaceRange(start, end, [tempRes]);

    return currentOperations;
  }

  String getResult(List<String> currentOperations) {
    if (!currentOperations.any((element) =>
        element == "+" || element == "-" || element == "x" || element == "/")) {
      return currentOperations.join("");
    }
    for (int i = 0; i < currentOperations.length; i++) {
      if (!currentOperations.any(
        (element) =>
            element == "+" ||
            element == "-" ||
            element == "x" ||
            element == "/",
      )) {
        return currentOperations.join("");
      } else if (currentOperations[i] == "/") {
        currentOperations = calculator(currentOperations, i);
        i = 0;
      } else if (currentOperations[i] == "x") {
        currentOperations = calculator(currentOperations, i);
        i = 0;
      } else if (currentOperations[i] == "-") {
        currentOperations = calculator(currentOperations, i);
        i = 0;
      } else if (currentOperations[i] == "+") {
        currentOperations = calculator(currentOperations, i);
        i = 0;
      }
    }
    return currentOperations[0];
  }
}
