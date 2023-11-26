import 'dart:ffi';
import 'package:safe_walk_mobile/src/models/main/Question.dart';

class AppData {
  int appVersion;
  int questionVersion;
  bool updateMust;
  List<Question> questionList;

  AppData({
    required this.appVersion,
    required this.questionVersion,
    required this.updateMust,
    required this.questionList,
  });

  factory AppData.fromJson(Map<String, dynamic> jsonData) {
    return AppData(
      appVersion: jsonData['appVersion'],
      questionVersion: jsonData['questionVersion'],
      updateMust: jsonData['updateMust'],
      questionList: List<dynamic>.from(jsonData['questionList']
              .map((singleQuestion) => Question.fromJson(singleQuestion)))
          .cast<Question>(),
    );
  }

  Map<String, dynamic> toJsonMap() {
    final data = Map<String, dynamic>();
    data['appVersion'] = appVersion;
    data['questionVersion'] = questionVersion;
    data['updateMust'] = updateMust;
    data['questionList'] = questionList
        .map((singleQuestion) => singleQuestion.toJsonMap())
        .toList();
    return data;
  }
}
