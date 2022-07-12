import 'package:dio/dio.dart';
import 'package:flutter/material.dart';



class Result extends  StatefulWidget {
  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  Response response;
  Dio dio = Dio();
  bool error = false; //for error status
  bool loading = false; //for data featching status
  String errmsg = ""; //to assing any error message from API/runtime
  var apidata; //for decoded JSON data

  @override
  void initState() {
    getData(); //fetching data
    super.initState();
  }

  getData() async {
    setState(() {
      loading = true;
    });

    final url = "https://www.hiringmirror.com/api/quiz-report.php";
    Response response = await dio.post(url);
    apidata = response.data;
    print(apidata);

    if(response.statusCode == 200){
      if(apidata["report"]){
        error = true;
        errmsg  = apidata["report"];
      }
    }else{
      error = true;
      errmsg = "Error while fetching data.";
    }

    loading = false;
    setState(() {}); //refresh UI
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Submit"),
          backgroundColor: Colors.redAccent,
        ),
        body: Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(20),
            child: loading?
            CircularProgressIndicator():
            Container(
                child:error?Text("error: $errmsg"):
                Column(
                  children:apidata["report"].map<Widget>((country){
                    return Card(
                      child: ListTile(
                      ),
                    );
                  }).toList(),
                )
            )
        )
    );
  }
}

