import 'dart:math';

import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:google_fonts/google_fonts.dart';

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

class _CalculatorAppState extends State<CalculatorApp> {

  String expression = '0';
  String result = '';
  double expressionFontSize = 58.0;
  double resultFontSize = 48.0;
  var numbers = [];
  var operators = [];
  var re;
  double temp = 0.0;

  buttonPressed(String buttonText){
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
          re = RegExp('[^0-9]');
          numbers = expression.split(re);
          result = numbers[0];
          re = RegExp('[0-9]*');
          operators = expression.split(re);
          operators.removeAt(0);
          operators.removeAt(operators.length - 1);

          while(numbers.length != 1){
            for(int i = 0; i < operators.length; i++){
              if(operators[i] == '.'){
                temp = double.parse(numbers[i]) + double.parse(numbers[i+1])/pow(10, numbers[i+1].length);
                numbers[i] = temp.toString();
                numbers.removeAt(i+1);
                if(operators.isNotEmpty){
                  operators.removeAt(i);
                }
              }
            }

            for(int i = 0; i < operators.length; i++){
              if(operators[i] == '^'){
                temp = pow(double.parse(numbers[i]), double.parse(numbers[i+1])) as double;
                numbers[i] = temp.toString();
                result = temp.toString();
                numbers.removeAt(i+1);
                if(operators.isNotEmpty){
                  operators.removeAt(i);
                }
                i--;
              }
            }
            for(int i = 0; i < operators.length; i++){
              if(operators[i] == '/'){
                temp = double.parse(numbers[i]) / double.parse(numbers[i+1]);
                numbers[i] = temp.toString();
                numbers.removeAt(i+1);
                if(operators.isNotEmpty){
                  operators.removeAt(i);
                }
                i--;
              }
            }

            for(int i = 0; i < operators.length; i++){
              if(operators[i] == 'x'){
                temp = double.parse(numbers[i]) * double.parse(numbers[i+1]);
                numbers[i] = temp.toString();
                numbers.removeAt(i+1);
                if(operators.isNotEmpty){
                  operators.removeAt(i);
                }
                i--;
              }
            }

            for(int i = 0; i < operators.length; i++){
              if(operators[i] == '-'){
                temp = double.parse(numbers[i]) - double.parse(numbers[i+1]);
                numbers[i] = temp.toString();
                numbers.removeAt(i+1);
                if(operators.isNotEmpty){
                  operators.removeAt(i);
                }
                i--;
              }
            }

            for(int i = 0; i < operators.length; i++){
              if(operators[i] == '+'){
                temp = double.parse(numbers[i]) + double.parse(numbers[i+1]);
                numbers[i] = temp.toString();
                numbers.removeAt(i+1);
                if(operators.isNotEmpty){
                  operators.removeAt(i);
                }
                i--;
              }
            }

          }
          result = numbers[0];
          if(result[0] == '0' && result[1] != '.'){
            result = result.substring(1, result.length);
          }
        }
        catch(e){
          result = ':(';
        }


        try{
          numbers.addAll(result.split('.'));

          while(numbers[2].toString()[numbers[2].toString().length - 1] == '0' && numbers[2].toString().length > 1){
            numbers[2] = numbers[2].toString().substring(0, numbers[2].toString().length - 1);
          }
          if(numbers[2] != '0'){
            result = numbers[1] + '.' + numbers[2];
          }
          else{
            result = numbers[1];
          }
          numbers.removeAt(2);
          numbers.removeAt(1);
        }
        catch(e){
          null;
        }
        expressionFontSize = 48.0;
        resultFontSize = 58.0;
      }

      else if(buttonText == '+/-'){
          numbers[0] = (-1 * double.parse(result)).toString();
          operators.clear();
          operators = numbers[0].split('.');
          while(operators[1].toString()[operators[1].toString().length - 1] == '0' && operators[1].toString().length > 1){
            operators[1] = operators[1].toString().substring(0, operators[1].toString().length - 1);
          }
          if(operators[1] != '0'){
            numbers[0] = operators[0] + '.' + operators[1];
          }
          else{
            numbers[0] = operators[0];
          }
          try{
            expression = '0' + numbers[0];
            result = numbers[0];
            numbers.removeAt(1);
            operators.clear();
          }
          catch(e){
            null;
          }
      }

      else{
        if(buttonText == '0'){
          if(expression != ''){
          expression += buttonText;
          }
        }
        else if(buttonText == '🌟'){

        }
        else{
          expression += buttonText;
        }
      }
    });
  }

  buttonLongPress(String buttonText){
    setState(() {
      if(buttonText.toUpperCase() == 'C'){
        expression = '0';
        result = '';
      }
      else if(buttonText == '='){
        try{
          re = RegExp('[^0-9]');
          numbers = expression.split(re);
          result = numbers[0];
          re = RegExp('[0-9]*');
          operators = expression.split(re);
          operators.removeAt(0);
          operators.removeAt(operators.length - 1);

          while(numbers.length != 1){

            for(int i = 0; i < operators.length; i++){
              if(operators[i] == '.'){
                temp = double.parse(numbers[i]) + double.parse(numbers[i+1])/pow(10, numbers[i+1].length);
                numbers[i] = temp.toString();
                numbers.removeAt(i+1);
                if(operators.length > 0){
                  operators.removeAt(i);
                }
              }
            }

            for(int i = 0; i < operators.length; i++){
              if(operators[i] == '^'){
                temp = pow(double.parse(numbers[i]), double.parse(numbers[i+1])) as double;
                numbers[i] = temp.toString();
                result = temp.toString();
                numbers.removeAt(i+1);
                if(operators.length > 0){
                  operators.removeAt(i);
                }
                i--;
              }
            }

            for(int i = 0; i < operators.length; i++){
              if(operators[i] == 'x'){
                temp = double.parse(numbers[i]) * double.parse(numbers[i+1]);
                numbers[i] = temp.toString();
                numbers.removeAt(i+1);
                if(operators.length > 1){
                  operators.removeAt(i);
                }
                i--;
              }
            }
            for(int i = 0; i < operators.length; i++){
              if(operators[i] == '/'){
                temp = double.parse(numbers[i]) / double.parse(numbers[i+1]);
                numbers[i] = temp.toString();
                numbers.removeAt(i+1);
                if(operators.length > 0){
                  operators.removeAt(i);
                }
                i--;
              }
            }
            for(int i = 0; i < operators.length; i++){
              if(operators[i] == '+'){
                temp = double.parse(numbers[i]) + double.parse(numbers[i+1]);
                numbers[i] = temp.toString();
                numbers.removeAt(i+1);
                if(operators.length > 0){
                  operators.removeAt(i);
                }
                i--;
              }
            }
            for(int i = 0; i < operators.length; i++){
              if(operators[i] == '-'){
                temp = double.parse(numbers[i]) - double.parse(numbers[i+1]);
                numbers[i] = temp.toString();
                numbers.removeAt(i+1);
                if(operators.length > 0){
                  operators.removeAt(i);
                }
                i--;
              }
            }
          }
          result = numbers[0];
          if(result[0] == '0' && result[1] != '.'){
            result = result.substring(1, result.length);
          }
          try{
            numbers.addAll(result.split('.'));

            while(numbers[2].toString()[numbers[2].toString().length - 1] == '0' && numbers[2].toString().length > 1){
              numbers[2] = numbers[2].toString().substring(0, numbers[2].toString().length - 1);
            }
            if(numbers[2] != '0'){
              result = numbers[1] + '.' + numbers[2];
            }
            else{
              result = numbers[1];
            }
            numbers.removeAt(2);
            numbers.removeAt(1);
          }
          catch(e){
            null;
          }
          expression = '0' + result;
          result = '';
        }
        catch(e){
          result = ':(';
        }
      }
    });
  }



  Widget buildButton(String buttonText, double buttonMeasurement, Color buttonColor, Color textColor){
    return ElevatedButton(onPressed: () => buttonPressed(buttonText), onLongPress: () => buttonLongPress(buttonText), child: Container(height: buttonMeasurement, width: buttonMeasurement, alignment: Alignment.center, child: Text(buttonText, style: GoogleFonts.nunito(color: textColor, fontSize: 20)),), style: ElevatedButton.styleFrom(shape: const CircleBorder(), primary: buttonColor, onPrimary: textColor, elevation: 0.0));
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children:  [
                  Container(padding: const EdgeInsets.fromLTRB(0, 0, 30.0, 10.0), alignment: Alignment.centerRight,child: AutoSizeText(expression.substring(1, expression.length), style: GoogleFonts.nunito(fontSize: expressionFontSize, color: Colors.black87), maxLines: 2,)),
                  Container(padding: const EdgeInsets.fromLTRB(0, 0, 30.0, 10.0),alignment: Alignment.centerRight,child: AutoSizeText(result, style: GoogleFonts.nunito(fontSize: resultFontSize, color: Colors.black), maxLines: 1,)),
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
                        Expanded(child: buildButton('C', 70, Colors.white10, Colors.blueAccent), flex: 1,),
                        Expanded(child: buildButton('/', 70, Colors.white10, Colors.blueAccent), flex: 1,),
                        Expanded(child: buildButton('x', 70, Colors.white10, Colors.blueAccent), flex: 1,),
                        Expanded(child: buildButton('=', 70, Colors.blueAccent, Colors.white), flex: 1,),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: buildButton('7', 70, Colors.white10, Colors.blueAccent), flex: 1,),
                        Expanded(child: buildButton('8', 70, Colors.white10, Colors.blueAccent), flex: 1,),
                        Expanded(child: buildButton('9', 70, Colors.white10, Colors.blueAccent), flex: 1,),
                        Expanded(child: buildButton('+', 70, Colors.white10, Colors.blueAccent), flex: 1,),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: buildButton('4', 70, Colors.white10, Colors.blueAccent), flex: 1,),
                        Expanded(child: buildButton('5', 70, Colors.white10, Colors.blueAccent), flex: 1,),
                        Expanded(child: buildButton('6', 70, Colors.white10, Colors.blueAccent), flex: 1,),
                        Expanded(child: buildButton('-', 70, Colors.white10, Colors.blueAccent), flex: 1,),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: buildButton('1', 70, Colors.white10, Colors.blueAccent), flex: 1,),
                        Expanded(child: buildButton('2', 70, Colors.white10, Colors.blueAccent), flex: 1,),
                        Expanded(child: buildButton('3', 70, Colors.white10, Colors.blueAccent), flex: 1,),
                        Expanded(child: buildButton('.', 70, Colors.white10, Colors.blueAccent), flex: 1,),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: buildButton('0', 70, Colors.white10, Colors.blueAccent), flex: 1,),
                        Expanded(child: buildButton('+/-', 70, Colors.white10, Colors.blueAccent), flex: 1,),
                        Expanded(child: buildButton('^', 70, Colors.white10, Colors.blueAccent), flex: 1,),
                        Expanded(child: buildButton('🌟', 70, Colors.white10, Colors.blueAccent), flex: 1,),
                      ],
                    ),
                  ),
                ],
              ),
              flex: 6,
            )
          ],
        ),
          backgroundColor: const Color(0xffedf2f4)
      ),
    );
  }
}

