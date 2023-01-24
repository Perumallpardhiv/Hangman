import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hangman/gamePage.dart';
import 'package:hangman/highScorePage.dart';
import 'package:hangman/homePage.dart';
import 'package:hangman/scorePage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        tooltipTheme: TooltipThemeData(
          decoration: BoxDecoration(
            color: const Color(0xFF1089ff),
            borderRadius: BorderRadius.circular(5.0),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 20.0,
            letterSpacing: 1.0,
            color: Colors.white,
          ),
        ),
        scaffoldBackgroundColor: Colors.brown[400],
      ),
      home: homePage(),
      getPages: [
        GetPage(
          name: '/',
          page: () => homePage(),
        ),
        GetPage(
          name: '/gamePage',
          page: () => gamePage(),
        ),
        GetPage(
          name: '/highScore',
          page: () => highScores(),
        ),
      ],
    );
  }
}
