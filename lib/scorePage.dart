import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

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
    controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  Center(
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
                        style: TextStyle(
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
    );
  }
}
