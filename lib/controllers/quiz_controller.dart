import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/question_model.dart';
import '../screens/result_screen/result_screen.dart';
import '../screens/welcome_screen.dart';

class QuizController extends GetxController{
  String name = '';
 //question variables
  int get countOfQuestion => _questionsList.length;
  final List<QuestionModel> _questionsList = [
    QuestionModel(
      id: 1,
      question:
          "Bean classes pre-registered in the web application context by default ? ",
      //answer: 2,
      options: ['DefaultAnnotationHandlerMapping', 'AnnotationMethodHandlerAdapter', 'All of the mentioned', 'None of the mentioned '],
    ),
    QuestionModel(
      id: 2,
      question: "The configuration starts with the inboundHelloJMSMessageChannel channel, which tells Spring Integration what to name the point-to-point connection from the message queue to the: ",
      //answer: 1,
      options: ['service-activator', 'service', 'All of the mentioned', 'None of the mentioned'],
    ),
    QuestionModel(
      id: 3,
      question: "If you are deploying into a Java EE 5 (or better) container, you may simply create a bean that is annotated with:",
      //answer: 2,
      options: ['javax.jws.WebService', 'javax.jws.WebServiceProvider', 'all of the mentioned', 'None of the mentioned'],
    ),
    QuestionModel(
      id: 4,
      question: "For two transactions T1 and T2, T1 reads some rows from a table and then T2 inserts new rows into the table.",
      //answer: 1,
      options: ['Dirty Read', 'Nonrepeatable read', 'Phantom read', 'Lost Updates'],
    ),
    QuestionModel(
      id: 5,
      question:
          "Method has a warning from the Java compiler because of an unchecked conversion from List to List.",
      //answer: 3,
      options: ['findAll()', 'query()', 'update()', 'batchUpdate'],
    ),
    QuestionModel(
      id: 6,
      question: "A database and some sort of persistence mechanism using command: ",
      //answer: 2,
      options: ['persistence setup â€“database HYPERSONIC_IN_MEMORY â€“provider HIBERNATE', 'persistence setup â€“database HYPERSONIC_IN_MEMORY â€“provider', 'persistence setup â€“database HYPERSONIC_IN_MEMORY', 'persistence â€“database HYPERSONIC_IN_MEMORY â€“provider HIBERNATE'],
    ),
    QuestionModel(
      id: 7,
      question: "Annotation which receives a value in the form regexp=&rdquo;.+@.+\\\\.[a-z]+&rdquo;.",
     // answer: 3,
      options: ['@Pattern', '@EmailRecognizer', '@Email', '@Null'],
    ),
    QuestionModel(
      id: 8,
      question: "Which component can be used for sending messages from one application to another?",
     // answer: 3,
      options: ['webapp', 'client', 'server', 'mq'],
    ),
    QuestionModel(
      id: 9,
      question:
      "Which of these operators is used to allocate memory to array variable in Java? ",
      //answer: 2,
      options: ['new malloc', 'malloc', 'new', 'alloc '],
    ),
    QuestionModel(
      id: 10,
      question: "Method to retrieve Spring Application context. ",
     // answer: 1,
      options: ['WebApplicationContextUtils.getRequiredWebApplicationContext()', 'WebApplicationContextUtils.getRequiredWeb()', 'WebApplicationUtils.getRequiredWebApplicationContext()', 'None of the mentioned'],
    ),
  ];

  List<QuestionModel> get questionsList => [..._questionsList];


  bool _isPressed = false;


  bool get isPressed => _isPressed; //To check if the answer is pressed


  double _numberOfQuestion = 1;


  double get numberOfQuestion => _numberOfQuestion;


  int? _selectAnswer;


  int? get selectAnswer => _selectAnswer;


  int? _correctAnswer;


  int _countOfCorrectAnswers = 0;


  int get countOfCorrectAnswers => _countOfCorrectAnswers;

  //map for check if the question has been answered
  final Map<int, bool> _questionIsAnswerd = {};


  //page view controller
  late PageController pageController;

  //timer
  Timer? _timer;


  final maxSec = 15;


  final RxInt _sec = 15.obs;


  RxInt get sec => _sec;

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    resetAnswer();
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  //get final score
  double get scoreResult {
    return _countOfCorrectAnswers * 100 / _questionsList.length;
  }

  void checkAnswer(QuestionModel questionModel, int selectAnswer) {
    _isPressed = true;

    _selectAnswer = selectAnswer;
    //_correctAnswer = questionModel.answer;

    if (_correctAnswer == _selectAnswer) {
      _countOfCorrectAnswers++;
    }
    stopTimer();
    _questionIsAnswerd.update(questionModel.id, (value) => true);
    Future.delayed(const Duration(milliseconds: 500)).then((value) => nextQuestion());
    update();
  }

  //check if the question has been answered
  bool checkIsQuestionAnswered(int quesId) {
    return _questionIsAnswerd.entries
        .firstWhere((element) => element.key == quesId)
        .value;
  }

  void nextQuestion() {
    if (_timer != null || _timer!.isActive) {
      stopTimer();
    }

    if (pageController.page == _questionsList.length - 1) {
      Get.offAndToNamed(ResultScreen.routeName);
    } else {
      _isPressed = false;
      pageController.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.linear);

      startTimer();
    }
    _numberOfQuestion = pageController.page! + 2;
    update();
  }

  //called when start again quiz
  void resetAnswer() {
    for (var element in _questionsList) {
      _questionIsAnswerd.addAll({element.id: false});
    }
    update();
  }

  //get right and wrong color
  Color getColor(int answerIndex) {
    if (_isPressed) {
      if (answerIndex == _correctAnswer) {
        return Colors.green.shade700;
      } else if (answerIndex == _selectAnswer &&
          _correctAnswer != _selectAnswer) {
        return Colors.red.shade700;
      }
    }
    return Colors.white;
  }

  //het right and wrong icon
  IconData getIcon(int answerIndex) {
    if (_isPressed) {
      if (answerIndex == _correctAnswer) {
        return Icons.done;
      } else if (answerIndex == _selectAnswer &&
          _correctAnswer != _selectAnswer) {
        return Icons.close;
      }
    }
    return Icons.close;
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

  void stopTimer() => _timer!.cancel();
  //call when start again quiz
  void startAgain() {
    _correctAnswer = null;
    _countOfCorrectAnswers = 0;
    resetAnswer();
    _selectAnswer = null;
    Get.offAllNamed(WelcomeScreen.routeName);
  }
}
