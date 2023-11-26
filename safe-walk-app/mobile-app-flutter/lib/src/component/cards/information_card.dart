import 'package:safe_walk_mobile/src/models/general/intro_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String? title;
  final List<UIViewData>? dataList;
  final double? height;
  final double? width;
  final int? maxLines;

  final TextStyle textStyle = TextStyle(
    fontSize: 14.0,
    color: Colors.black,
  );

  InfoCard(
      {this.title,
      this.dataList,
      this.height,
      this.width,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: width,
      padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
      child: Material(
        shadowColor: Colors.grey[100]!.withOpacity(0.4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
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
        introTitle(),
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
    final children = [] ;

    dataList!.forEach((uiViewData) {
      children.add(Row(
        children: [
          SizedBox(width: 15),
          Expanded(
            child: Text(
              uiViewData.textData!,
              style: textStyle,
              maxLines: maxLines ?? 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ));
      children.add(SizedBox(height: 5));
    });

    return Column(
      children:  children.map<Widget>((element) => element).toList(),
    );
  }

  Widget introTitle() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        title!,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15.0,
          color: Colors.black,
        ),
      ),
    );
  }
}
