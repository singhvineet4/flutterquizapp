import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:opentrivia/pages/result_screen.dart';
import '../models/question.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
class ProfilePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState(){
    return _ProfilePageState();
  }

  nextQuestion() {}
}

class _ProfilePageState extends State<ProfilePage>{
  double  _drawerIconSize = 24;
  final List<Question> items = [];

  PageController _allpagecont=new PageController();

  @override
  void initState() {
    super.initState();
    getJob();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Hiring Mirror"),),
        body: PageView.builder(
          physics: NeverScrollableScrollPhysics(),
          controller: _allpagecont,
          scrollDirection: Axis.horizontal,
            itemCount: this.items.length,

            itemBuilder: (context,index){



          return Scaffold(

            floatingActionButton: FloatingActionButton.extended(
             label: this.items.length!=index+1?Text("Next"):Text("Finish"),
              onPressed: (){
               if( this.items.length!=index+1){
                 _allpagecont.animateToPage(index+1, duration: Duration(milliseconds: 300), curve: Curves.linear);
               }
               else{
               }
              },
            ),

            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
                child: Text("${index+1}) "+"${this.items[index].question}"),
              ),
             Padding(
               padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
               child: ListView.builder(
                 shrinkWrap: true,
                   itemCount:this.items[index].answers.length ,
                   itemBuilder: (context,list_index){
                 return Row(
                   children: [
                     Radio(value: this.items[index]==999?false:this.items[index]==list_index?true:false,  onChanged: (vms){
                     }),
                     Text(this.items[index].answers[list_index]["answer"]),
                   ],
                 );

               }),
             )
            ],),
          );
        })
    );
  }



  Widget _itemTitle(Question jobDetail){
    return Text(jobDetail.question);
  }

  Widget _itemThumbnail(Question jobDetail){
    return Text(jobDetail.answers.toString());
  }

  int get countOfQuestion => _questionsList.length;

  final List<Question> _questionsList = [Question()];



  Future <Question> getJob() async{
    final http.Response response = await http.get(Uri.parse("https://www.hiringmirror.com/api/assigned-quiz.php?quiz_id=26"));
   // print(response.toString());
    var responseData = json.decode(response.body);
    var queArr=responseData['quiz_ques'];
    queArr.forEach((jobDetail) {
     // print(jobDetail['answers'].length);
      //print(jobDetail['answers'][3]['answer']);

      final Question question = Question(
        //quiz_id: jobDetail['quiz_id'],
        question: _parseHtmlString(jobDetail['question']),
        answers: jobDetail['answers'],
      );
      setState(() {
        items.add(question);
      });
    });
  }

}


bool _ispressed = false;

bool get isPressed => _ispressed;

double _numberOfQuestion = 1;
double get numberOfQuestion => _numberOfQuestion;
int _selectAnswer;
int get selectAnswer => _selectAnswer;
//int? _correctAnswer;
//int? _correctAnswer;
//int get countOfCorrectAnswers => _countOfCorrectAnswers;

final Map<int, bool> _questionIsAnswerd = {};
PageController pageController;
Timer _timer;
final maxSec = 15;
final RxInt _sec = 15.obs;
RxInt get sec => _sec;


//check if the question has been answered
bool checkIsQuestionAnswered(int quesId) {
  return _questionIsAnswerd.entries
      .firstWhere((element) => element.key == quesId)
      .value;
}

void nextQuestion() {
  if (_timer != null || _timer.isActive) {
    stopTimer();
  }

  var _questionsList;
  if (pageController.page == _questionsList.length - 1) {


  } else {
    var _isPressed = false;
    pageController.nextPage(
        duration: const Duration(milliseconds: 500), curve: Curves.linear);

    startTimer();
  }
  _numberOfQuestion = pageController.page + 2;
  update();
}

void update() {
}




void startTimer() {
  resetTimer();
  _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    if (_sec.value > 0) {
      _sec.value--;
    } else {
      stopTimer();
      nextQuestion();
    }
  });
}

void resetTimer() => _sec.value = maxSec;

void stopTimer() => _timer.cancel();



String _parseHtmlString(String htmlString) {
  final document = parse(htmlString);
  final String parsedString = parse(document.body.text).documentElement.text;

  return parsedString;
}