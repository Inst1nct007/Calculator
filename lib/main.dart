import 'package:calculator/pages/homepage.dart';
import 'package:calculator/pages/signIn.dart';
import 'package:calculator/providers/mathprovider.dart';
import 'package:calculator/providers/themeprovider.dart';
import 'package:calculator/services/authentication.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => Math(),
      ),
      ChangeNotifierProvider(
        create: (_) => AppTheme(),
      ),
    ],
      child: const CalculatorApp(),
    ),

  );
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Authentication authentication = Authentication();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: authentication.isSignedIn ? const HomePage() : SignIn(),
    );
  }
}

