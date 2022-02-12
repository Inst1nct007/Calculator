import 'package:calculator/pages/homepage.dart';
import 'package:calculator/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Authentication authentication = Provider.of<Authentication>(context);
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
