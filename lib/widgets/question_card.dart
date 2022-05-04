import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/models/data_model.dart';
import 'package:quiz_app/screens/question_no.dart';

class QuestionCard extends StatefulWidget {
  const QuestionCard(
      {Key? key,
      @required this.index,
      @required this.optionName,
      @required this.correctAnswer,
      @required this.questNo})
      : super(key: key);

  final int? index;
  final String? optionName;
  final bool? correctAnswer;
  final int? questNo;

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  bool visible = true;
  int? selectedIndex;
  List? data = [];

  Color? cardColor() {
    switch (widget.index) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.teal;
      case 2:
        return Colors.yellow[800];
      case 3:
        return Colors.red[300];
    }
  }

  Color? changeCardColor() {
    if (widget.correctAnswer!) {
      return Colors.green;
    } else {
      return Colors.redAccent.shade700;
    }
  }

  bool? checkVisibility() {
    if (widget.index == selectedIndex) {
      return true;
    } else {
      return false;
    }
  }

  void ansBtnClick(int index) async {
    setState(() {
      selectedIndex = index;
    });
    controller!.stop();
    if (context.read<DataModel>().isBtnPressed) {
    } else {
      pageNaviTimer!.cancel();
      context.read<DataModel>().btnPressed(true);
      context.read<DataModel>().changeQuestNo();
      context.read<DataModel>().wrongAnsCheck(false);
      await Future.delayed(const Duration(seconds: 1));
      context.read<DataModel>().btnColorChange(true);
      if (widget.correctAnswer!) {
        showAnsStatusPopUp("Correct", Colors.green, context);
        context.read<DataModel>().changeContainerWidth(widget.correctAnswer!);
        context.read<DataModel>().rankChange();
      } else {
        context.read<DataModel>().wrongAnsCheck(true);
        showAnsStatusPopUp("Wrong", Colors.redAccent.shade700, context);
        context.read<DataModel>().changeContainerWidth(widget.correctAnswer!);
      }

      await Future.delayed(const Duration(seconds: 2));
      await Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
            child: QuestionNumber(
                questionNo: context.read<DataModel>().questionNo),
            type: PageTransitionType.rightToLeft,
            duration: const Duration(milliseconds: 800)),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ansBtnClick(widget.index!);
      },
      child: Visibility(
        visible: context.watch<DataModel>().isBtnPressed
            ? context.watch<DataModel>().wrongAns
                ? true
                : checkVisibility()!
            : true,
        maintainState: true,
        maintainAnimation: true,
        maintainSize: true,
        child: Container(
            height: 80,
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
                color: context.watch<DataModel>().colorChange
                    ? changeCardColor()
                    : cardColor(),
                borderRadius: BorderRadius.circular(5),
                border: context.watch<DataModel>().colorChange
                    ? Border.all(color: Colors.white, width: 2)
                    : Border.all(color: Colors.transparent)),
            child: Center(
              child: Text(
                widget.optionName!,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            )),
      ),
    );
  }
}
