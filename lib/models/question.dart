
enum Type {
  multiple,
  boolean
}

enum Difficulty {
  easy,
  medium,
  hard
}


class Question{
  Question({
   // this.quiz_id,
    this.question,
    this.option,
    this.answer,

  });

  //final String quiz_id;
  final String question;
  final String option;
  final String answer;

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
     // quiz_id: json["quiz_id"],
      question: json["question"],
      option: json["option"],
      answer: json["answer"],
    );
  }

 // static Future<List<Question>> fromData(decode) {}

  //String get email => null;

  //String get password => null;
}