import 'package:flutter/material.dart';
import 'package:get/get.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.fromLTRB(1, 25, 0, 10),
                child: Text(
                  "HANGMAN",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 45,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 3,
                    fontFamily: 'RubikVinyl',
                  ),
                ),
              ),
            ),
            Center(
              child: SizedBox(
                height: height * 0.45,
                child: Center(
                  child: Image.asset(
                    'assets/gallow.png',
                    height: height * 0.5,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: SizedBox(
                    height: 64,
                    width: width * 0.5,
                    child: MaterialButton(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      onPressed: () {
                        Get.toNamed('/gamePage');
                      },
                      color: Colors.brown[300],
                      highlightColor: Colors.brown,
                      child: const Text(
                        "Start",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 1,
                          fontFamily: 'HanaleiFill',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: SizedBox(
                    height: 55,
                    width: width * 0.4,
                    child: MaterialButton(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      onPressed: () {
                        Get.toNamed('/highScore');
                      },
                      color: Colors.brown[300],
                      highlightColor: Colors.brown,
                      child: const Text(
                        "High Scores",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 1,
                          fontFamily: 'HanaleiFill',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
