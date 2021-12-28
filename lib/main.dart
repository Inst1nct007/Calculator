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
                  Container(alignment: Alignment.centerRight,child: const Text('1', style: TextStyle(fontSize: 48),)),
                ],
              ),
              flex: 4,
            ),
            Expanded(child: Container(color: Colors.blue,), flex: 5,)
          ],
        )
      ),
    );
  }
}

