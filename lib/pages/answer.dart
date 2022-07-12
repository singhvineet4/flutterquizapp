import 'package:dio/dio.dart';
import 'package:flutter/material.dart';



class Home extends  StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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

    final url = "https://www.hiringmirror.com/api/submit-quiz-answers.php";


    Response response = await dio.post(url);
    apidata = response.data;

    print(apidata); //printing the JSON recieved

    if(response.statusCode == 200){
      if(apidata["message"]){
        error = true;
        errmsg  = apidata["message"];
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
                  children:apidata["postedata"].map<Widget>((country){
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