import 'package:calculator/services/firestore.dart';
import 'package:calculator/services/math_functions.dart';
import 'package:flutter/material.dart';

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

  void updateExpression(BuildContext context, String buttonText) async {
    FirestoreDatabase database = FirestoreDatabase();
    if (buttonText == 'C') {
      if (expression.isNotEmpty) {
        expression = expression.substring(0, expression.length - 1);
      }
      notifyListeners();
    }
    else if (buttonText == '=') {
      int point = await database.fetchData();
      if(point > 0){
        expressionSize = 65;
        resultSize = 50;
        result = MathFunctions.calculate(expression, result, angleFormat).toString();
      if (double.parse(result) == (double.parse(result)).toInt()) {
        result = double.parse(result).toInt().toString();
      }
      await database.removePoint();
      }
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
      notifyListeners();
    }
    else if (buttonText == '👌') {
      var snackBar = SnackBar(
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {

            },
          ),
          content: GestureDetector(
            onTap: () {
              print('App Store! Yay!');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Rate Us on App Store?', style: TextStyle(fontSize: 15)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text('Rate!!', style: TextStyle(fontSize: 16,
                      decoration: TextDecoration.underline,
                      color: Colors.greenAccent)),
                ),
              ],
            ),
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    else if (buttonText == angleFormat) {
      if (angleFormat == 'rad') {
        angleFormat = 'deg';
      }
      else {
        angleFormat = 'rad';
      }
      notifyListeners();
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
    notifyListeners();
  }
}