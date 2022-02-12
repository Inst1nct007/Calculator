import 'dart:math';

class MathFunctions{
  static String calculate(String expression, String result, String angleFormat){
    var numbers = [];
    var operators = [];
    RegExp re;

    try{
      re = RegExp('[^0-9.]');
      numbers = expression.split(re);

      for(int i = 0; i < numbers.length; i++){
        if(!numbers.remove('')){
          break;
        }
      }

      result = numbers[0];
      re = RegExp('[0-9(). ]');
      operators = expression.split(re);

      numbers.removeWhere((number) => number == '' || number == '--' || number == '+-' || number == '-+');
      operators.removeWhere((operator) => operator == '' || operator == '--' || operator == '+-' || operator == '-+');

      while ((numbers.length > 1) || operators.isNotEmpty) {
        for (int i = 0; i < operators.length; i++) {
          if (operators[i] == '⁻') {
            numbers[i] = (1 / double.parse(numbers[i])).toString();
            if (operators.isNotEmpty) {
              operators.removeAt(i);
            }
          }
        }

        for (int i = 0; i < operators.length; i++) {
          if (operators[i] == '√') {
            numbers[i] = sqrt(double.parse(numbers[i])).toString();
            if (operators.isNotEmpty) {
              operators.removeAt(i);
            }
          }
        }

        for (int i = 0; i < operators.length; i++) {
          if (operators[i] == 'ln') {
            numbers[i] = log(double.parse(numbers[i])).toString();
            if (operators.isNotEmpty) {
              operators.removeAt(i);
            }
          }
        }

        for (int i = 0; i < operators.length; i++) {
          if (operators[i] == 'log') {
            numbers[i] =
                (log(double.parse(numbers[i])) * 0.434294189774).toString();
            if (operators.isNotEmpty) {
              operators.removeAt(i);
            }
          }
        }

        for (int i = 0; i < operators.length; i++) {
          if (operators[i] == 'sin') {
            numbers[i] = sin(double.parse(numbers[i]) * (angleFormat == 'rad' ? 1 : pi / 180)).toString();
            if (operators.isNotEmpty) {
              operators.removeAt(i);
            }
          }
        }

        for (int i = 0; i < operators.length; i++) {
          if (operators[i] == 'cos') {
            numbers[i] = cos(double.parse(numbers[i]) * (angleFormat == 'rad' ? 1 : pi / 180)).toString();
            if (operators.isNotEmpty) {
              operators.removeAt(i);
            }
          }
        }
        for (int i = 0; i < operators.length; i++) {
          if (operators[i] == 'tan') {
            numbers[i] = tan(double.parse(numbers[i]) * (angleFormat == 'rad' ? 1 : pi / 180)).toString();
            if (operators.isNotEmpty) {
              operators.removeAt(i);
            }
          }
        }

        for (int i = 0; i < operators.length; i++) {
          if (operators[i] == '!') {
            numbers[i] = factorial(int.parse(numbers[i])).toString();
            if (operators.isNotEmpty) {
              operators.removeAt(i);
            }
          }
        }

        for (int i = 0; i < operators.length; i++) {
          if (operators[i] == '^') {
            numbers[i] =
                pow(double.parse(numbers[i]), double.parse(numbers[i + 1]))
                    .toString();
            numbers.removeAt(i + 1);
            if (operators.isNotEmpty) {
              operators.removeAt(i);
            }
            i--;
          }
        }

        for (int i = 0; i < operators.length; i++) {
          if (operators[i] == '/') {
            numbers[i] =
                (double.parse(numbers[i]) / double.parse(numbers[i + 1]))
                    .toString();
            numbers.removeAt(i + 1);
            if (operators.isNotEmpty) {
              operators.removeAt(i);
            }
            i--;
          }
        }

        for (int i = 0; i < operators.length; i++) {
          if (operators[i] == 'x') {
            numbers[i] =
                (double.parse(numbers[i]) * double.parse(numbers[i + 1]))
                    .toString();
            numbers.removeAt(i + 1);
            if (operators.isNotEmpty) {
              operators.removeAt(i);
            }
            i--;
          }
        }

        for (int i = 0; i < operators.length; i++) {
          if (operators[i] == '-') {
            numbers[i] = (double.parse(numbers[i]) - double.parse(numbers[i + 1])).toString();
            numbers.removeAt(i + 1);
            if (operators.isNotEmpty) {
              operators.removeAt(i);
            }
            i--;
          }
        }

        for (int i = 0; i < operators.length; i++) {
          if (operators[i] == '+') {
            numbers[i] =
                (double.parse(numbers[i]) + double.parse(numbers[i + 1]))
                    .toString();
            numbers.removeAt(i + 1);
            if (operators.isNotEmpty) {
              operators.removeAt(i);
            }
            i--;
          }
        }
      }
      numbers[0] = double.parse(numbers[0]).toString();
    }
    catch(e){
      result = ':(';
    }
    return numbers[0];
  }

  static int factorial(int number){
    if(number != 0){
      return number * factorial(number - 1);
    }
    else{
      return 1;
    }
  }
}