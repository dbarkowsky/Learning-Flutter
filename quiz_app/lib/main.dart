import 'package:flutter/material.dart';
import 'package:quiz_app/StartScreen.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: TextTheme(),
      ),
      home: DefaultTextStyle(
        style: TextStyle(),
        child: StartScreen(),
      ),
    );
  }
}
// 
