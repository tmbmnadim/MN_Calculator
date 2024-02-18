import 'package:flutter/material.dart';
import 'package:mn_calculator/pages/utils.dart';

class CGPACalculator extends StatefulWidget {
  const CGPACalculator({super.key});

  @override
  State<CGPACalculator> createState() => _CGPACalculatorState();
}

class _CGPACalculatorState extends State<CGPACalculator> {
  String selectedSector = "Diploma";
  UtilManager um = UtilManager();
  double cgpa = 0;
  TextEditingController sem1 = TextEditingController();
  TextEditingController sem2 = TextEditingController();
  TextEditingController sem3 = TextEditingController();
  TextEditingController sem4 = TextEditingController();
  TextEditingController sem5 = TextEditingController();
  TextEditingController sem6 = TextEditingController();
  TextEditingController sem7 = TextEditingController();
  TextEditingController sem8 = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    validator(value) {
      if (value == null || value.isEmpty) {
        return 'Please enter some text';
      } else if (double.tryParse(value)! > 4) {
        return 'Valid range is 0-4';
      }
      return null;
    }

    return SingleChildScrollView(
      child: SizedBox(
        width: screenSize.width,
        height: 900,
        child: Column(
          children: [
            dropDownMenu(),
            const SizedBox(height: 8),
            SizedBox(
              height: 580,
              width: screenSize.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      um.customTextField(
                        controller: sem1,
                        labelText: "First Semester",
                        focusedColor: Colors.green,
                        hintText: "4.00",
                        keyboardType: TextInputType.number,
                        validator: validator,
                      ),
                      const SizedBox(height: 8),
                      um.customTextField(
                        controller: sem2,
                        labelText: "Second Semester",
                        focusedColor: Colors.green,
                        hintText: "4.00",
                        keyboardType: TextInputType.number,
                        validator: validator,
                      ),
                      const SizedBox(height: 8),
                      um.customTextField(
                        controller: sem3,
                        labelText: "Third Semester",
                        focusedColor: Colors.green,
                        hintText: "4.00",
                        keyboardType: TextInputType.number,
                        validator: validator,
                      ),
                      const SizedBox(height: 8),
                      um.customTextField(
                        controller: sem4,
                        labelText: "Fourth Semester",
                        focusedColor: Colors.green,
                        hintText: "4.00",
                        keyboardType: TextInputType.number,
                        validator: validator,
                      ),
                      const SizedBox(height: 8),
                      um.customTextField(
                        controller: sem5,
                        labelText: "Fifth Semester",
                        focusedColor: Colors.green,
                        hintText: "4.00",
                        keyboardType: TextInputType.number,
                        validator: validator,
                      ),
                      const SizedBox(height: 8),
                      um.customTextField(
                        controller: sem6,
                        labelText: "Sixth Semester",
                        focusedColor: Colors.green,
                        hintText: "4.00",
                        keyboardType: TextInputType.number,
                        validator: validator,
                      ),
                      const SizedBox(height: 8),
                      um.customTextField(
                        controller: sem7,
                        labelText: "Seventh Semester",
                        focusedColor: Colors.green,
                        hintText: "4.00",
                        keyboardType: TextInputType.number,
                        validator: validator,
                      ),
                      const SizedBox(height: 8),
                      um.customTextField(
                        controller: sem8,
                        labelText: "Eighth Semester",
                        focusedColor: Colors.green,
                        hintText: "4.00",
                        keyboardType: TextInputType.number,
                        validator: validator,
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                countCGPA();
                              });
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black54,
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 25,
                          ),
                          textStyle: const TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                        child: const Text(
                          "Calculate CGPA",
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                alignment: Alignment.center,
                height: 130,
                width: screenSize.width,
                decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "CGPA: ${cgpa.toStringAsFixed(2)}",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void countCGPA() {
    if (selectedSector == "Diploma") {
      cgpa = double.parse(sem1.text) * (5 / 100) +
          double.parse(sem2.text) * (5 / 100) +
          double.parse(sem3.text) * (5 / 100) +
          double.parse(sem4.text) * (10 / 100) +
          double.parse(sem5.text) * (15 / 100) +
          double.parse(sem6.text) * (20 / 100) +
          double.parse(sem7.text) * (25 / 100) +
          double.parse(sem8.text) * (15 / 100);
    }
  }

  Widget dropDownMenu() {
    return SizedBox(
      height: 90,
      width: 450,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            alignment: Alignment.center,
            width: 130,
            height: 55,
            decoration: BoxDecoration(
                color: Colors.black54, borderRadius: BorderRadius.circular(3)),
            child: const Text(
              "Your Sector: ",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          DropdownMenu(
            initialSelection: selectedSector,
            trailingIcon: const Icon(
              Icons.expand_circle_down_outlined,
              size: 30,
              color: Colors.white,
            ),
            textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            inputDecorationTheme: const InputDecorationTheme(
              filled: true,
              fillColor: Colors.black54,
            ),
            menuStyle: const MenuStyle(
              backgroundColor: MaterialStatePropertyAll(
                Colors.white,
              ),
              elevation: MaterialStatePropertyAll(8),
              maximumSize: MaterialStatePropertyAll(Size(250, 250)),
            ),
            dropdownMenuEntries: const [
              DropdownMenuEntry(
                value: "Diploma",
                label: "Diploma",
              ),
              // DropdownMenuEntry(
              //   value: "BSc",
              //   label: "Bachelor in Science",
              // ),
              // DropdownMenuEntry(
              //   value: "BA",
              //   label: "Bachelor in Arts",
              // ),
            ],
            onSelected: (value) {
              selectedSector = value!;
            },
          ),
        ],
      ),
    );
  }
}
