import 'package:flutter/material.dart';

class UtilManager {
  double bmiCalc({required List<String> height, required List<String> weight}) {
    double heightValue;
    double weightValue;
    if (height.length == 2 && weight.length == 2) {
      heightValue = double.parse(height[0]);
      weightValue = double.parse(weight[0]);
      height[1] == "cm" ? heightValue = heightValue / 100 : heightValue;
      weight[1] == "lb" ? weightValue = weightValue / 2.20462 : null;
      double bmiValue = double.parse(
          (weightValue / (heightValue * heightValue)).toStringAsFixed(2));
      return bmiValue;
    } else if (height.length == 1 && weight.length == 1) {
      heightValue = double.parse(height[0]);
      weightValue = double.parse(weight[0]);
      double bmiValue = double.parse(
          (weightValue / (heightValue * heightValue)).toStringAsFixed(2));
      return bmiValue;
    } else if (height.length == 2 && weight.length == 1) {
      heightValue = double.parse(height[0]);
      weightValue = double.parse(weight[0]);
      height[1] == "cm" ? heightValue = heightValue / 100 : heightValue;
      double bmiValue = double.parse(
          (weightValue / (heightValue * heightValue)).toStringAsFixed(2));
      return bmiValue;
    }
    return 0;
  }

  List<String> separateNumbersAndChars(String input) {
    List<String> transformedValue = [];
    if (input.contains("'")) {
      List tempValue = input.split("");
      tempValue.remove('''"''');
      tempValue.remove("'");
      double toCM = ((double.parse(tempValue[0]) * 12) +
              double.parse(tempValue.length == 1 ? "0" : tempValue[1])) *
          2.54;
      transformedValue = ["$toCM", "cm"];
      return transformedValue;
    } else {
      // Regular expressions to match numbers and alphabetic characters
      RegExp numberPattern = RegExp(r'[\d.]+');
      RegExp charPattern = RegExp(r'[a-zA-Z]+');

      // Find all matches of numbers in the input string
      Iterable<Match> numberMatches = numberPattern.allMatches(input);

      // Find all matches of alphabetic characters in the input string
      Iterable<Match> charMatches = charPattern.allMatches(input);

      // Extract numbers from matches
      List<String> numbers =
          numberMatches.map((match) => match.group(0)!).toList();

      // Extract alphabetic characters from matches
      List<String> chars = charMatches.map((match) => match.group(0)!).toList();

      // Print the separated numbers and characters
      return numbers + chars;
    }
  }

  Widget customListTile({
    required IconData leadingIcon,
    required String title,
    required Function()? onTap,
    Color tileColor = Colors.black54,
    double iconSize = 28,
    double horizontalPadding = 5,
    double verticalPadding = 0,
    Color iconColor = Colors.white,
    double titleSize = 18,
    Color? textColor = Colors.white,
    double borderRadius = 15,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: ListTile(
        leading: Icon(
          leadingIcon,
          size: iconSize,
          color: iconColor,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: titleSize,
            color: textColor,
          ),
        ),
        tileColor: tileColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius)),
        onTap: onTap,
      ),
    );
  }

  Widget customTextField({
    String? hintText,
    String? labelText,
    required TextEditingController controller,
    Function(String)? onChanged,
    Color focusedColor = Colors.blue,
    Color fillColor = Colors.white,
    Color enabledBorderColor = Colors.black,
    Color hintColor = Colors.black,
    Color labelColor = Colors.black,
    Color textColor = Colors.black,
    var validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    // bool buttonPressed = false;
    return SizedBox(
      child: TextFormField(
        controller: controller,
        validator: validator,
        style: TextStyle(
          color: textColor,
          fontSize: 16,
        ),
        onChanged: onChanged,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 2,
            horizontal: 15,
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.2,
              color: Colors.white,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.2,
              color: focusedColor,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.2,
              color: enabledBorderColor,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          labelText: labelText,
          labelStyle: TextStyle(color: labelColor),
          hintText: hintText,
          hintStyle: TextStyle(color: hintColor),
        ),
      ),
    );
  }

  Widget customRadio(
      {required String title,
      required Object value,
      required Object? groupValue,
      required onChanged}) {
    return SizedBox(
      width: 80,
      height: 50,
      child: RadioListTile(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        contentPadding: const EdgeInsets.all(0),
        dense: true,
        selected: value == groupValue,
        visualDensity: const VisualDensity(horizontal: -4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        selectedTileColor: Colors.green,
        activeColor: Colors.white,
        tileColor: Colors.blueAccent,
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
    );
  }
}
