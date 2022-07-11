import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/question.dart';
import '../../pages/quiz.dart';
import 'answer-option.dart';

class QuestionCard extends StatelessWidget {

const QuestionCard({Key key, this.question}) : super(key: key);
final Question question;

@override
Widget build(BuildContext context) {
  return SingleChildScrollView(
    child: Container(
        height: 450,
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                question.question,
                style: Theme.of(context).textTheme.headline6,
              ),
              //const SizedBox(height: 15),
              const Spacer(
                flex: 1,
              ),
              ...List.generate(
                  question.answers.length,
                      (index) => Column(
                    children: [
                      AnswerOption(
                          questionId: question.checkIsQuestionAnswered(questionId),
                          text: question.answers[index],
                          index: index,
                          onPressed: () => Get.find<ProfilePage>()
                              .checkAnswer(question, index)),
                      const SizedBox(
                        height: 15,
                      )
                    ],
                  )),
              const Spacer(
                flex: 1,
              ),
            ],
          ),
        )),
  );
}
}
