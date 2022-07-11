
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';

import '../../comman/theme_helper.dart';


class Registrationdemo extends  StatefulWidget{
  
  @override
  State<StatefulWidget> createState() {
    return _Registrationdemo();
  }
}

class _Registrationdemo extends State<Registrationdemo> {
// int _counter = 0;

  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;

  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  TextEditingController first_name = new TextEditingController();
  TextEditingController last_name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController contact = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController token = new TextEditingController();
  //TextEditingController resume = new TextEditingController();

  // Dio dio = new Dio();

  //late bool error, sending, success;
  //late String msg;

  String url = "https://www.hiringmirror.com/api/register-with-resume.php";

  //get image => Element.image();


  @override
  void initState() {
    //error = false;
    //sending = false;
    //success = false;
    //msg = "";
    super.initState();
  }


  Future<void> postData() async {
    var res = await http.post(Uri.parse(url), body: {
      "first_name": "vipin",
      "last_name": "kumar",
      "email": "rudrapal490@gmail.com",
      "contact": "8218118852",
      "password": "12345",
    });

    var request = new http.MultipartRequest('POST', Uri.parse(url));//sending post request with header data
    // Uint8List data = await this.image.readAsBytes();
    //List<int> list = data.cast();
    // request.files.add(new http.MultipartFile.fromBytes('your_field_name', list,filename: 'file'));
    var response = await request.send();
    if (res.statusCode == 200) {
      print(res.body); //print raw response on console
      var data = json.decode(res.body); //decoding json to array
      if(data[""]){
        setState(() { //refresh the UI when error is recieved from server
          //sending = false;
          //error = true;
          //msg = data["message"]; //error message from server
        });
      }else{

        //job_id.text = "";
        //total_experience.text = "";
        //email.text = "";
        //contact.text = "";
        //title.text = "";
        //token.text = "";
        //after write success, make fields empty

        setState(() {
          // sending = false;
          //success = true; //mark success and refresh UI with setState
        });
      }

    }else{
      //there is error
      setState(() {
        //error = true;
        //msg = "Error during sending data.";
        //sending = false;
        //mark error and refresh UI with setState
      });
    }
  }




  @override
  void dispose() {
    first_name.dispose();
    last_name.dispose();
    email.dispose();
    contact.dispose();
    password.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 150,
              child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      width: 5, color: Colors.white),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 20,
                                      offset: const Offset(5, 5),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.grey.shade300,
                                  size: 80.0,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(80, 80, 0, 0),
                                child: Icon(
                                  Icons.add_circle,
                                  color: Colors.grey.shade700,
                                  size: 25.0,
                                ),
                              ),
                            ],
                          ),
                        ),

                        //First Name Start
                        SizedBox(height: 30,),
                        Container(
                          child: TextFormField(
                            controller: first_name,
                            validator: (value) {
                              if (value.isEmpty)
                                return "Please Enter Your First Name";
                              return null;
                            },
                            decoration: ThemeHelper().textInputDecoration(
                                'First Name', 'Please Enter Your First Name'),
                          ),

                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        //First Name End

                        //Last name Start
                        SizedBox(height: 30,),
                        Container(
                          child: TextFormField(
                            controller: last_name,
                            validator: (value) {
                              if (value.isEmpty)
                                return "Please Enter Your Last Name";
                              return null;
                            },
                            decoration: ThemeHelper().textInputDecoration(
                                'Last Name', 'Enter your Last Name'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),

                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            controller: email,
                            decoration: ThemeHelper().textInputDecoration(
                                "Email id", "Enter your Mail id"),
                            keyboardType: TextInputType.phone,
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Visibility(
                          visible: true,
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                                "Mobile Number", "Enter your mobile number"),
                            controller: contact,
                            keyboardType: TextInputType.phone,

                          ),
                          // decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),

                        //Total Expirence Start
                        SizedBox(height: 30,),
                        Visibility(
                          visible: true,
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                                "Password", "Enter your Password"),
                            controller: password,
                            keyboardType: TextInputType.phone,
                          ),
                          // decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),

                        SizedBox(height: 30,),
                        Visibility(
                          visible: false,
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                                " ", "token "),
                            controller: token,
                            keyboardType: TextInputType.phone,
                          ),
                          // decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
//Total Experience End


                        SizedBox(height: 15.0),
                        FormField<bool>(
                          builder: (state) {
                            return Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Checkbox(
                                        value: checkboxValue,
                                        onChanged: (value) {
                                          setState(() {
                                            checkboxValue = value;
                                            state.didChange(value);
                                          });
                                        }),
                                    Text("I accept all terms and conditions.",
                                      style: TextStyle(color: Colors.grey),),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    state.errorText ?? '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: Theme
                                        .of(context)
                                        .errorColor, fontSize: 12,),
                                  ),
                                )
                              ],
                            );
                          },

                        ),
                        //Apply Button open
                        SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper().buttonBoxDecoration(
                              context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            onPressed: () async {
                              AlertDialog alert = AlertDialog(
                                elevation: 6.0,
                                content: Text("Registration successfully"),
                                actions: [
                                ],
                              );
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alert;
                                },
                              );

                              print('Posting data...');
                              await postData().then((value){
                                //print(value);
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  40, 10, 40, 10),
                              child: Text(
                                "Submit".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          //Apply Now button open
                        )],

                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  HeaderWidget(int i, bool bool, IconData person_add_alt_1_rounded) {}

}
