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

  Widget buildButton(String buttonText, double buttonMeasurement, Color buttonColor){
    return ElevatedButton(onPressed: null, child: Container(height: buttonMeasurement, width: buttonMeasurement, alignment: Alignment.center, child: Text(buttonText),), style: ElevatedButton.styleFrom(shape: const CircleBorder()));
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Calculator'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children:  [
                  Container(alignment: Alignment.centerRight,child: const Text('0', style: TextStyle(fontSize: 48),)),
                  Container(padding: const EdgeInsets.fromLTRB(0, 0, 0, 10.0),alignment: Alignment.centerRight,child: const Text('1', style: TextStyle(fontSize: 48),)),
                ],
              ),
              flex: 4,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.black45,
                      width: 1,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: buildButton('C', 65, Colors.white10), flex: 1,),
                          Expanded(child: buildButton('/', 65, Colors.white10), flex: 1,),
                          Expanded(child: buildButton('x', 65, Colors.white10), flex: 1,),
                          Expanded(child: buildButton('=', 65, Colors.white10), flex: 1,),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: buildButton('7', 65, Colors.white10), flex: 1,),
                          Expanded(child: buildButton('8', 65, Colors.white10), flex: 1,),
                          Expanded(child: buildButton('9', 65, Colors.white10), flex: 1,),
                          Expanded(child: buildButton('+', 65, Colors.white10), flex: 1,),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: buildButton('4', 65, Colors.white10), flex: 1,),
                          Expanded(child: buildButton('5', 65, Colors.white10), flex: 1,),
                          Expanded(child: buildButton('6', 65, Colors.white10), flex: 1,),
                          Expanded(child: buildButton('-', 65, Colors.white10), flex: 1,),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: buildButton('1', 65, Colors.white10), flex: 1,),
                          Expanded(child: buildButton('2', 65, Colors.white10), flex: 1,),
                          Expanded(child: buildButton('3', 65, Colors.white10), flex: 1,),
                          Expanded(child: buildButton('.', 65, Colors.white10), flex: 1,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              flex: 5,
            )
          ],
        )
      ),
    );
  }
}

