import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class scorePage extends StatefulWidget {
  var score;

  scorePage(this.score);

  @override
  State<scorePage> createState() => _scorePageState();
}

class _scorePageState extends State<scorePage> {
  final controller = ConfettiController();
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    initIntersititalAd();
    controller.play();
  }

  late InterstitialAd interstitialAd;
  bool isAdLoaded = false;
  initIntersititalAd() async {
    await InterstitialAd.load(
      adUnitId: 'ca-app-pub-2108900822347101/6603950414',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAd = ad;
          isAdLoaded = true;
          setState(() {});
        },
        onAdFailedToLoad: (e) {
          interstitialAd.dispose();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isAdLoaded) {
          interstitialAd.show();
        }
        return true;
      },
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        "SCORE",
                        style: TextStyle(
                          // fontWeight: FontWeight.w600,
                          fontSize: 45,
                          fontFamily: "HanaleiFill",
                          letterSpacing: 3,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          widget.score.toString(),
                          style: const TextStyle(
                            fontSize: 80,
                            fontFamily: "GloriaHallelujah",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ConfettiWidget(
            confettiController: controller,
            shouldLoop: true,
            // blastDirection: pi/2,
            blastDirectionality: BlastDirectionality.explosive,
            numberOfParticles: 15,
            emissionFrequency: 0.08,
            gravity: 0.25,
          ),
        ],
      ),
    );
  }
}
