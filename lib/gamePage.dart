import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hangman/dbhelper.dart';
import 'package:hangman/scorePage.dart';
import 'package:hangman/storagemodel.dart';
import 'package:hangman/wordDisplay.dart';
import 'package:random_words/random_words.dart';

class gamePage extends StatefulWidget {
  const gamePage({super.key});

  @override
  State<gamePage> createState() => _gamePageState();
}

class _gamePageState extends State<gamePage> {
  int lives = 5;
  var wordCount = 0;
  String alphabets = 'abcdefghijklmnopqrstuvwxyz'.toUpperCase();
  double height = Get.size.height;
  final wordsList = [];
  var word = "Great".toString().toUpperCase();
  var uniqueChars = Set<String>();
  var allChars = <String>[];
  List<dynamic> selectedChar = [];
  var tries = 0;
  var findChar = 0;
  final _random = new Random();
  bool hintStatus = true;

  @override
  void initState() {
    generatewords();
    super.initState();
  }

  void generatewords() {
    generateAdjective()
        .take(1000)
        .where((element) =>
            element.toString().length <= 7 && element.toString().length >= 3)
        .forEach((element) {
      wordsList.add(element.toString().toUpperCase());
    });
  }

  @override
  Widget build(BuildContext context) {
    word.split('').forEach((element) => uniqueChars.add(element));
    word.split('').forEach((element) => allChars.add(element.toUpperCase()));
    return WillPopScope(
      onWillPop: () async {
        final ans = await Get.defaultDialog(
          titlePadding: EdgeInsets.fromLTRB(10, 20, 10, 5),
          contentPadding: EdgeInsets.all(20),
          backgroundColor: Colors.brown[400],
          title: "ENDGAME",
          content: Text("Are you sure to END GAME?"),
          radius: 30,
          actions: [
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                minimumSize: Size(10, 30),
                foregroundColor: Colors.brown[900],
                side: BorderSide(color: Colors.brown),
              ),
              onPressed: () {
                Get.back(result: false);
              },
              icon: Icon(
                Icons.close,
              ),
              label: Text("No"),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                foregroundColor: Colors.brown[900],
              ),
              onPressed: () {
                Get.back(result: true);
              },
              icon: Text("END"),
              label: Icon(
                Icons.exit_to_app,
              ),
            ),
          ],
        );
        if (ans != null) {
          if (ans == true) {
            final score = scoremodel(
              id: Random().nextInt(1000),
              score: wordCount,
              date: DateTime.now(),
            );
            await dbHelper.instance.create(score);
            return Future.value(true);
          } else {
            return Future.value(false);
          }
        } else {
          return Future.value(false);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
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
                    ),
                    Container(
                      margin: EdgeInsets.all(3),
                      child: Text(
                        wordCount.toString(),
                        style: const TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontFamily: "PressStart2P"),
                      ),
                    ),
                    Stack(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 0.5),
                          child: IconButton(
                            tooltip: 'Hint',
                            iconSize: 30,
                            icon: Icon(Icons.lightbulb),
                            onPressed: hintStatus
                                ? () {
                                    int rad = Random().nextInt(allChars.length);
                                    var hintChar = allChars[rad];
                                    while (selectedChar.contains(hintChar)) {
                                      rad = Random().nextInt(allChars.length);
                                      hintChar = allChars[rad];
                                    }
                                    setState(() {
                                      selectedChar.add(hintChar.toUpperCase());
                                      hintStatus = false;
                                      findChar++;
                                      allChars.remove(hintChar.toUpperCase());
                                      if (findChar == uniqueChars.length) {
                                        wordCount = wordCount + word.length;
                                        word = wordsList[_random
                                                .nextInt(wordsList.length)]
                                            .toString()
                                            .toUpperCase();
                                        print(word);
                                        uniqueChars = Set<String>();
                                        word.split('').forEach((element) =>
                                            uniqueChars.add(element));
                                        // word = "GREEK".toString().toUpperCase();
                                        allChars = <String>[];
                                        word.split('').forEach((element) =>
                                            allChars
                                                .add(element.toUpperCase()));
                                        selectedChar = [''];
                                        findChar = 0;
                                        hintStatus = true;
                                      }
                                    });
                                  }
                                : null,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(6, 4, 5, 0),
                          child: SizedBox(
                            height: 38,
                            width: 38,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextButton(
                                  onPressed: hintStatus
                                      ? () {
                                          int rad =
                                              Random().nextInt(allChars.length);
                                          var hintChar = allChars[rad];
                                          while (
                                              selectedChar.contains(hintChar)) {
                                            rad = Random()
                                                .nextInt(allChars.length);
                                            hintChar = allChars[rad];
                                          }
                                          setState(() {
                                            selectedChar
                                                .add(hintChar.toUpperCase());
                                            hintStatus = false;
                                            findChar++;
                                            allChars
                                                .remove(hintChar.toUpperCase());
                                            if (findChar ==
                                                uniqueChars.length) {
                                              wordCount =
                                                  wordCount + word.length;
                                              word = wordsList[_random.nextInt(
                                                      wordsList.length)]
                                                  .toString()
                                                  .toUpperCase();
                                              print(word);
                                              uniqueChars = Set<String>();
                                              word.split('').forEach(
                                                  (element) =>
                                                      uniqueChars.add(element));
                                              // word = "GREEK".toString().toUpperCase();
                                              allChars = <String>[];
                                              word.split('').forEach(
                                                  (element) => allChars.add(
                                                      element.toUpperCase()));
                                              selectedChar = [''];
                                              findChar = 0;
                                              hintStatus = true;
                                            }
                                          });
                                        }
                                      : null,
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
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: height * 0.54,
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 200,
                        width: 200,
                        child: Image.asset("assets/$tries.png"),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: word
                              .split("")
                              .map((e) => letter(
                                  e, selectedChar.contains(e.toUpperCase())))
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: GridView.count(
                    crossAxisCount: 8,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children: alphabets.split("").map((e) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 7,
                          shadowColor: Colors.brown[800],
                          backgroundColor:
                              selectedChar.contains(e.toUpperCase())
                                  ? Colors.brown[300]
                                  : Colors.brown,
                        ),
                        onPressed: () async {
                          print(selectedChar.length);
                          if (selectedChar.contains(e.toUpperCase()) == true) {
                            print("true");
                          } else {
                            print("false");
                            setState(() {
                              selectedChar.add(e.toUpperCase());
                              if (word.split("").contains(e.toUpperCase())) {
                                findChar++;
                                allChars.remove(e.toUpperCase());
                                if (findChar == uniqueChars.length) {
                                  wordCount = wordCount + word.length;
                                  word = wordsList[
                                          _random.nextInt(wordsList.length)]
                                      .toString()
                                      .toUpperCase();
                                  print(word);
                                  uniqueChars = Set<String>();
                                  word.split('').forEach(
                                      (element) => uniqueChars.add(element));
                                  // word = "GREEK".toString().toUpperCase();
                                  allChars = <String>[];
                                  word.split('').forEach((element) =>
                                      allChars.add(element.toUpperCase()));
                                  selectedChar = [''];
                                  findChar = 0;
                                  hintStatus = true;
                                }
                              } else {
                                tries++;
                              }
                            });
                          }
                          if (tries >= 6) {
                            if (lives > 0) {
                              Get.defaultDialog(
                                barrierDismissible: false,
                                title: "THE MAN IS HANGED",
                                content: Text("Are you sure to use life?"),
                                titlePadding:
                                    EdgeInsets.fromLTRB(10, 20, 10, 10),
                                contentPadding: EdgeInsets.all(20),
                                backgroundColor: Colors.brown[400],
                                radius: 20,
                                actions: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                    child: OutlinedButton(
                                      onPressed: () async {
                                        Get.back();
                                        Get.off(scorePage(
                                          wordCount,
                                        ));
                                        final score = scoremodel(
                                          id: Random().nextInt(1000),
                                          score: wordCount,
                                          date: DateTime.now(),
                                        );
                                        await dbHelper.instance.create(score);
                                      },
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      style: OutlinedButton.styleFrom(
                                        minimumSize: Size(20, 30),
                                        foregroundColor: Colors.brown[900],
                                        side: BorderSide(color: Colors.brown),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          lives--;
                                          tries = 0;
                                          Get.back();
                                        });
                                      },
                                      child: Text(
                                        "Yes",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size(35, 30),
                                        backgroundColor: Colors.brown,
                                        foregroundColor: Colors.brown[900],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              Get.off(scorePage(
                                wordCount,
                              ));
                              final score = scoremodel(
                                id: Random().nextInt(1000),
                                score: wordCount,
                                date: DateTime.now(),
                              );
                              await dbHelper.instance.create(score);
                            }
                          }
                        },
                        child: Text(e),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () async {
                      Get.off(scorePage(
                        wordCount,
                      ));
                      final score = scoremodel(
                        id: Random().nextInt(1000),
                        score: wordCount,
                        date: DateTime.now(),
                      );
                      await dbHelper.instance.create(score);
                    },
                    icon: Text(
                      "ENDGAME",
                      style: TextStyle(
                        fontFamily: "HanaleiFill",
                        color: Colors.brown[900],
                      ),
                    ),
                    label: Icon(
                      Icons.arrow_right_alt,
                      size: 35,
                      color: Colors.brown[900],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
