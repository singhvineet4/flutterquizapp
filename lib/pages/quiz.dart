import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:opentrivia/pages/result_screen.dart';
import '../models/question.dart';
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





 var  listoptions={
0:0,
   1:9,     15:9,
   2:9,    16:9,
   3:9,      17:9,
   4:9,      18:9,
   5:9,       19:9,
   6:9,        20:9,
   7:9,       21:9,
   8:9,      22:9,
   9:9,      23:9,
   10:9,      24:9,
   11:9,      25:9,
   12:9,     26:9,
   13:9,      27:9,
   14:9 ,     28:9,
   29:9
  };


  /*
  {
  "qid":ans,

  }



   */

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
              onPressed: () async{
               if( this.items.length!=index+1){
                 _allpagecont.animateToPage(index+1, duration: Duration(milliseconds: 300), curve: Curves.linear);
               }
               else{
                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Result()));
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
                     Radio(
                          activeColor: Colors.red,
                         groupValue: listoptions[index]==9?1:listoptions[index]==list_index?0:1,
                         value: 0,  onChanged: (vms){

                   // value:listoptions[index]==9?ƒfalse:listoptions[index]==list_index?true:false
                       setState(() {
                         listoptions[index]=list_index;
                        print(listoptions[index].toString()+":::"+list_index.toString());
                       });
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

  int get countOfQuestion => _questionsList.length;

  final List<Question> _questionsList = [Question()];

  Future <Question> getJob() async{
    final http.Response response = await http.get(Uri.parse("https://www.hiringmirror.com/api/assigned-quiz.php?quiz_id=26"));
   // print(response.toString());
    var responseData = json.decode(response.body);
    var queArr=responseData['quiz_ques'];
    queArr.forEach((jobDetail) {
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

String _parseHtmlString(String htmlString) {
  final document = parse(htmlString);
  final String parsedString = parse(document.body.text).documentElement.text;

  return parsedString;
}