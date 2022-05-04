class JsonModel {
  JsonModel({
    this.quizData,
  });

  List<QuizData>? quizData;

  factory JsonModel.fromJson(Map<String, dynamic> json) => JsonModel(
        quizData: List<QuizData>.from(
            json["quiz_data"].map((x) => QuizData.fromJson(x))),
      );
}

class QuizData {
  QuizData({
    this.questionId,
    this.question,
    this.time,
    this.options,
  });

  int? questionId;
  String? question;
  int? time;
  List<Option>? options;

  factory QuizData.fromJson(Map<String, dynamic> json) => QuizData(
        questionId: json["question_id"],
        question: json["question"],
        time: json["time"],
        options:
            List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
      );
}

class Option {
  Option({
    this.option,
    this.correct,
  });

  String? option;
  bool? correct;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        option: json["option"],
        correct: json["correct"],
      );
}
