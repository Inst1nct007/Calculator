import 'package:flutter/material.dart';

class AppTheme with ChangeNotifier{
  Color AppBarGradientcolorOne = const Color(0xffb9fbc0);
  Color AppBarGradientcolorTwo = const Color(0xffb9fbc0);

  Color ButtonBackgroundcolorOne = Colors.white.withOpacity(0.40);
  Color ButtonBackgroundcolorTwo = Colors.white70.withOpacity(0.10);

  Color ButtonTextcolor = Colors.blueAccent;
  Color textColor = Colors.blueAccent;

  int activeItem = 5;

  updateAppBarGradient(Color color1, Color color2){
    AppBarGradientcolorOne = color1;
    AppBarGradientcolorTwo = color2;
    notifyListeners();
  }

  updateButtonBackgroundGradient(Color color1, Color color2){
    ButtonBackgroundcolorOne = color1;
    ButtonBackgroundcolorTwo = color2;
    notifyListeners();
  }

  updateButtonTextColor(Color color1){
    ButtonTextcolor = color1;
    notifyListeners();
  }

  updateTextColor(Color color1){
    textColor = color1;
    notifyListeners();
  }

  updateActiveItem(int item){
    activeItem = item;
    notifyListeners();
  }
}