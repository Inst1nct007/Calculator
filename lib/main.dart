import 'package:flutter/material.dart';

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
  double expressionFontSize = 58.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText){

  }

  buttonLongPress(String buttonText){
    
  }



  Widget buildButton(String buttonText, double buttonMeasurement, Color buttonColor, Color textColor){
    return ElevatedButton(onPressed: () => buttonPressed(buttonText), onLongPress: () => buttonLongPress(buttonText), child: Container(height: buttonMeasurement, width: buttonMeasurement, alignment: Alignment.center, child: Text(buttonText, style: TextStyle(color: textColor, fontSize: 20),),), style: ElevatedButton.styleFrom(shape: const CircleBorder(), primary: buttonColor, onPrimary: textColor, elevation: 0.0));
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children:  [
                  Container(alignment: Alignment.centerRight,child: Text(expression, style: TextStyle(fontSize: expressionFontSize, color: Colors.black87),)),
                  Container(padding: const EdgeInsets.fromLTRB(0, 0, 0, 10.0),alignment: Alignment.centerRight,child: Text(result, style: TextStyle(fontSize: resultFontSize, color: Colors.black),)),
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
                        Expanded(child: buildButton('C', 65, Colors.white10, Colors.blueAccent), flex: 1,),
                        Expanded(child: buildButton('/', 65, Colors.white10, Colors.blueAccent), flex: 1,),
                        Expanded(child: buildButton('x', 65, Colors.white10, Colors.blueAccent), flex: 1,),
                        Expanded(child: buildButton('=', 65, Colors.blueAccent, Colors.white), flex: 1,),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: buildButton('7', 65, Colors.white10, Colors.blueAccent), flex: 1,),
                        Expanded(child: buildButton('8', 65, Colors.white10, Colors.blueAccent), flex: 1,),
                        Expanded(child: buildButton('9', 65, Colors.white10, Colors.blueAccent), flex: 1,),
                        Expanded(child: buildButton('+', 65, Colors.white10, Colors.blueAccent), flex: 1,),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: buildButton('4', 65, Colors.white10, Colors.blueAccent), flex: 1,),
                        Expanded(child: buildButton('5', 65, Colors.white10, Colors.blueAccent), flex: 1,),
                        Expanded(child: buildButton('6', 65, Colors.white10, Colors.blueAccent), flex: 1,),
                        Expanded(child: buildButton('-', 65, Colors.white10, Colors.blueAccent), flex: 1,),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: buildButton('1', 65, Colors.white10, Colors.blueAccent), flex: 1,),
                        Expanded(child: buildButton('2', 65, Colors.white10, Colors.blueAccent), flex: 1,),
                        Expanded(child: buildButton('3', 65, Colors.white10, Colors.blueAccent), flex: 1,),
                        Expanded(child: buildButton('.', 65, Colors.white10, Colors.blueAccent), flex: 1,),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: buildButton('0', 65, Colors.white10, Colors.blueAccent), flex: 1,),
                        Expanded(child: buildButton('+/-', 65, Colors.white10, Colors.blueAccent), flex: 1,),
                        Expanded(child: buildButton('%', 65, Colors.white10, Colors.blueAccent), flex: 1,),
                        Expanded(child: buildButton('🌟', 65, Colors.white10, Colors.blueAccent), flex: 1,),
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

