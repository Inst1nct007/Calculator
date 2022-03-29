import 'package:calculator/pages/homepage.dart';
import 'package:calculator/providers/mathprovider.dart';
import 'package:calculator/providers/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

