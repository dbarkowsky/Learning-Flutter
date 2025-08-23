class QuizQuestion {
  final String question;
  final List<String> answers;

  const QuizQuestion(
     this.question,
     this.answers,
  );



  List<QuizAnswer> getShuffledAnswers() {
    final shuffled = List<String>.from(answers).map((a) => QuizAnswer(a, answers.indexOf(a))).toList();
    shuffled.shuffle();
    return shuffled;
  }
}

class QuizAnswer {
  final String text;
  final int originalIndex;

  const QuizAnswer(
    this.text,
    this.originalIndex,
  );
}

    
