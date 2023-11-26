import 'package:safe_walk_mobile/src/models/general/intro_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safe_walk_mobile/src/models/main/Question.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  final double? height;
  final double? width;
  final int? maxLines;
  final Function(Question question, String singleChoice) updateQuestionnaire;

  final TextStyle textStyle = TextStyle(
    fontSize: 16.0,
    color: Colors.white,
  );

  QuestionCard(
      {required this.question,
      this.height,
      this.width,
      this.maxLines,
      required this.updateQuestionnaire});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: width,
      padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
      child: Material(
        shadowColor: Colors.grey[100]!.withOpacity(0.4),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        elevation: 6,
        clipBehavior: Clip.antiAlias, // Add This
        child: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        SizedBox(height: 10),
        questionTitle(),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 20, bottom: 10.0),
          child: buildList(),
        ),
      ],
    );
  }

  Widget buildList() {
    List<Widget> children = [];

    children.addAll(question.choiceList
        .map((singleChoice) => Padding(
              padding: EdgeInsets.all(5),
              child: ChoiceChip(
                padding: EdgeInsets.all(10),
                label: Text(
                  singleChoice,
                  style: textStyle,
                  maxLines: maxLines ?? 3,
                  overflow: TextOverflow.ellipsis,
                ),
                selectedColor: Colors.indigo,
                backgroundColor: Colors.grey[600],
                selected: singleChoice == question.value,
                onSelected: (bool selected) {
                  updateQuestionnaire(question, singleChoice);
                },
              ),
            ))
        .toList());

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      children: children,
    );
  }

  Widget questionTitle() {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 5, left: 15),
      alignment: Alignment.centerLeft,
      child: Text(
        question.question,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
          color: Colors.black,
        ),
      ),
    );
  }
}
