import 'package:flutter/material.dart';
import 'package:quiz_app/QuestionsScreen.dart';
import 'package:quiz_app/ResultsScreen.dart';
import 'package:quiz_app/StartScreen.dart';
import 'package:quiz_app/data/questions.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  late Widget activeScreen;
  // This is a little gimicky. The questions are always in the same order,
  // and the first answer is always marked with index 0. So we just store the indices of the selected answers.
  // Answers are shuffled when displayed.
  List<int> selectedAnswers = [];

  @override
  void initState() {
    super.initState();
    activeScreen = StartScreen(startQuiz);
  }

  void startQuiz() {
    setState(() {
      activeScreen = QuestionsScreen(onSelectAnswer: chooseAnswer);
    });
  }

  void chooseAnswer(int answerIndex) {
    // This part doesn't have to be in setState, as it doesn't affect the UI directly
    // Avoid thinking like React where state changes always have to be in setState
    selectedAnswers.add(answerIndex);
    if (selectedAnswers.length >= questions.length) {
      setState(() {
        activeScreen = ResultsScreen(selectedAnswers: selectedAnswers, returnHome: returnHome,);
      });
    }
  }

  void returnHome() {
    setState(() {
      selectedAnswers = [];
      activeScreen = StartScreen(startQuiz);
    });
  }

  @override
  Widget build(BuildContext context) {
    return activeScreen;
  }
}
