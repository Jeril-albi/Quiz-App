import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Timer? pageNaviTimer;
showAnsStatusPopUp(String? status, Color? color, BuildContext context) {
  return showModalBottomSheet(
      barrierColor: Colors.transparent,
      useRootNavigator: true,
      context: context,
      builder: (_) => Container(
            width: double.infinity,
            height: 50,
            color: color,
            child: Center(
              child: Text(
                status!,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ));
}

AnimationController? controller;
late Animation<double> valAnimation;

class DataModel extends ChangeNotifier {
  List baseData = [];
  bool isBtnPressed = false;
  bool colorChange = false;
  double containerWidth = 0;
  bool wrongAns = false;
  int questionNo = 1;
  int streak = 0;
  int rank = 0;
  double score = 0;
  int crctAns = 0, wrngAns = 0;

  Future<void> readJson() async {
    String response = await rootBundle.loadString('assets/data/quiz_data.json');
    final data = await json.decode(response);
    baseData = data;
    notifyListeners();
  }

  void btnPressed(bool click) {
    isBtnPressed = click;
    notifyListeners();
  }

  void btnColorChange(bool change) {
    colorChange = change;
    notifyListeners();
  }

  void changeContainerWidth(bool answer) {
    if (answer) {
      switch (containerWidth.toInt()) {
        case 0:
          containerWidth += 72;
          notifyListeners();
          break;
        case 72:
          containerWidth += 28;
          notifyListeners();
          break;
        case 100:
          containerWidth += 50;
          notifyListeners();
          break;
        case 150:
          containerWidth = 0;
          containerWidth += 72;
          notifyListeners();
          break;
        default:
          containerWidth = 0;
          containerWidth += 140;
          notifyListeners();
      }
      streak++;
      crctAns++;
      score += 814;
    } else {
      containerWidth = 0;
      streak = 0;
      wrngAns++;
      notifyListeners();
    }
  }

  void wrongAnsCheck(bool status) {
    wrongAns = status;
    notifyListeners();
  }

  void changeQuestNo() {
    if (questionNo <= baseData.length) {
      questionNo++;
    } else {
      questionNo = 1;
    }
    notifyListeners();
  }

  void nonAnsselected() {
    btnPressed(true);
    changeQuestNo();
    wrongAnsCheck(true);
    btnColorChange(true);
    changeContainerWidth(false);
  }

  void rankChange() {
    if (rank == 0) {
      rank = 9;
    } else {
      rank -= 2;
    }
  }

  void resetData() {
    changeQuestNo();
    changeContainerWidth(false);
    rank = 0;
    crctAns = 0;
    wrngAns = 0;
    score = 0;
  }
}
