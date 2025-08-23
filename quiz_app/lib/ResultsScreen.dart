import 'package:flutter/material.dart';
import 'package:quiz_app/QuestionResult.dart';
import 'package:quiz_app/data/questions.dart';

class ResultsScreen extends StatelessWidget {
  final List<int> selectedAnswers;
  final void Function() returnHome;
  const ResultsScreen({
    super.key,
    required this.selectedAnswers,
    required this.returnHome,
  });

  @override
  Widget build(BuildContext context) {
    final correctAnswers = selectedAnswers
        .where((answer) => answer == 0)
        .length;
    final totalQuestions = selectedAnswers.length;

    final questionMap = questions.asMap();
    return Container(
      padding: const EdgeInsets.all(20),
      color: Theme.of(context).colorScheme.primary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 10,
        children: [
          Text(
            'You got $correctAnswers out of $totalQuestions correct!',
            style: TextStyle(fontSize: 24),
          ),
          for (var entry in questionMap.entries)
            QuestionResult(entry: entry, selectedAnswers: selectedAnswers),
          ElevatedButton(onPressed: returnHome, child: Text('Return Home')),
        ],
      ),
    );
  }
}
