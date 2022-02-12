import 'package:calculator/pages/signIn.dart';
import 'package:calculator/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Authentication authentication = Provider.of<Authentication>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color(0xffb9fbc0),
                  Color(0xff72efdd),
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
            ListTile(
              title: Text('Sign Out'),
              subtitle: Text('Sign Out of the App'),
              trailing: Icon(Icons.logout),
              onTap: (){
                authentication.signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignIn()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
