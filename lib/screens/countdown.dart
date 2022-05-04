import 'package:circular_countdown/circular_countdown.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quiz_app/screens/home.dart';
import 'package:quiz_app/screens/question_no.dart';

class CountDown extends StatelessWidget {
  const CountDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[900],
      body: Center(
        child: TimeCircularCountdown(
            unit: CountdownUnit.second,
            countdownTotal: 3,
            countdownCurrentColor: Colors.yellow,
            diameter: 300,
            textStyle: const TextStyle(color: Colors.white, fontSize: 100),
            onFinished: () => Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(
                    child: const QuestionNumber(
                      questionNo: 1,
                    ),
                    type: PageTransitionType.leftToRightWithFade,
                    duration: const Duration(milliseconds: 800),
                  ),
                  (route) => false,
                )),
      ),
    );
  }
}
