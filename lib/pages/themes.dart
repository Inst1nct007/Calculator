import 'package:calculator/providers/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Themes extends StatelessWidget {
  const Themes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<AppTheme>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Themes'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                    appTheme.AppBarGradientcolorOne,
                    appTheme.AppBarGradientcolorTwo,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
            ),
          ),
        ),
        elevation: 0,
      ),
      body: Center(
        child: ListView(
          children: [
            /*ListTile(
              title: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text('Rengoku Theme'),
              ),
              subtitle: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text('Feel the heat!'),
              ),
              trailing: appTheme.activeItem == 1 ? Icon(Icons.done) : null,
              onTap: (){
                appTheme.updateAppBarGradient(const Color(0xffd90429), const Color(0xffffd60a));
                appTheme.updateButtonBackgroundGradient(Colors.deepOrangeAccent.withOpacity(0.40), Colors.red.withOpacity(0.05));
                appTheme.updateButtonTextColor(Colors.deepOrange);
                appTheme.updateTextColor(Colors.red);
                appTheme.updateSupportButtonGradient(Colors.black, const Color(0xffedf2fb));
                appTheme.updateActiveItem(1);
              },
            ),
            ListTile(
              title: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text('Batman Theme'),
              ),
              subtitle: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text('The Dark Knight!'),
              ),
              trailing: appTheme.activeItem == 2 ? Icon(Icons.done) : null,
              onTap: () {
                appTheme.updateAppBarGradient(const Color(0xff000000), const Color(0xff293241));
                appTheme.updateButtonBackgroundGradient(Colors.black87.withOpacity(0.40), Colors.black54.withOpacity(0.50));
                appTheme.updateButtonTextColor(Colors.black);
                appTheme.updateTextColor(Colors.red);
                appTheme.updateSupportButtonGradient(const Color(0xffabc4ff), const Color(0xffedf2fb));
                appTheme.updateActiveItem(2);
              },
            ),
            ListTile(
              title: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text('Love Theme'),
              ),
              subtitle: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text('Feel the Love!'),
              ),
              trailing: appTheme.activeItem == 3 ? Icon(Icons.done) : null,
              onTap: (){
                appTheme.updateAppBarGradient(const Color(0xffff0a54), const Color(0xffff0a54));
                appTheme.updateButtonBackgroundGradient(Colors.white.withOpacity(0.40), Colors.white70.withOpacity(0.10));
                appTheme.updateButtonTextColor(Colors.pinkAccent);
                appTheme.updateTextColor(Colors.red);
                appTheme.updateSupportButtonGradient(const Color(0xffabc4ff), const Color(0xffedf2fb));
                appTheme.updateActiveItem(3);
              },
            ),
            ListTile(
              title: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text('Grass Theme'),
              ),
              subtitle: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text('Breeze over the grass!'),
              ),
              trailing: appTheme.activeItem == 4 ? Icon(Icons.done) : null,
              onTap: (){
                appTheme.updateAppBarGradient(const Color(0xffb9fbc0), const Color(0xffb9fbc0));
                appTheme.updateButtonBackgroundGradient(Colors.white.withOpacity(0.40), Colors.white70.withOpacity(0.10));
                appTheme.updateButtonTextColor(const Color(0xff52b69a));
                appTheme.updateTextColor(Colors.red);
                appTheme.updateSupportButtonGradient(const Color(0xffabc4ff), const Color(0xffedf2fb));
                appTheme.updateActiveItem(4);
              },
            ),*/
            ListTile(
              title: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text('Ocean Theme'),
              ),
              subtitle: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text('Calm as the Ocean!'),
              ),
              trailing: appTheme.activeItem == 5 ? Icon(Icons.done) : null,
              onTap: (){
                appTheme.updateAppBarGradient(const Color(0xffb9fbc0), const Color(0xff72efdd),);
                appTheme.updateButtonBackgroundGradient(Colors.white.withOpacity(0.40), Colors.white70.withOpacity(0.10));
                appTheme.updateButtonTextColor(Colors.blueAccent);
                appTheme.updateTextColor(Colors.indigoAccent);
                appTheme.updateSupportButtonGradient(const Color(0xffabc4ff), const Color(0xffedf2fb));
                appTheme.updateActiveItem(5);
              },
            ),
          ],
        ),
      ),
    );
  }
}
