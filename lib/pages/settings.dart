import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color(0xffb9fbc0),
                  Color(0xff72efdd),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
            ),
          ),
        ),
        elevation: 0,
      ),
      body: Center(child: Text('Settings')),
    );
  }
}
