class Question {
  final String questionText;
  final String difficulty;
  final String type;
  final String category;
  final String correctAnswer;
  List options;

  Question(
      {required this.questionText,
      required this.difficulty,
      required this.type,
      required this.category,
      required this.correctAnswer,
      required this.options}) {
    options.add(correctAnswer);
    options.shuffle();
  }
}
