class QuizQuestion {
  final String question;
  final List<String> answers;

  const QuizQuestion(
     this.question,
     this.answers,
  );

  List<String> getShuffledAnswers() {
    final shuffled = List<String>.from(answers);
    shuffled.shuffle();
    return shuffled;
  }
}
