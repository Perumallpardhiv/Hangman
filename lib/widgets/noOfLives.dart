import 'package:flutter/material.dart';

class NoOfLives extends StatelessWidget {
  const NoOfLives({
    super.key,
    required this.selectedChar,
    required this.lives,
  });

  final List selectedChar;
  final int lives;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 0.5),
          child: IconButton(
            tooltip: 'Lives',
            splashColor: Colors.brown,
            iconSize: 30,
            icon: Icon(Icons.favorite),
            onPressed: () {
              print(selectedChar.length);
            },
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(6, 6, 5, 0),
          child: SizedBox(
            height: 38,
            width: 38,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  lives.toString(),
                  style: const TextStyle(
                    color: Colors.brown,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Monoton',
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
