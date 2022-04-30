import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/models/data_model.dart';
import 'package:quiz_app/screens/home.dart';
import 'package:quiz_app/screens/result.dart';

class QuestionNumber extends StatefulWidget {
  const QuestionNumber({Key? key, @required this.questionNo}) : super(key: key);
  final int? questionNo;
  @override
  State<QuestionNumber> createState() => _QuestionNumberState();
}

class _QuestionNumberState extends State<QuestionNumber> {
  @override
  void initState() {
    Timer(
        const Duration(milliseconds: 900),
        () => Navigator.pushReplacement(
            context,
            PageTransition(
                child: widget.questionNo! <=
                        context.read<DataModel>().baseData.length
                    ? Home(
                        questionNo: context.read<DataModel>().questionNo,
                      )
                    : const Result(),
                type: PageTransitionType.fade,
                duration: const Duration(seconds: 2))));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<DataModel>().readJson();
    return Scaffold(
      backgroundColor: Colors.purple[900],
      body: Center(
        child: Text(
          widget.questionNo! <= context.read<DataModel>().baseData.length
              ? "${widget.questionNo}"
              : "THE END",
          style: const TextStyle(
              color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
