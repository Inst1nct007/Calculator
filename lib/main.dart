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

  String expression = '';
  String result = '0';
  var checkInteger;
  double expressionFontSize = 58.0;
  double resultFontSize = 48.0;
  var numbers;
  var operators;
  var re;

  buttonPressed(String buttonText){
    setState(() {
      if(buttonText.toUpperCase() == 'C'){
        try{
        expression = expression.substring(0, expression.length - 1);
        }
        catch(e){
          null;
        }
      }
      else if(buttonText == '='){
        try{
          re = RegExp('[^0-9]');
          numbers = expression.split(re);
          print(numbers);
          result = numbers[0];
          re = RegExp('[0-9]+');
          operators = expression.split(re);
          operators.removeAt(0);
          operators.removeAt(operators.length - 1);
          print(operators);
        }
        catch(e){
          result = ':(';
        }
        try{
          checkInteger = result.split('.');
          while(checkInteger[1].toString()[checkInteger[1].toString().length - 1] == '0' && checkInteger[1].toString().length > 1){
            checkInteger[1] = checkInteger[1].toString().substring(0, checkInteger[1].toString().length - 1);
          }
          if(checkInteger[1] != '0'){
            result = checkInteger[0] + '.' + checkInteger[1];
          }
          else{
            result = checkInteger[0];
          }
        }
        catch(e){
          null;
        }
        expressionFontSize = 48.0;
        resultFontSize = 58.0;
      }

      else if(buttonText == '+/-'){
        if(expression[0] != '-'){
          expression = '-' + expression;
        }
        else{
          expression = expression.substring(1, expression.length);
        }
      }

      else{
        if(buttonText == '0'){
          if(expression != ''){
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
    setState(() {
      if(buttonText.toUpperCase() == 'C'){
        expression = '';
        result = '0';
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
                  Container(padding: const EdgeInsets.fromLTRB(0, 0, 30.0, 10.0), alignment: Alignment.centerRight,child: AutoSizeText(expression, style: GoogleFonts.nunito(fontSize: expressionFontSize, color: Colors.black87), maxLines: 2,)),
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

