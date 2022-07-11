
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
  final String question;
  final String answers;


    const Question({
    this.question,
    this.answers,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
     // quiz_id: json["quiz_id"],
      question: json["question"],
      answers: json["answers"],

    );
  }

  checkIsQuestionAnswered(int questionId) {}

 // static Future<List<Question>> fromData(decode) {}

  //String get email => null;

  //String get password => null;
}