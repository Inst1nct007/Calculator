import 'package:auto_size_text/auto_size_text.dart';
import 'package:calculator/pages/settings.dart';
import 'package:calculator/services/ad_helper.dart';
import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../providers/mathprovider.dart';
import '../providers/themeprovider.dart';
import '../services/firestore.dart';
import '../widgets/widgets.dart';
import 'package:provider/provider.dart';

const int maxFailedLoadAttempts = 3;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController controller;
  FirestoreDatabase database = FirestoreDatabase();
  InterstitialAd? interstitialAd;
  bool isBottomInterstitialAdLoaded = false;
  int interstitialLoadAttempts = 0;

  late int supportPoints;
  late String supportLvl;

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
    InterstitialAd.load(adUnitId: AdHelper.interstitialAdUnitId, request: const AdRequest(), adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (InterstitialAd ad){
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
    await Future.delayed(const Duration(milliseconds: 350));
    await Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
    controller.reverse();
  }

  @override
  void initState() {
    super.initState();
    createInterstitialAd();
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    WidgetsBinding.instance?.addObserver(this);
    //showInterstitialAd();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.paused){
      final math = Provider.of<Math>(context, listen: false);
      math.updatePoints();
    }
    super.didChangeAppLifecycleState(state);
  }
  @override
  void dispose() {
    controller.dispose();
    interstitialAd?.dispose();
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final math = Provider.of<Math>(context);
    final appTheme = Provider.of<AppTheme>(context);

    return Scaffold(
      appBar: AppBar(
        leading: AnimatedBuilder(
            animation: controller.view,
            builder: (context, child) {
              return Transform.rotate(
                angle: controller.value * 2.2,
                child: IconButton(icon: const Icon(Icons.settings), onPressed: () {settingButton();},),
              );
            },
          ),
        title: PointWidget(database),
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
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
                    Visibility(visible: math.isVisible, child: Container(padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),alignment: Alignment.centerRight, child: AutoSizeText(math.angleFormat.toUpperCase(), style: const TextStyle(), maxLines: 1,)),),
                    Container(padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8), alignment: Alignment.centerRight,child: AutoSizeText(math.result, style: TextStyle(fontSize: math.resultSize, color: appTheme.textColor), maxLines: 1,)),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 8), alignment: Alignment.centerRight,child: AutoSizeText(math.expression, style: TextStyle(fontSize: math.expressionSize, color: appTheme.textColor), maxLines: 2,)),
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
                        const ButtonWidget(buttonText: 'C',),
                        Visibility(visible: math.isVisible, child: const ButtonWidget(buttonText: 'x!',)),
                        const ButtonWidget(buttonText: '/',),
                        const ButtonWidget(buttonText: '+',),
                        const ButtonWidget(buttonText: '=',),
                      ],
                    ),
                  Visibility(
                    visible: math.isVisible,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ButtonWidget(buttonText: math.angleFormat,),
                          const ButtonWidget(buttonText: 'sin',),
                          const ButtonWidget(buttonText: 'cos',),
                          const ButtonWidget(buttonText: 'tan',),
                          const ButtonWidget(buttonText: 'x⁻¹',),
                        ],
                      ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(visible: math.isVisible, child: const ButtonWidget(buttonText: 'ln',)),
                      const ButtonWidget(buttonText: 'x',),
                      const ButtonWidget(buttonText: '7',),
                      const ButtonWidget(buttonText: '8',),
                      const ButtonWidget(buttonText: '9',),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(visible: math.isVisible, child: const ButtonWidget(buttonText: '√x',)),
                      const ButtonWidget(buttonText: '-',),
                      const ButtonWidget(buttonText: '4',),
                      const ButtonWidget(buttonText: '5',),
                      const ButtonWidget(buttonText: '6',),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(visible: math.isVisible, child: const ButtonWidget(buttonText: 'log',)),
                      const ButtonWidget(buttonText: '^',),
                      const ButtonWidget(buttonText: '1',),
                      const ButtonWidget(buttonText: '2',),
                      const ButtonWidget(buttonText: '3',),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const ButtonWidget(buttonText: '/>',),
                      const ButtonWidget(buttonText: '0',),
                      const ButtonWidget(buttonText: '00',),
                      const ButtonWidget(buttonText: '.',),
                      Visibility(visible: math.isVisible, child: const ButtonWidget(buttonText: '👌',)),
                    ],
                  ),
                ],
              ),
              flex: 6,
            ),
            GestureDetector(
                onTap: () async {
                  FirestoreDatabase database = FirestoreDatabase();
                    showInterstitialAd();
                    await database.addAdPoint();
                },
                child: GlassContainer(
                  height: MediaQuery.of(context).size.height / 12,
                  width: MediaQuery.of(context).size.width,
                  gradient: const LinearGradient(
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
                  child: Center(child: Text('Support Us?', style: TextStyle(color: appTheme.textColor, fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

