import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  int questionIndex = 0;

  void answerQuestion() {
    setState(() {
      if (questionIndex < questions.length - 1) {
        // If there are more questions, increment the index
        questionIndex++;
      } else {
        // If no more questions, reset to the first question or handle end of quiz
        questionIndex = 0; // Reset to first question for simplicity
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      color: Colors.deepPurple,
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
                answerQuestion();
              },
              child: Text(answer, textAlign: TextAlign.center),
            );
          }),
        ],
      ),
    );
  }
}
