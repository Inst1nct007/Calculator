import 'package:calculator/pages/homepage.dart';
import 'package:calculator/pages/signIn.dart';
import 'package:calculator/providers/mathprovider.dart';
import 'package:calculator/services/authentication.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider<Authentication>(
            create: (_) => Authentication(),
          ),
          ChangeNotifierProvider(
            create: (_) => Math(),
          ),
        ],
      child: CalculatorApp(),
    )
  );
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Authentication authentication = Provider.of<Authentication>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: authentication.isSignedIn ? HomePage() : SignIn(),
    );
  }
}

