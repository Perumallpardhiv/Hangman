import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:hangman/dbhelper.dart';
import 'package:hangman/homePage.dart';
import 'package:hangman/storagemodel.dart';
import 'package:intl/intl.dart';

class highScores extends StatefulWidget {
  const highScores({super.key});

  @override
  State<highScores> createState() => _highScoresState();
}

class _highScoresState extends State<highScores> {
  late List<scoremodel> scores;
  late dbHelper helper;
  bool isLoading = false;
  var numOfRows;
  List<String> topRanks = ["🥇", "🥈", "🥉"];

  @override
  void initState() {
    helper = dbHelper.instance;
    super.initState();
    refreshNotes();
  }

  Future refreshNotes() async {
    setState(() {
      isLoading = true;
    });
    this.scores = await helper.readAllTodo();
    numOfRows = scores.length;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : scores.length == 0
                ? Stack(
                    children: <Widget>[
                      Center(
                        child: Text(
                          "No Scores Yet!",
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(6.0, 10.0, 6.0, 15.0),
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          tooltip: 'Home',
                          iconSize: 30,
                          icon: Icon(Icons.home),
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: <Widget>[
                      Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(6.0, 10.0, 6.0, 15.0),
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              tooltip: 'Home',
                              iconSize: 32,
                              icon: Icon(Icons.home_outlined),
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onPressed: () {
                                Get.offAll(homePage());
                              },
                            ),
                          ),
                          Center(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 15.0),
                              child: Text(
                                'HIGH SCORES',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                  letterSpacing: 2.5,
                                  fontFamily: "RubikVinyl",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(18.0, 22.0, 18.0, 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Center(
                              child: Text(
                                "Rank",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  // fontWeight: FontWeight.w500,
                                  letterSpacing: 1.0,
                                  fontFamily: "Monoton",
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                "Date",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  // fontWeight: FontWeight.w500,
                                  letterSpacing: 1.0,
                                  fontFamily: "Monoton",
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                "Score",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  // fontWeight: FontWeight.w500,
                                  letterSpacing: 1.0,
                                  fontFamily: "Monoton",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: scores.length,
                            itemBuilder: (context, index) {
                              final score = scores[index];
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 15.0),
                                    child: Text(
                                      index < 3
                                          ? topRanks[index] + '${index + 1}'
                                          : '${index + 1}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "GloriaHallelujah",
                                        letterSpacing: 1.0,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        DateFormat.yMMMd()
                                            .add_jm()
                                            .format(score.date),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "GloriaHallelujah",
                                          letterSpacing: 1.0,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      score.score >= 10
                                          ? score.score.toString()
                                          : "0${score.score.toString()}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "GloriaHallelujah",
                                        letterSpacing: 1.0,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
