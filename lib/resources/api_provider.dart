import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:opentrivia/models/category.dart';
import 'package:opentrivia/models/question.dart';



Future getJob() async{
 final http.Response response = await http.get(Uri.parse("https://www.hiringmirror.com/api/assigned-quiz.php?quiz_id=26"));
 var responseData = json.decode(response.body);
 var queArr=responseData['quiz_ques'];

 print(queArr);
 queArr.forEach((jobDetail) {
  final Question question = Question(
   //quiz_id: jobDetail['quiz_id'],
   question: jobDetail['question'],
   option: jobDetail['option'],
  );
 });
}
