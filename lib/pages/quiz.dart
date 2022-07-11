import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/question.dart';



class ProfilePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState(){
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage>{
  double  _drawerIconSize = 24;
  final List<Question> items = [];

  @override
  void initState() {
    super.initState();
    getJob();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Hiring Mirror"),),
        body: ListView.builder(
          itemCount: this.items.length,
          itemBuilder: _listViewItemBuilder,
        )
    );
  }


  Widget _listViewItemBuilder(BuildContext context, int index){
    var jobDetail = this.items[index];
    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.all(20.30),
        subtitle: _itemThumbnail(jobDetail),
        title: _itemTitle(jobDetail),
        selectedTileColor: Colors.lightBlueAccent,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(150),
        ),
      ),

    );   //onTap: () {
  }


  Widget _itemTitle(Question jobDetail){
    return Text(jobDetail.question);
  }

  Widget _itemThumbnail(Question jobDetail){
    return Text(jobDetail.answers);
  }



  Future <Question> getJob() async{
    final http.Response response = await http.get(Uri.parse("https://www.hiringmirror.com/api/assigned-quiz.php?quiz_id=26"));
   // print(response.toString());
    var responseData = json.decode(response.body);
    var queArr=responseData['quiz_ques'];
    queArr.forEach((jobDetail) {
     // print(jobDetail['answers'].length);
      //print(jobDetail['answers'][3]['answer']);
        var len = jobDetail['answers'].length;
        var ansoptions='';
        for(var k=0;k<len;k++)
          {
          var ans= jobDetail['answers'][k]['answer'];
         print(ans);
          if(k==0)
            ansoptions =ans;
          else
            ansoptions =ansoptions+','+ans;
          }

      final Question question = Question(
        //quiz_id: jobDetail['quiz_id'],
        question: "Question"+ jobDetail['question'],
        answers: ansoptions,
      );
      setState(() {
        items.add(question);
      });
    });
  }
}

//Start Timing Durention

void startTimer(){
  Timer timer = new Timer.periodic(new Duration(seconds: 15),(time) {
    print('Something');
    time.cancel();
  });
}
