import 'package:calculator/pages/about.dart';
import 'package:calculator/pages/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../providers/themeprovider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  void onShare() async {
    await Share.share('Check this out!! https://play.google.com/store/apps/details?id=com.king.calculator', subject: 'Look what I found!');
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<AppTheme>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
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
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(userName!),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(userEmail!),
              ),
              trailing: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Image.network(userPhoto!),
              ),
            ),*/
            ListTile(
              title: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text('Share'),
              ),
              subtitle: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text('Share for no reason!'),
              ),
              trailing: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(Icons.share),
              ),
              onTap: (){
                onShare();
              },
            ),
            ListTile(
              title: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text('About'),
              ),
              subtitle: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text('Story of this App!'),
              ),
              trailing: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Icon(Icons.stream),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const About()));
              },
            ),
            ListTile(
              title: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text('Themes'),
              ),
              subtitle: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text('Explore Different Colors!'),
              ),
              trailing: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Icon(Icons.animation),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Themes()));
              },
            ),
            /*ListTile(
              title: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text('Sign Out'),
              ),
              subtitle: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text('Sign Out of the App'),
              ),
              trailing: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Icon(Icons.logout),
              ),
              onTap: () async {
                await authentication.signOut();
                Navigator.pop(context);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignIn()));
              },
            ),*/
          ],
        ),
      ),
    );
  }
}
