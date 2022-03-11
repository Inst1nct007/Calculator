import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.vertical,
      children: const [
        FlutterPage(),
        AboutPage(),
      ],
    );
  }
}

class FlutterPage extends StatelessWidget {
  const FlutterPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () async {
                const String url = 'https://flutter.dev/';
                if(await canLaunch(url)){
                  launch(url);
                }
                else{
                  throw 'Try Again!';
                }
              },
              child: const FlutterLogo(
                size: 270,
                style: FlutterLogoStyle.stacked,
                curve: Curves.easeOutExpo,
              ),
            ),
            const Text('About the Architecture', style: TextStyle(fontSize: 25,color: Colors.black54), textAlign: TextAlign.justify,),
            const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text('This App would not have been possible without Flutter.\n\n Flutter is Google\'s UI Toolkit.\n\nIt is Cross Platform and quite easy to learn. That\'s why I love developing with Flutter.\n\nClick! on the Flutter Logo to learn more!!', style: TextStyle(fontSize: 25,color: Colors.black45), textAlign: TextAlign.justify,),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text('^', style: TextStyle(fontSize: 25,color: Colors.black45), textAlign: TextAlign.justify,),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.account_circle, size: 100,),
                Icon(Icons.account_circle_outlined, size: 100,),
              ],
            ),
            const Text('About the Developers', style: TextStyle(fontSize: 25,color: Colors.black54), textAlign: TextAlign.justify,),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text('This App would also not have been possible without my sister.\n\nShe helped me build this app and always encouraged me to keep learning. I promised her that one day I\'d release it on the App Store!\n\nThis App is in no way perfect. It has countless bugs, but I\'ll still release it to keep my promise.\n\nAt last thanks to all of my friends for testing the app.', style: TextStyle(fontSize: 25,color: Colors.black45), textAlign: TextAlign.justify,),
            ),
          ],
        ),
      ),
    );
  }
}
