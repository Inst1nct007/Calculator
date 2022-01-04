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

  String expression = '0';
  String result = '';
  double expressionFontSize = 58.0;
  double resultFontSize = 48.0;
  var numbers = [];
  var operators = [];
  var re;
  var pos = [];
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
          pos.clear();
          re = RegExp('[^0-9.]');
          numbers = expression.split(re);
          for(int i = 0; i < numbers.length; i++){
            if(!numbers.remove('')){
              break;
            }
          }
          result = numbers[0];
          re = RegExp('[0-9.()]*');
          operators = expression.split(re);
          for(int i = 0; i < operators.length; i++){
            if(!operators.remove('')){
              break;
            }
          }

          int others = 0;

          for(int i = 0; i<expression.length; i++){
            if(i > 0 && !(expression.codeUnitAt(i) >= 48 && expression.codeUnitAt(i) <= 57) && !(expression.codeUnitAt(i-1) >= 48 && expression.codeUnitAt(i-1) <= 57) || expression[i] == 's' || expression[i] == 'c' || expression[i] == 't'){
              pos.add(i-others);
            }
            else if(expression.codeUnitAt(i) >= 48 && expression.codeUnitAt(i) <= 57 || expression[i] == '.' && expression[i] != '(' && expression[i] != ')'){
              others++;
            }
          }

          for(int i=0; i<pos.length; i++){
            if(operators[pos[i]-i] == '-'){
              operators.removeAt(pos[i]-i);
              numbers[pos[i]-i] = (-1 * double.parse(numbers[pos[i]-i])).toString();
            }
          }

          while(numbers.length != 1 || operators.isNotEmpty){

            for(int i = 0; i < operators.length; i++){
              if(operators[i] == '√'){
                if(i==0){
                  numbers[i] = sqrt(double.parse(numbers[i+1])).toString();
                  numbers.removeAt(i+1);
                }
                else{
                  numbers[i] = sqrt(double.parse(numbers[i])).toString();
                }
                if(operators.isNotEmpty){
                  operators.removeAt(i);
                }
              }
            }

            for(int i = 0; i < operators.length; i++){
              if(operators[i] == 's' && !isButtonDisabled){
                if(i==0){
                  numbers[i] = sin(double.parse(numbers[i+1])).toString();
                  numbers.removeAt(i+1);
                }
                else{
                  numbers[i] = sin(double.parse(numbers[i])).toString();
                }
                if(operators.isNotEmpty){
                  operators.removeAt(i);
                }
              }
              else if(operators[i] == 's' && isButtonDisabled){
                if(i==0){

                  numbers[i] = asin(double.parse(numbers[i+1])).toString();

                  numbers.removeAt(i+1);
                }
                else{
                  numbers[i] = asin(double.parse(numbers[i])).toString();
                }
                if(operators.isNotEmpty){
                  operators.removeAt(i);
                }
              }
            }

            for(int i = 0; i < operators.length; i++){
              if(operators[i] == 'c' && !isButtonDisabled){
                if(i==0){
                  numbers[i] = cos(double.parse(numbers[i+1])).toString();
                  numbers.removeAt(i+1);
                }
                else{
                  numbers[i] = cos(double.parse(numbers[i])).toString();
                }
                if(operators.isNotEmpty){
                  operators.removeAt(i);
                }
              }
              else if(operators[i] == 'c' && isButtonDisabled){
                if(i==0){
                  numbers[i] = acos(double.parse(numbers[i+1])).toString();
                  numbers.removeAt(i+1);
                }
                else{
                  numbers[i] = acos(double.parse(numbers[i])).toString();
                }
                if(operators.isNotEmpty){
                  operators.removeAt(i);
                }
              }
            }

            for(int i = 0; i < operators.length; i++){
              if(operators[i] == 't' && !isButtonDisabled){
                if(i==0){
                  numbers[i] = tan(double.parse(numbers[i+1])).toString();
                  numbers.removeAt(i+1);
                }
                else{
                  numbers[i] = tan(double.parse(numbers[i])).toString();
                }
                if(operators.isNotEmpty){
                  operators.removeAt(i);
                }
              }
              else if(operators[i] == 't' && isButtonDisabled){
                if(i==0){
                  numbers[i] = atan(double.parse(numbers[i+1])).toString();
                  numbers.removeAt(i+1);
                }
                else{
                  numbers[i] = atan(double.parse(numbers[i])).toString();
                }
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
        expression += 's';
      }

      else if(buttonText == 'cos' || buttonText == '   -1 cos'){
        expression += 'c';
      }

      else if(buttonText == 'tan' || buttonText == '   -1 tan'){
        expression += 't';
      }

      else{
        if(buttonText == '0'){
          if(expression != ''){
          expression += buttonText;
          }
        }
        if(buttonText == '🌟'){

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
        expression = '0';
        result = '';
      }
      else if(buttonText == '='){
        try{
          pos.clear();
          re = RegExp('[^0-9.]');
          numbers = expression.split(re);
          for(int i = 0; i < numbers.length; i++){
            if(!numbers.remove('')){
              break;
            }
          }
          result = numbers[0];
          re = RegExp('[0-9.()]*');
          operators = expression.split(re);
          for(int i = 0; i < operators.length; i++){
            if(!operators.remove('')){
              break;
            }
          }

          int others = 0;
          for(int i = 0; i<expression.length; i++){
            if(i > 0 && !(expression.codeUnitAt(i) >= 48 && expression.codeUnitAt(i) <= 57) && !(expression.codeUnitAt(i-1) >= 48 && expression.codeUnitAt(i-1) <= 57) || expression[i] == 's' || expression[i] == 'c' || expression[i] == 't'){
              pos.add(i-others);
            }
            else if(expression.codeUnitAt(i) >= 48 && expression.codeUnitAt(i) <= 57 || expression[i] == '.' && expression[i] != '(' && expression[i] != ')'){
              others++;
            }
          }

          for(int i=0; i<pos.length; i++){
            if(operators[pos[i]-i] == '-'){
              operators.removeAt(pos[i]-i);
              numbers[pos[i]-i] = (-1 * double.parse(numbers[pos[i]-i])).toString();
            }
          }

          while(numbers.length != 1 || operators.isNotEmpty){

            for(int i = 0; i < operators.length; i++){
              if(operators[i] == '√'){
                if(i==0){
                  numbers[i] = sqrt(double.parse(numbers[i+1])).toString();
                  numbers.removeAt(i+1);
                }
                else{
                  numbers[i] = sqrt(double.parse(numbers[i])).toString();
                }
                if(operators.isNotEmpty){
                  operators.removeAt(i);
                }
              }
            }

            for(int i = 0; i < operators.length; i++){
              if(operators[i] == 's' && !isButtonDisabled){
                if(i==0){
                  numbers[i] = sin(double.parse(numbers[i+1])).toString();
                  numbers.removeAt(i+1);
                }
                else{
                  numbers[i] = sin(double.parse(numbers[i])).toString();
                }
                if(operators.isNotEmpty){
                  operators.removeAt(i);
                }
              }
              else if(operators[i] == 's' && isButtonDisabled){
                if(i==0){

                  numbers[i] = asin(double.parse(numbers[i+1])).toString();

                  numbers.removeAt(i+1);
                }
                else{
                  numbers[i] = asin(double.parse(numbers[i])).toString();
                }
                if(operators.isNotEmpty){
                  operators.removeAt(i);
                }
              }
            }

            for(int i = 0; i < operators.length; i++){
              if(operators[i] == 'c' && !isButtonDisabled){
                if(i==0){
                  numbers[i] = cos(double.parse(numbers[i+1])).toString();
                  numbers.removeAt(i+1);
                }
                else{
                  numbers[i] = cos(double.parse(numbers[i])).toString();
                }
                if(operators.isNotEmpty){
                  operators.removeAt(i);
                }
              }
              else if(operators[i] == 'c' && isButtonDisabled){
                if(i==0){
                  numbers[i] = acos(double.parse(numbers[i+1])).toString();
                  numbers.removeAt(i+1);
                }
                else{
                  numbers[i] = acos(double.parse(numbers[i])).toString();
                }
                if(operators.isNotEmpty){
                  operators.removeAt(i);
                }
              }
            }

            for(int i = 0; i < operators.length; i++){
              if(operators[i] == 't' && !isButtonDisabled){
                if(i==0){
                  numbers[i] = tan(double.parse(numbers[i+1])).toString();
                  numbers.removeAt(i+1);
                }
                else{
                  numbers[i] = tan(double.parse(numbers[i])).toString();
                }
                if(operators.isNotEmpty){
                  operators.removeAt(i);
                }
              }
              else if(operators[i] == 't' && isButtonDisabled){
                if(i==0){
                  numbers[i] = atan(double.parse(numbers[i+1])).toString();
                  numbers.removeAt(i+1);
                }
                else{
                  numbers[i] = atan(double.parse(numbers[i])).toString();
                }
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
          expression = '0' + numbers[0];
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
                  Container(padding: const EdgeInsets.fromLTRB(0, 0, 30.0, 10.0), alignment: Alignment.centerRight,child: AutoSizeText(expression.substring(1, expression.length), style: GoogleFonts.nunito(fontSize: expressionFontSize,), maxLines: 2,)),
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
                        Visibility(visible: isVisible, child: Expanded(child: buildButton('D', buttonSize, Colors.white10, Colors.blueAccent), flex: 1,)),
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
                        Visibility(visible: isVisible, child: Expanded(child: buildButton('D', buttonSize, Colors.white10, Colors.blueAccent), flex: 1,)),
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

