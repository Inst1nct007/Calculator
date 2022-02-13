import 'package:calculator/pages/homepage.dart';
import 'package:calculator/services/authentication.dart';
import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  SignIn({Key? key}) : super(key: key);
  Authentication authentication = Authentication();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: ElevatedButton(
        onPressed: (){
          authentication.googleSignIn();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
        },
        child: Text('Sign In'),
      ),
      ),
    );
  }
}
