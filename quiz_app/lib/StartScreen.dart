import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  final void Function() startQuiz;
  const StartScreen(this.startQuiz, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 50,
        children: [
          Image.asset('assets/images/quiz-logo.png', color: Color.fromRGBO(255, 255, 255, 0.498),), // This apparently more performant than Opacity widget
          const Text(
            "Learn Flutter the fun way!",
            style: TextStyle(fontSize: 26),
          ),
          OutlinedButton.icon(
            onPressed: startQuiz,
            style: OutlinedButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.all(Radius.circular(5)),
              ),
            ),
            icon: const Icon(Icons.flag_outlined),
            label: Text("Start Quiz"),
          ),
        ],
      ),
    );
  }
}
