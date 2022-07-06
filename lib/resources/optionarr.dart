class Questions {
  final String question;
  final String options;
  final String answer;

  Questions(this.question, this.options, this.answer);
  factory Questions.fromJson(dynamic json) {
    if (json['quiz_ques'] != null) {
      return Questions(
          json['question'] as String,
          json['options'] as String,
         (json['answer']),
      );
    } else {
      return Questions(
          json['question'] as String,
          json['options'] as String,
          (json['answer'])
      );
    }
  }

  @override
  String toString() {
    return '{ ${this.question}, ${this.options}, ${this.answer} }';
  }
}