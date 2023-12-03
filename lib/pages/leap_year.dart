import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mn_calculator/pages/utils.dart';

class LeapYearCalculator extends StatefulWidget {
  const LeapYearCalculator({super.key});

  @override
  State<LeapYearCalculator> createState() => _LeapYearCalculatorState();
}

class _LeapYearCalculatorState extends State<LeapYearCalculator> {
  final TextEditingController _leapYearStartController =
      TextEditingController();
  final TextEditingController _leapYearFinishController =
      TextEditingController();
  bool leapYearMul = true;
  List<int> leapYears = [];
  UtilManager um = UtilManager();

  @override
  void initState() {
    super.initState();
    _leapYearStartController.text.isEmpty ? leapYears.clear() : null;
    _leapYearFinishController.text.isEmpty ? leapYears.clear() : null;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10),
        height: screenSize.height * 0.9,
        width: screenSize.width,
        child: Column(
          children: [
            /// Title Bar
            Container(
              alignment: Alignment.center,
              height: 50,
              width: screenSize.width,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "Leap Year Calculator",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
            const SizedBox(height: 10),

            /// Option Bar
            Container(
              alignment: Alignment.center,
              height: 50,
              width: screenSize.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        leapYearMul = false;
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      elevation: leapYearMul ? 5 : 0,
                      side: BorderSide(
                        width: leapYearMul ? 1 : 0,
                        color: leapYearMul ? Colors.black : Colors.green,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: const Radius.circular(10),
                          bottom: Radius.circular(leapYearMul ? 10 : 0),
                        ),
                      ),
                      minimumSize: const Size(170, 100),
                      backgroundColor:
                          leapYearMul ? Colors.white : Colors.green,
                    ),
                    child: Text(
                      "Single",
                      style: TextStyle(
                        color: leapYearMul ? Colors.black : Colors.white,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        leapYearMul = true;
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      elevation: leapYearMul ? 0 : 5,
                      side: BorderSide(
                        width: leapYearMul ? 0 : 1,
                        color: leapYearMul ? Colors.green : Colors.black,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10),
                          bottom: Radius.circular(leapYearMul ? 0 : 10),
                        ),
                      ),
                      minimumSize: const Size(170, 100),
                      backgroundColor:
                          leapYearMul ? Colors.green : Colors.white,
                    ),
                    child: Text(
                      "Range",
                      style: TextStyle(
                        color: leapYearMul ? Colors.white : Colors.black,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (leapYearMul)

              /// Range of Years
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(5),
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    um.customTextField(
                      focusedColor: Colors.white,
                      enabledBorderColor: Colors.white60,
                      textColor: Colors.black,
                      keyboardType: TextInputType.number,
                      hintColor: const Color.fromRGBO(0, 0, 0, 50),
                      controller: _leapYearStartController,
                      hintText: "Start of range",
                    ),
                    const SizedBox(height: 5),
                    um.customTextField(
                      focusedColor: Colors.white,
                      enabledBorderColor: Colors.white60,
                      textColor: Colors.black,
                      keyboardType: TextInputType.number,
                      hintColor: const Color.fromRGBO(0, 0, 0, 50),
                      controller: _leapYearFinishController,
                      hintText: "End of range",
                    ),
                  ],
                ),
              ),
            if (!leapYearMul)

              /// Single Year
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(5),
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    um.customTextField(
                      focusedColor: Colors.white,
                      enabledBorderColor: Colors.white60,
                      textColor: Colors.black,
                      keyboardType: TextInputType.number,
                      hintColor: const Color.fromRGBO(0, 0, 0, 50),
                      controller: _leapYearStartController,
                      hintText: "Which year do you want to check?",
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                setState(() {
                  if (_leapYearStartController.text.isEmpty ||
                      _leapYearFinishController.text.isEmpty) {
                    leapYears = [];
                  } else {
                    leapYears = leapYear(
                      start: int.tryParse(_leapYearStartController.text),
                      finish: int.tryParse(_leapYearFinishController.text),
                    );
                  }
                });
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(width: 1),
                minimumSize: const Size(170, 50),
                maximumSize: const Size(200, 60),
                backgroundColor: Colors.green,
              ),
              child: const Text(
                "Get Result",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Stack(
              children: [
                Container(
                  width: screenSize.width,
                  height: leapYearMul
                      ? screenSize.height * 0.5
                      : screenSize.height * 0.15,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: leapYearMul
                      ? GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 2 / 1,
                            crossAxisCount: 4,
                          ),
                          padding: const EdgeInsets.fromLTRB(5, 60, 5, 5),
                          itemCount: leapYears.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(2),
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "${leapYears[index]}",
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        )
                      : Text(
                          leapYears.isNotEmpty &&
                                  leapYears[0] ==
                                      int.tryParse(
                                          _leapYearStartController.text)
                              ? "It is a leap year"
                              : "No it is not a leap year.",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                          ),
                        ),
                ),
                if (leapYearMul)
                  Positioned(
                    right: 10,
                    top: 10,
                    child: OutlinedButton(
                      onPressed: () {
                        Clipboard.setData(
                            ClipboardData(text: leapYears.toString()));
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(width: 1),
                        minimumSize: const Size(40, 40),
                        maximumSize: const Size(50, 50),
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                      ),
                      child: const Icon(
                        Icons.copy,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  )
              ],
            )
          ],
        ),
      ),
    );
  }

  bool isLeapYear(int year) {
    return !((year % 400 != 0 && year % 100 == 0) || year % 4 != 0);
  }

  List<int> leapYear({required int? start, required int? finish}) {
    if (start != null && finish != null) {
      List<int> leapYear = [];
      for (int i = start; i <= finish; i++) {
        if (isLeapYear(i)) {
          leapYear.add(i);
        }
      }
      return leapYear;
    } else if (start != null && finish == null) {
      if (isLeapYear(start)) {
        return [start];
      }
    }
    return [0];
  }
}
