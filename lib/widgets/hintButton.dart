import 'package:flutter/material.dart';

class HintButton extends StatelessWidget {
  const HintButton({
    super.key,
    required this.hintStatus,
  });

  final bool hintStatus;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(top: 0.5),
          child: const Icon(
            Icons.lightbulb,
            size: 30,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 2, 1),
          child: SizedBox(
            height: 38,
            width: 38,
            child: Center(
              child: Text(
                hintStatus ? "1" : "0",
                style: const TextStyle(
                  color: Colors.brown,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Monoton',
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
