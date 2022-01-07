import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:google_fonts/google_fonts.dart';

import 'dart:math';

import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CalculatorApp();
  }
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> with WidgetsBindingObserver {

  String expression = '';
  String result = '';
  double expressionFontSize = 58.0;
  double resultFontSize = 48.0;
  var numbers = [];
  var operators = [];
  var re;
  bool isVisible = false;
  double buttonSize = 70;
  String angleFormat = 'rad';
  bool isRad = true;
  double deg = 1;
  bool isButtonDisabled = false;

  int factorial(int number){
    if(number != 0){
      return number * factorial(number - 1);
    }
    else{
      return 1;
    }
  }


  buttonPressed(String buttonText){
    SystemSound.play(SystemSoundType.click);
    setState(() {
      if(buttonText.toUpperCase() == 'C'){
        try{
          if(expression != '0') {
            expression = expression.substring(0, expression.length - 1);
          }
        }
        catch(e){
          null;
        }
      }
      else if(buttonText == '='){
        try{
          re = RegExp('[^0-9.-]');
          numbers = expression.split(re);
          for(int i = 0; i < numbers.length; i++){
            if(!numbers.remove('')){
              break;
            }
          }
          result = numbers[0];
          re = RegExp('[0-9(). ]');
          operators = expression.split(re);

          numbers.removeWhere((number) => number == '' || number == '-' || number == '--' || number == '+-' || number == '-+');
          operators.removeWhere((operator) => operator == '');

          for(int i = 0; i < operators.length; i++){
            if(operators[i] == '--' || operators[i] == '++'){
              operators[i] = '+';
            }
            else if(operators[i] == '+-' || operators[i] == '-+'){
              operators[i] = '-';
            }
            else if(operators[i] == '-'){
              if(i == 0){
                operators[i] = '+';
              }
              else{
                if(operators[i-1] != '^'){
                  operators[i] = '+';
                }
                else{
                  operators.removeAt(i);
                }
              }
            }
          }

            while((numbers.length > 1) || operators.isNotEmpty){
              for(int i = 0; i < operators.length; i++){
                if(operators[i] == '√'){
                    numbers[i] = sqrt(double.parse(numbers[i])).toString();
                  if(operators.isNotEmpty){
                    operators.removeAt(i);
                  }
                }
              }

              for(int i = 0; i < operators.length; i++){
                if(operators[i] == 'ln'){
                    numbers[i] = log(double.parse(numbers[i])).toString();
                  if(operators.isNotEmpty){
                    operators.removeAt(i);
                  }
                }
              }

              for(int i = 0; i < operators.length; i++){
                if(operators[i] == 'log'){
                    numbers[i] = (log(double.parse(numbers[i])) * 0.434294189774).toString();
                  if(operators.isNotEmpty){
                    operators.removeAt(i);
                  }
                }
              }

              for(int i = 0; i < operators.length; i++){
                if(operators[i] == 'sin' && !isButtonDisabled){
                  numbers[i] = sin(double.parse(numbers[i])).toString();
                  if(operators.isNotEmpty){
                    operators.removeAt(i);
                  }
                }
                else if(operators[i] == 'sin' && isButtonDisabled){
                  numbers[i] = asin(double.parse(numbers[i])).toString();
                  if(operators.isNotEmpty){
                    operators.removeAt(i);
                  }
                }
              }

              for(int i = 0; i < operators.length; i++){
                if(operators[i] == 'cos' && !isButtonDisabled){
                  numbers[i] = cos(double.parse(numbers[i])).toString();
                  if(operators.isNotEmpty){
                    operators.removeAt(i);
                  }
                }
                else if(operators[i] == 'cos' && isButtonDisabled){
                  numbers[i] = acos(double.parse(numbers[i])).toString();
                  if(operators.isNotEmpty){
                    operators.removeAt(i);
                  }
                }
              }

              for(int i = 0; i < operators.length; i++){
                if(operators[i] == 'tan' && !isButtonDisabled){
                  numbers[i] = tan(double.parse(numbers[i])).toString();
                  if(operators.isNotEmpty){
                    operators.removeAt(i);
                  }
                }
                else if(operators[i] == 'tan' && isButtonDisabled){
                  numbers[i] = atan(double.parse(numbers[i])).toString();
                  if(operators.isNotEmpty){
                    operators.removeAt(i);
                  }
                }
              }

              for(int i = 0; i < operators.length; i++){
                if(operators[i] == '!'){
                  numbers[i] = factorial(int.parse(numbers[i])).toString();
                  if(operators.isNotEmpty){
                    operators.removeAt(i);
                  }
                }
              }

              for(int i = 0; i < operators.length; i++){
                if(operators[i] == '^'){
                  numbers[i] = pow(double.parse(numbers[i]), double.parse(numbers[i+1])).toString();
                  numbers.removeAt(i+1);
                  if(operators.isNotEmpty){
                    operators.removeAt(i);
                  }
                  i--;
                }
              }

              for(int i = 0; i < operators.length; i++){
                if(operators[i] == '/'){
                  numbers[i] = (double.parse(numbers[i]) / double.parse(numbers[i+1])).toString();
                  numbers.removeAt(i+1);
                  if(operators.isNotEmpty){
                    operators.removeAt(i);
                  }
                  i--;
                }
              }

              for(int i = 0; i < operators.length; i++){
                if(operators[i] == 'x'){
                  numbers[i] = (double.parse(numbers[i]) * double.parse(numbers[i+1])).toString();
                  numbers.removeAt(i+1);
                  if(operators.isNotEmpty){
                    operators.removeAt(i);
                  }
                  i--;
                }
              }

              for(int i = 0; i < operators.length; i++){
                if(operators[i] == '-'){
                  numbers[i] = (double.parse(numbers[i]) - double.parse(numbers[i+1])).toString();
                  numbers.removeAt(i+1);
                  if(operators.isNotEmpty){
                    operators.removeAt(i);
                  }
                  i--;
                }
              }

              for(int i = 0; i < operators.length; i++){
                if(operators[i] == '+'){
                  numbers[i] = (double.parse(numbers[i]) + double.parse(numbers[i+1])).toString();
                  numbers.removeAt(i+1);
                  if(operators.isNotEmpty){
                    operators.removeAt(i);
                  }
                  i--;
                }
              }

            }

            numbers[0] = double.parse(numbers[0]).toString();
            if(double.parse(numbers[0]) == (double.parse(numbers[0])).toInt()){
              numbers[0] = double.parse(numbers[0]).toInt().toString();
            }
            result = numbers[0];
        }
        catch(e){
          result = ':(';
        }

        expressionFontSize = 48.0;
        resultFontSize = 58.0;
      }

      else if(buttonText == '/>'){
        isVisible = !isVisible;
        if(isVisible == true){
          buttonSize = 60;
        }
        else{
          buttonSize = 70;
        }
      }

      else if(buttonText == 'sin' || buttonText == '   -1 sin'){
        expression += ' sin';
      }

      else if(buttonText == 'cos' || buttonText == '   -1 cos'){
        expression += ' cos';
      }

      else if(buttonText == 'tan' || buttonText == '   -1 tan'){
        expression += ' tan';
      }

      else if(buttonText == 'ln'){
        expression += ' ln';
      }

      else if(buttonText == 'log'){
        expression += ' log';
      }

      else{
        if(buttonText == '0' || buttonText == '00'){
          if(expression != '0'){
          expression += buttonText;
          }
        }
        else if(buttonText == '🌟'){

        }

        else if(!(buttonText.codeUnitAt(0) >= 48 && buttonText.codeUnitAt(0) <= 57) && buttonText != '.'){
          try{
            if((buttonText == '-' || buttonText == '+') && (expression[expression.length - 1] == '-') || expression[expression.length - 1] == '+'){
              expression += buttonText + ' ';
            }
            else{
              expression += ' ' + buttonText;
            }
          }
          catch(e){
            expression += buttonText;
          }
        }

        else{
          expression += buttonText;
        }
      }
    });
  }

  buttonLongPress(String buttonText){
    HapticFeedback.heavyImpact();
    setState(() {
      if(buttonText.toUpperCase() == 'C'){
        expression = '';
        result = '';
      }
      else if(buttonText == '='){
        try{
          re = RegExp('[^0-9.-]');
          numbers = expression.split(re);
          for(int i = 0; i < numbers.length; i++){
            if(!numbers.remove('')){
              break;
            }
          }
          result = numbers[0];
          re = RegExp('[0-9(). ]');
          operators = expression.split(re);

          numbers.removeWhere((number) => number == '' || number == '-' || number == '--' || number == '+-' || number == '-+');
          operators.removeWhere((operator) => operator == '');

          for(int i = 0; i < operators.length; i++){
            if(operators[i] == '--' || operators[i] == '++'){
              operators[i] = '+';
            }
            else if(operators[i] == '+-' || operators[i] == '-+'){
              operators[i] = '-';
            }
            else if(operators[i] == '-'){
              if(i == 0){
                operators[i] = '+';
              }
              else{
                if(operators[i-1] != '^'){
                  operators[i] = '+';
                }
                else{
                  operators.removeAt(i);
                }
              }
            }
          }

          while((numbers.length > 1) || operators.isNotEmpty){
            for(int i = 0; i < operators.length; i++){
              if(operators[i] == '√'){
                numbers[i] = sqrt(double.parse(numbers[i])).toString();
                if(operators.isNotEmpty){
                  operators.removeAt(i);
                }
              }
            }

            for(int i = 0; i < operators.length; i++){
              if(operators[i] == 'ln'){
                numbers[i] = log(double.parse(numbers[i])).toString();
                if(operators.isNotEmpty){
                  operators.removeAt(i);
                }
              }
            }

            for(int i = 0; i < operators.length; i++){
              if(operators[i] == 'log'){
                numbers[i] = (log(double.parse(numbers[i])) * 0.434294189774).toString();
                if(operators.isNotEmpty){
                  operators.removeAt(i);
                }
              }
            }

            for(int i = 0; i < operators.length; i++){
              if(operators[i] == 'sin' && !isButtonDisabled){
                numbers[i] = sin(double.parse(numbers[i])).toString();
                if(operators.isNotEmpty){
                  operators.removeAt(i);
                }
              }
              else if(operators[i] == 'sin' && isButtonDisabled){
                numbers[i] = asin(double.parse(numbers[i])).toString();
                if(operators.isNotEmpty){
                  operators.removeAt(i);
                }
              }
            }

            for(int i = 0; i < operators.length; i++){
              if(operators[i] == 'cos' && !isButtonDisabled){
                numbers[i] = cos(double.parse(numbers[i])).toString();
                if(operators.isNotEmpty){
                  operators.removeAt(i);
                }
              }
              else if(operators[i] == 'cos' && isButtonDisabled){
                numbers[i] = acos(double.parse(numbers[i])).toString();
                if(operators.isNotEmpty){
                  operators.removeAt(i);
                }
              }
            }

            for(int i = 0; i < operators.length; i++){
              if(operators[i] == 'tan' && !isButtonDisabled){
                numbers[i] = tan(double.parse(numbers[i])).toString();
                if(operators.isNotEmpty){
                  operators.removeAt(i);
                }
              }
              else if(operators[i] == 'tan' && isButtonDisabled){
                numbers[i] = atan(double.parse(numbers[i])).toString();
                if(operators.isNotEmpty){
                  operators.removeAt(i);
                }
              }
            }

            for(int i = 0; i < operators.length; i++){
              if(operators[i] == '!'){
                numbers[i] = factorial(int.parse(numbers[i])).toString();
                if(operators.isNotEmpty){
                  operators.removeAt(i);
                }
              }
            }

            for(int i = 0; i < operators.length; i++){
              if(operators[i] == '^'){
                numbers[i] = pow(double.parse(numbers[i]), double.parse(numbers[i+1])).toString();
                numbers.removeAt(i+1);
                if(operators.isNotEmpty){
                  operators.removeAt(i);
                }
                i--;
              }
            }

            for(int i = 0; i < operators.length; i++){
              if(operators[i] == '/'){
                numbers[i] = (double.parse(numbers[i]) / double.parse(numbers[i+1])).toString();
                numbers.removeAt(i+1);
                if(operators.isNotEmpty){
                  operators.removeAt(i);
                }
                i--;
              }
            }

            for(int i = 0; i < operators.length; i++){
              if(operators[i] == 'x'){
                numbers[i] = (double.parse(numbers[i]) * double.parse(numbers[i+1])).toString();
                numbers.removeAt(i+1);
                if(operators.isNotEmpty){
                  operators.removeAt(i);
                }
                i--;
              }
            }

            for(int i = 0; i < operators.length; i++){
              if(operators[i] == '-'){
                numbers[i] = (double.parse(numbers[i]) - double.parse(numbers[i+1])).toString();
                numbers.removeAt(i+1);
                if(operators.isNotEmpty){
                  operators.removeAt(i);
                }
                i--;
              }
            }

            for(int i = 0; i < operators.length; i++){
              if(operators[i] == '+'){
                numbers[i] = (double.parse(numbers[i]) + double.parse(numbers[i+1])).toString();
                numbers.removeAt(i+1);
                if(operators.isNotEmpty){
                  operators.removeAt(i);
                }
                i--;
              }
            }

          }

          numbers[0] = double.parse(numbers[0]).toString();
          if(double.parse(numbers[0]) == (double.parse(numbers[0])).toInt()){
            numbers[0] = double.parse(numbers[0]).toInt().toString();
          }
          expression = numbers[0];
          result = '';
        }
        catch(e){
          result = ':(';
        }

        expressionFontSize = 48.0;
        resultFontSize = 58.0;
      }
    });
  }

  angleButtonPressed(String buttonText){
    setState(() {
      if(angleFormat == 'rad'){
        angleFormat = 'deg';
        isRad = !isRad;
        deg = 57.295779513;
      }

      else{
        angleFormat = 'rad';
        isRad = !isRad;
        deg = 1;
      }
    });
  }

  arcButtonPressed(String buttonText){
    setState(() {
      if(buttonText == 'deg'){
      angleFormat = 'rad';
      isRad = !isRad;
      deg = 1;
      }
      isButtonDisabled = !isButtonDisabled;
    });

  }

  Widget buildButton(String buttonText, double buttonMeasurement, Color buttonColor, Color textColor){
    return ElevatedButton(onPressed: () => buttonPressed(buttonText), onLongPress: () => buttonLongPress(buttonText), child: Container(height: buttonMeasurement, width: buttonMeasurement, alignment: Alignment.center, child: Text(buttonText, style: GoogleFonts.nunito(color: textColor, fontSize: 20)),), style: ElevatedButton.styleFrom(shape: const CircleBorder(), primary: buttonColor, onPrimary: textColor, elevation: 0.0));
  }

  Widget buildAngleButton(String buttonText, double buttonMeasurement, Color buttonColor, Color textColor){
    return ElevatedButton(onPressed: isButtonDisabled ? null : () => angleButtonPressed(buttonText), child: Container(height: buttonMeasurement, width: buttonMeasurement, alignment: Alignment.center, child: Text(buttonText, style: GoogleFonts.nunito(color: textColor, fontSize: 20)),), style: ElevatedButton.styleFrom(shape: const CircleBorder(side: BorderSide(color: Colors.blueAccent, width: 1)), primary: buttonColor, onPrimary: textColor, elevation: 0.0));
  }

  Widget buildArcButton(String buttonText, double buttonMeasurement, Color buttonColor, Color textColor){
    return ElevatedButton(onPressed: () => arcButtonPressed(angleFormat), child: Container(height: buttonMeasurement, width: buttonMeasurement, alignment: Alignment.center, child: Text(buttonText, style: GoogleFonts.nunito(color: textColor, fontSize: 13)),), style: ElevatedButton.styleFrom(shape: const CircleBorder(), primary: buttonColor, onPrimary: textColor, elevation: 0.0));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Calculator',

      theme: ThemeData(
        brightness: Brightness.light,
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),

      themeMode: ThemeMode.system,

      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children:  [
                  Visibility(visible: isVisible,child: Container(padding: const EdgeInsets.fromLTRB(0, 0, 30.0, 10.0), alignment: Alignment.centerRight,child: Text(angleFormat.toUpperCase(), style: GoogleFonts.nunito(fontSize: 15,), maxLines: 2,))),
                  Container(padding: const EdgeInsets.fromLTRB(0, 0, 30.0, 10.0), alignment: Alignment.centerRight,child: AutoSizeText(expression, style: GoogleFonts.nunito(fontSize: expressionFontSize,), maxLines: 2,)),
                  Container(padding: const EdgeInsets.fromLTRB(0, 0, 30.0, 10.0),alignment: Alignment.centerRight,child: AutoSizeText(result, style: GoogleFonts.nunito(fontSize: resultFontSize), maxLines: 1,)),
                ],
              ),
              flex: 3,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: buildButton('C', buttonSize, Colors.white10, Colors.blueAccent), flex: 1,),
                        Visibility(visible: isVisible, child: Expanded(child: buildButton('!', buttonSize, Colors.white10, Colors.blueAccent), flex: 1,)),
                        Expanded(child: buildButton('/', buttonSize, Colors.white10, Colors.blueAccent), flex: 1,),
                        Expanded(child: buildButton('x', buttonSize, Colors.white10, Colors.blueAccent), flex: 1,),
                        Expanded(child: buildButton('=', buttonSize, Colors.blueAccent, Colors.white), flex: 1,),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: isVisible,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: buildAngleButton(angleFormat, buttonSize, Colors.white10, Colors.blueAccent), flex: 1,),
                          Expanded(child: buildButton(isButtonDisabled ? '   -1 sin' : 'sin', buttonSize, Colors.white10, Colors.blueAccent), flex: 1,),
                          Expanded(child: buildButton(isButtonDisabled ? '   -1 cos' : 'cos', buttonSize, Colors.white10, Colors.blueAccent), flex: 1,),
                          Expanded(child: buildButton(isButtonDisabled ? '   -1 tan' : 'tan', buttonSize, Colors.white10, Colors.blueAccent), flex: 1,),
                          Expanded(child: buildArcButton('-1', buttonSize, Colors.white10, Colors.blueAccent), flex: 1,),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(visible: isVisible, child: Expanded(child: buildButton('ln', buttonSize, Colors.white10, Colors.blueAccent), flex: 1,)),
                        Expanded(child: buildButton('7', buttonSize, Colors.white10, Colors.blueAccent), flex: 1,),
                        Expanded(child: buildButton('8', buttonSize, Colors.white10, Colors.blueAccent), flex: 1,),
                        Expanded(child: buildButton('9', buttonSize, Colors.white10, Colors.blueAccent), flex: 1,),
                        Expanded(child: buildButton('+', buttonSize, Colors.white10, Colors.blueAccent), flex: 1,),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(visible: isVisible, child: Expanded(child: buildButton('√', buttonSize, Colors.white10, Colors.blueAccent), flex: 1,)),
                        Expanded(child: buildButton('4', buttonSize, Colors.white10, Colors.blueAccent), flex: 1,),
                        Expanded(child: buildButton('5', buttonSize, Colors.white10, Colors.blueAccent), flex: 1,),
                        Expanded(child: buildButton('6', buttonSize, Colors.white10, Colors.blueAccent), flex: 1,),
                        Expanded(child: buildButton('-', buttonSize, Colors.white10, Colors.blueAccent), flex: 1,),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(visible: isVisible, child: Expanded(child: buildButton('log', buttonSize, Colors.white10, Colors.blueAccent), flex: 1,)),
                        Expanded(child: buildButton('1', buttonSize, Colors.white10, Colors.blueAccent), flex: 1,),
                        Expanded(child: buildButton('2', buttonSize, Colors.white10, Colors.blueAccent), flex: 1,),
                        Expanded(child: buildButton('3', buttonSize, Colors.white10, Colors.blueAccent), flex: 1,),
                        Expanded(child: buildButton('^', buttonSize, Colors.white10, Colors.blueAccent), flex: 1,),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: buildButton('/>', buttonSize, Colors.white10, Colors.blueAccent), flex: 1,),
                        Visibility(visible: isVisible, child: Expanded(child: buildButton('00', buttonSize, Colors.white10, Colors.blueAccent), flex: 1,)),
                        Expanded(child: buildButton('0', buttonSize, Colors.white10, Colors.blueAccent), flex: 1,),
                        Expanded(child: buildButton('.', buttonSize, Colors.white10, Colors.blueAccent), flex: 1,),
                        Expanded(child: buildButton('🌟', buttonSize, Colors.white10, Colors.blueAccent), flex: 1,),
                      ],
                    ),
                  ),
                ],
              ),
              flex: 6,
            )
          ],
        ),
      ),
    );
  }
}

