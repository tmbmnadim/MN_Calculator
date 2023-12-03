import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:mn_calculator/pages/utils.dart';

class BMICalculator extends StatefulWidget {
  const BMICalculator({super.key});

  @override
  State<BMICalculator> createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  String tableValue = "Underweight";
  UtilManager um = UtilManager();

  @override
  void dispose() {
    super.dispose();
    _heightController.dispose();
    _weightController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    double bmiCal = um.bmiCalc(
      height: um.separateNumbersAndChars(_heightController.text),
      weight: um.separateNumbersAndChars(_weightController.text),
    );
    if (bmiCal < 18.5) {
      tableValue = "Underweight";
    } else if (bmiCal >= 18.5 && bmiCal < 25) {
      tableValue = "Normal weight";
    } else if (bmiCal >= 25 && bmiCal < 30) {
      tableValue = "Overweight";
    } else if (bmiCal >= 30 && bmiCal < 35) {
      tableValue = "Obese (Class I)";
    } else if (bmiCal >= 35 && bmiCal < 40) {
      tableValue = "Obese (Class II)";
    } else {
      tableValue = "Obese (Class III)";
    }

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10),
        height: screenSize.height * 0.9,
        width: screenSize.width,
        child: Column(
          children: [
            SfRadialGauge(
              axes: [
                RadialAxis(minimum: 0, maximum: 50, ranges: <GaugeRange>[
                  GaugeRange(
                    startValue: 0,
                    endValue: 18.4,
                    color: Colors.blue,
                  ),
                  GaugeRange(
                    startValue: 18.5,
                    endValue: 24.9,
                    color: Colors.green,
                  ),
                  GaugeRange(
                    startValue: 25,
                    endValue: 29.9,
                    color: Colors.orange,
                  ),
                  GaugeRange(
                    startValue: 30,
                    endValue: 34.9,
                    color: Colors.redAccent,
                  ),
                  GaugeRange(
                    startValue: 35,
                    endValue: 39.9,
                    color: Colors.red,
                  ),
                  GaugeRange(
                    startValue: 40,
                    endValue: 50,
                    color: Colors.purple,
                  )
                ], pointers: <GaugePointer>[
                  NeedlePointer(value: bmiCal)
                ], annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                      widget: Text(
                        'BMI: $bmiCal\n$tableValue',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      angle: 90,
                      positionFactor: 0.5)
                ])
              ],
            ),
            const SizedBox(height: 10),
            um.customTextField(
              controller: _weightController,
              labelText: "Weight",
              hintText: "ex: 86kg",
            ),
            const SizedBox(height: 5),
            um.customTextField(
              controller: _heightController,
              labelText: "Height",
              hintText: '''ex: 6'1" or 180cm''',
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                setState(() {});
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              ),
              child: const Text(
                "Get Result",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
