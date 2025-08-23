import 'package:flutter/material.dart';
import 'package:quiz_app/models/QuizQuestion.dart';

class QuestionResult extends StatelessWidget {
  const QuestionResult({
    super.key,
    required this.entry,
    required this.selectedAnswers,
  });

  final MapEntry<int, QuizQuestion> entry;
  final List<int> selectedAnswers;

  @override
  Widget build(BuildContext context) {
    final Color badColor = Color.fromRGBO(212, 113, 113, 1);
    final Color goodColor = Color.fromRGBO(113, 212, 113, 1);

    bool isCorrect =
        entry.value.answers[selectedAnswers[entry.key]] ==
        entry.value.answers[0];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          CircleAvatar(
            backgroundColor: isCorrect ? goodColor : badColor,
            child: Text('${entry.key + 1}'),
          ),
          // Expanded is nice here. Expands to fit available space
          // and allows text to wrap if needed
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  entry.value.question,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  'Your answer: ${entry.value.answers[selectedAnswers[entry.key]]}',
                  style: TextStyle(color: isCorrect ? goodColor : badColor),
                ),
                if (!isCorrect)
                  Text(
                    'Correct answer: ${entry.value.answers[0]}',
                    style: TextStyle(color: goodColor),
                  ), // First answer is always correct
              ],
            ),
          ),
        ],
      ),
    );
  }
}
