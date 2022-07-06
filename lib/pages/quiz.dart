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
        appBar: AppBar(title: Text("Hirring Mirror"),),
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
          //leading: Image.asset('assets/favicon.png'),
          //tileColor: const Color.fromARGB(20, 30, 50, 10) ,
          selectedTileColor: Colors.lightBlueAccent,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          // onTap: () { d nm,./
          // _navigationToJobDetail(context, jobDetail);
          //},
      ),
    );   //onTap: () {
  }

  //void _navigationToJobDetail(BuildContext context, JobDetail jobDetail){
  // Navigator.push(
  // context,
  //MaterialPageRoute(
  //builder: (context){return JobInfo(jobDetail);}
  //)
  //);
  //}

  //Widget _navigationToJobDetail(JobDetail jobDetail){
  //return Text(jobDetail.job_location_locality);
  //}

  Widget _itemTitle(Question jobDetail){
    return Text(jobDetail.question);
  }

  Widget _itemThumbnail(Question jobDetail){
    return Text(jobDetail.option);
  }

  Future getJob() async{
    final http.Response response = await http.get(Uri.parse("https://www.hiringmirror.com/api/assigned-quiz.php?quiz_id=26"));

    var responseData = json.decode(response.body);
    var queArr=responseData['quiz_ques'];
    print(queArr);
    queArr.forEach((jobDetail) {
      final Question question = Question(
       // id: jobDetail['id'],
        question: jobDetail['question'],
        option: jobDetail['option'],
      );
      setState(() {
        items.add(question);
      });
    });
  }
}









