import 'package:flutter/material.dart';
import 'package:quiz_app/StartScreen.dart';


class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();

}


class _QuestionsScreenState extends State<QuestionsScreen> {
  @override
  Widget build(BuildContext context){
    return StartScreen();
  }
}
