class Question {
  String question;
  bool response;
  String explanation;
  String imagePath;

  Question({
    required this.question,
    required this.response,
    required this.explanation,
    required this.imagePath
  });

  String getImage() => 'images/$imagePath';
}
