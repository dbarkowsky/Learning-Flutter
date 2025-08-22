import 'package:flutter/material.dart';
import 'package:quiz_app/QuestionsScreen.dart';
import 'package:quiz_app/StartScreen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();

}


class _QuizState extends State<Quiz> {
  late Widget activeScreen;

  @override
  void initState() {
    super.initState();
    activeScreen = StartScreen(switchScreen);
  }
  void switchScreen() {
    setState(() {
      activeScreen = const QuestionsScreen();
    });
  }

  @override
  Widget build(BuildContext context){
    return activeScreen;
  }
}
