import 'package:calculator/services/firestore.dart';
import 'package:calculator/services/math_functions.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Math with ChangeNotifier {
  String expression = '';
  String result = '';
  double expressionSize = 65;
  double resultSize = 50;
  double widgetHeight = 12;
  double widgetWidth = 4.3;
  bool isVisible = false;
  double fontSize = 23;
  String angleFormat = 'rad';
  bool isButtonEnabled = true;
  int supportPoints = 0;

  void updateExpression(BuildContext context, String buttonText) async {
    if (buttonText == 'C') {
      if (expression.isNotEmpty) {
        expression = expression.substring(0, expression.length - 1);
      }
    }
    else if (buttonText == '=') {
        expressionSize = 65;
        resultSize = 50;
        result = MathFunctions.calculate(expression, result, angleFormat).toString();
      if (double.parse(result) == (double.parse(result)).toInt()) {
        result = double.parse(result).toInt().toString();
      }
      supportPoints += 2;
    }
    else if (buttonText == '/>') {
      if (!isVisible) {
        widgetHeight = 15;
        widgetWidth = 5.5;
        fontSize = 20;
        isVisible = !isVisible;
      }
      else {
        widgetHeight = 12;
        widgetWidth = 4.3;
        fontSize = 23;
        isVisible = !isVisible;
      }
    }
    else if (buttonText == '👌') {
      var snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          //Todo Change Background Color
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {

            },
          ),
          content: GestureDetector(
            onTap: () async {
              const url = 'https://play.google.com/store/apps/details?id=com.king.calculator';
              if (await canLaunch(url)) {
              await launch(url);
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Rate Us on App Store?', style: TextStyle(fontSize: 15)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text('Rate!!', style: TextStyle(fontSize: 16,
                      decoration: TextDecoration.underline,
                      color: Colors.greenAccent)),
                ),
              ],
            ),
          ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    else if (buttonText == angleFormat) {
      if (angleFormat == 'rad') {
        angleFormat = 'deg';
      }
      else {
        angleFormat = 'rad';
      }
    }
    else {
      if(buttonText == 'x!'){
        buttonText = '!';
      }
      else if(buttonText == 'x⁻¹'){
        buttonText = '⁻';
      }
      else if(buttonText == '√x'){
        buttonText = '√';
      }
      expression += buttonText;
    }
    notifyListeners();
  }

  void updateExpressionLongPressed(String buttonText) {
    if (buttonText == 'C') {
      expression = '';
      result = '';
      expressionSize = 65;
      resultSize = 50;
    }
    else if (buttonText == '=') {
      result = MathFunctions.calculate(expression, result, angleFormat).toString();
      if (double.parse(result) == (double.parse(result)).toInt()) {
        result = double.parse(result).toInt().toString();
      }
      expressionSize = 50;
      resultSize = 65;
      supportPoints += 2;
    }
    else if(int.parse(buttonText) >= 0 && int.parse(buttonText) <= 9){
      buttonText = '$buttonText$buttonText$buttonText';
      expression += buttonText;
    }
    notifyListeners();
  }

  updatePoints() async {
    FirestoreDatabase database = FirestoreDatabase();
    await database.removePoint(supportPoints);
    supportPoints = 0;
    notifyListeners();
  }
}