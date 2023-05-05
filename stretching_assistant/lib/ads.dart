import 'dart:math';

// Pub
import 'package:google_mobile_ads/google_mobile_ads.dart';

InterstitialAd? _interstitialAd;

void createInterstitialAd() {
  InterstitialAd.load(
    adUnitId: "ca-app-pub-3771578621008026/6532399897",
    request: const AdRequest(),
    adLoadCallback: InterstitialAdLoadCallback(
      onAdLoaded: (ad) => _interstitialAd = ad,
      onAdFailedToLoad: (error) => _interstitialAd = null,
    ),
  );
}

void showInterstitialAd({
  bool random = false,
  double probability = 1/3,
}) {
  if (_interstitialAd != null) {
    if (!random || (random && Random.secure().nextDouble() < probability)) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
    }
  }
}