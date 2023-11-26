import 'dart:convert';

class Question {
  String question;
  String fieldName;
  List<String> choiceList;
  String value;

  Question({
    required this.question,
    required this.fieldName,
    required this.choiceList,
    required this.value,
  });

  factory Question.fromJson(Map<String, dynamic> jsonData) {
    return Question(
        question: jsonData['question'],
        fieldName: jsonData['fieldName'],
        choiceList: List<dynamic>.from(
                jsonData['choiceList'].map((singleChoice) => singleChoice))
            .cast<String>(),
        value: jsonData['value']);
  }

  Map<String, dynamic> toJsonMap() {
    final data = Map<String, dynamic>();
    data['question'] = question;
    data['fieldName'] = fieldName;
    data['choiceList'] = choiceList;
    data['value'] = value;

    return data;
  }
}
