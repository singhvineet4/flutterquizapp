import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> createAlbum(String postedata) async {
  final http.Response response = await http.post(
    Uri.parse('https://www.hiringmirror.com/api/submit-quiz-answers.php'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'postedata': postedata,
    }),
  );
    print(response);
  if (true) {
    return Album.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to create album.');
  }
}

class Album {
  final int id;
  final String message;

  Album({ this.id, this.message});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      message: json['message'],
    );
  }
}



class Answer extends StatefulWidget {
  const Answer({Key key}) : super(key: key);

  @override
  _AnswerState createState() {
    return _AnswerState();
  }
}

class _AnswerState extends State<Answer> {
  final TextEditingController _controller = TextEditingController();
 Future<Album> _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Creating Data',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Answer Submit'),
          backgroundColor: Colors.green,
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          // ignore: unnecessary_null_comparison
          child: (_futureAlbum == null)
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                child: const Text('Submit Quiz'),
                onPressed: () {
                  setState(() {
                    _futureAlbum = createAlbum(_controller.text);
                  });
                },
              ),
            ],
          )
              : FutureBuilder<Album>(
            future: _futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.message);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
