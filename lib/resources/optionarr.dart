import 'dart:convert';



class Questions {
  Questions(Map<dynamic, dynamic> map, {
    this.question,
    this.options,
    this.answer,
  });
  String question;
  String options;
  String answer;

  Map<String, dynamic> toJson() => {
    "question": question,
    "option": options,
    "answer": answer,
  };

  static fromJson(x) {}
}