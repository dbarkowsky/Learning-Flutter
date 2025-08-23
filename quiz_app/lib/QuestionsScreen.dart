import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsScreen extends StatefulWidget {
  final void Function(int) onSelectAnswer;

  const QuestionsScreen({super.key, required this.onSelectAnswer});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  int questionIndex = 0;

  void answerQuestion(int index) {
    widget.onSelectAnswer(index);
    setState(() {
      if (questionIndex < questions.length - 1) {
        // If there are more questions, increment the index
        questionIndex++;
      } // Otherwise, we let the quiz widget detect all questions have been answered
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      color: Theme.of(context).colorScheme.primary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 20,
        children: [
          Text(
            questions[questionIndex].question,
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 30),
          ...questions[questionIndex].getShuffledAnswers().map((answer) {
            return ElevatedButton(
              onPressed: () {
                answerQuestion(answer.originalIndex);
              },
              child: Text(answer.text, textAlign: TextAlign.center),
            );
          }),
        ],
      ),
    );
  }
}
