import 'dart:io';

class AdHelper{
  static String get interstitialAdUnitId{
    if(Platform.isAndroid){
      return 'ca-app-pub-6396759485426258/7956992432';
    }
    else if(Platform.isIOS){
      return 'ca-app-pub-3940256099942544/4411468910';
    }
    else{
      throw UnsupportedError('Unsupported Platform');
    }
  }
}