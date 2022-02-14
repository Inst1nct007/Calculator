import 'package:auto_size_text/auto_size_text.dart';
import 'package:calculator/pages/settings.dart';
import 'package:calculator/services/ad_helper.dart';
import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../providers/mathprovider.dart';
import '../services/firestore.dart';
import '../widgets/widgets.dart';
import 'package:provider/provider.dart';

const int maxFailedLoadAttempts = 3;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  FirestoreDatabase database = FirestoreDatabase();
  late int points;
  InterstitialAd? interstitialAd;
  bool isBottomInterstitialAdLoaded = false;
  int interstitialLoadAttempts = 0;

  void showInterstitialAd(){
    if(interstitialAd != null){
      interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: (InterstitialAd ad){
            ad.dispose();
            createInterstitialAd();
          },
          onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error){
            ad.dispose();
            createInterstitialAd();
          });
      interstitialAd!.show();
    }
  }

  void createInterstitialAd(){
    InterstitialAd.load(adUnitId: AdHelper.interstitialAdUnitId, request: AdRequest(), adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (InterstitialAd ad){
      interstitialAd = ad;
      interstitialLoadAttempts = 0;
    },
        onAdFailedToLoad: (LoadAdError error){
      interstitialLoadAttempts += 1;
          interstitialAd = null;
          interstitialLoadAttempts <= maxFailedLoadAttempts ? createInterstitialAd() : null;
        }));
  }

  void settingButton() async {
    controller.forward();
    await Future.delayed(Duration(milliseconds: 350));
    await Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
    controller.reverse();
  }

  @override
  void initState() {
    super.initState();
    createInterstitialAd();
    points = 0;
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    controller.dispose();
    interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final math = Provider.of<Math>(context);
    return Scaffold(
      appBar: AppBar(
        leading: AnimatedBuilder(
            animation: controller.view,
            builder: (context, child) {
              return Transform.rotate(
                angle: controller.value * 2.2,
                child: IconButton(icon: Icon(Icons.settings), onPressed: () {settingButton();},),
              );
            },
          ),
        title: PointWidget(database),
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
        /*gradient: LinearGradient(
        colors: [
          Color(0xffccdbfd),
          Color(0xffe2eafc),
        ],
            begin: Alignment.bottomLeft
        ),*/
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Visibility(visible: math.isVisible, child: Container(padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),alignment: Alignment.centerRight, child: AutoSizeText(math.angleFormat.toUpperCase(), style: TextStyle(), maxLines: 1,)),),
                    Container(padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8), alignment: Alignment.centerRight,child: AutoSizeText(math.result, style: TextStyle(fontSize: math.resultSize, color: Colors.blueAccent), maxLines: 1,)),
                    Container(padding: EdgeInsets.symmetric(horizontal: 8), alignment: Alignment.centerRight,child: AutoSizeText(math.expression, style: TextStyle(fontSize: math.expressionSize, color: Colors.blueAccent), maxLines: 2,)),
                  ],
                ),
              ),
              flex: 4,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonWidget(buttonText: 'C',),
                        Visibility(visible: math.isVisible, child: ButtonWidget(buttonText: 'x!',)),
                        ButtonWidget(buttonText: '/',),
                        ButtonWidget(buttonText: 'x',),
                        ButtonWidget(buttonText: '=',),
                      ],
                    ),
                  Visibility(
                    visible: math.isVisible,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ButtonWidget(buttonText: math.angleFormat,),
                          ButtonWidget(buttonText: 'sin',),
                          ButtonWidget(buttonText: 'cos',),
                          ButtonWidget(buttonText: 'tan',),
                          ButtonWidget(buttonText: 'x⁻¹',),
                        ],
                      ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(visible: math.isVisible, child: ButtonWidget(buttonText: 'ln',)),
                      ButtonWidget(buttonText: '7',),
                      ButtonWidget(buttonText: '8',),
                      ButtonWidget(buttonText: '9',),
                      ButtonWidget(buttonText: '+',),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(visible: math.isVisible, child: ButtonWidget(buttonText: '√x',)),
                      ButtonWidget(buttonText: '4',),
                      ButtonWidget(buttonText: '5',),
                      ButtonWidget(buttonText: '6',),
                      ButtonWidget(buttonText: '-',),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(visible: math.isVisible, child: ButtonWidget(buttonText: 'log',)),
                      ButtonWidget(buttonText: '1',),
                      ButtonWidget(buttonText: '2',),
                      ButtonWidget(buttonText: '3',),
                      ButtonWidget(buttonText: '^',),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonWidget(buttonText: '/>',),
                      ButtonWidget(buttonText: '0',),
                      ButtonWidget(buttonText: '00',),
                      ButtonWidget(buttonText: '.',),
                      Visibility(visible: math.isVisible, child: ButtonWidget(buttonText: '👌',)),
                    ],
                  ),
                ],
              ),
              flex: 6,
            ),
            GestureDetector(
                onTap: () async {
                  FirestoreDatabase database = FirestoreDatabase();
                  int points = await database.fetchData();
                  if(points < 60){
                    showInterstitialAd();
                    await database.addAdPoint();
                  }
                  else{
                    const snackBar = SnackBar(content: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text('Don\'t you have enough points already? XD', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                    ), backgroundColor: Colors.greenAccent,);
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: GlassContainer(
                  height: MediaQuery.of(context).size.height / 12,
                  width: MediaQuery.of(context).size.width,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xffabc4ff),
                      Color(0xffedf2fb),
                    ],
                    begin: Alignment.bottomRight,
                    end: Alignment.topRight,
                  ),
                  borderColor: Colors.white70,
                  blur: 40,
                  borderRadius: BorderRadius.circular(40),
                  borderWidth: 0.5,
                  elevation: 5.0,
                  isFrostedGlass: false,
                  shadowColor: Colors.red.withOpacity(0.20),
                  child: Center(child: Text('Get Extra Points! ✨', style: TextStyle(color: Colors.indigoAccent, fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

