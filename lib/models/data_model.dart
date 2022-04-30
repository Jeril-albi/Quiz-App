import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class DataModel extends ChangeNotifier {
  List baseData = [];
  bool isBtnPressed = false;
  bool colorChange = false;
  double containerWidth = 0;
  bool wrongAns = false;
  int questionNo = 1;
  int streak = 0;

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
    } else {
      containerWidth = 0;
      streak = 0;
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
}
