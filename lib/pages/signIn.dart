import 'dart:math';
import 'package:calculator/pages/homepage.dart';
import 'package:calculator/services/authentication.dart';
import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  SignIn({Key? key}) : super(key: key);
  final Authentication authentication = Authentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Transform.rotate(
          angle: -pi/15,
          child: Transform.translate(
            offset: const Offset(-5,0),
            child: Transform.scale(
              scale: 2,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Color(0xffabc4ff),
                        Color(0xffedf2fb),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter
                  ),
                ),
                height: 70,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            await authentication.googleSignIn().whenComplete(() {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  });

          },
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              gradient: LinearGradient(
                  colors: [
                    Color(0xffabc4ff),
                    Color(0xffedf2fb),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
              ),
            ),
            height: 100,
            width: 220,
            child: const Center(child: Text('Sign in!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500,fontStyle: FontStyle.italic),)),
          ),
        ),
        Transform.rotate(
          angle: -pi/15,
          child: Transform.translate(
            offset: const Offset(-5,0),
            child: Transform.scale(
              scale: 2,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Color(0xffedf2fb),
                        Color(0xffabc4ff),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter
                  ),
                ),
                height: 70,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
        ),
      ],
      ),
    );
  }
}