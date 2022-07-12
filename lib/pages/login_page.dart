import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:opentrivia/pages/quiz.dart';
import '../comman/theme_helper.dart';
import '../models/Header.dart';
import '../ui/pages/demo-registration.dart';


class LoginPageo extends StatefulWidget{
 //const LoginPage{key? key }): super(key:key);
  @override
_LoginPageState createState() => _LoginPageState();

}


class _LoginPageState extends State<LoginPageo> {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  void login(String email , password) async {

    try{

      Response response = await post(
          Uri.parse('https://www.hiringmirror.com/api/login.php'),
          body: {
            'email' : 'singhvineet4@gmail.com',
            'password' : 'Noida@123'
          }
      );

      if(response.statusCode == 200){

        var data = jsonDecode(response.body.toString());
        print(data);
        print('Login successfully');

      }else {
        print('failed');
      }
    }catch(e){
      print(e.toString());
    }
  }

  double _headerHeight = 250;
  Key _formKey = GlobalKey<FormState>();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  String errorText = '';
   IconData errorIcon;
  double errorContainerHeight = 0.0;
  bool isApiCallProcess = false;
  // Initially password is obscure
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight),
            ),
            SafeArea(
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: [
                      Text(
                        'Signin into your account',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        'HiringMirror',
                        style: TextStyle(
                            fontSize: 60, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 30.0),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextField(
                                focusNode: emailFocusNode,
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: ThemeHelper().textInputDecoration(
                                    'User Name', 'Enter Your user name'),
                              ),
                              SizedBox(height: 30.0),
                              TextField(
                                focusNode: passwordFocusNode,
                                controller: passwordController,
                                //keyboardType: TextInputType.password,
                                obscureText: true,
                                decoration: ThemeHelper().textInputDecoration(
                                  'Password', 'Enter Your Password',),
                              ),
                              SizedBox(height: 15.0),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  child: Text("Forget Your Password?",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: ThemeHelper().buttonBoxDecoration(
                                    context),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        40, 10, 40, 10),
                                    child: Text('Sign In'.toUpperCase(),
                                      style: TextStyle(fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),),
                                  ),
                                  onPressed: () {
                                    login(emailController.text.toString(), passwordController.text.toString());
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) =>
                                            ProfilePage()));
                                  },
                                ),

                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                                //child: Text('Don\'t have and account? Create'),
                                child: Text.rich(
                                    TextSpan(
                                        children: [
                                          TextSpan(
                                              text: "Don\'t have and account?"),
                                          TextSpan(
                                            text: 'Create',
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Registrationdemo()));
                                              },
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Theme
                                                    .of(context)
                                                    .accentColor),
                                          )
                                        ]
                                    )
                                ),
                              )
                            ],
                          )
                      ),
                    ],
                  ),
                )

            )
          ],
        ),
      ),
    );
  }
}



