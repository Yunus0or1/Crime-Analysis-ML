import 'package:safe_walk_mobile/src/component/general/common_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundActionButton extends StatelessWidget {
  final bool? isProcessing;
  final void Function()? callBackOnSubmit;
  final String? title;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? minWidth;
  final Color? color;
  final Color? textColor;
  final double? textFontSize;
  final FontWeight? fontWeight;
  final bool? showNextIcon;

  RoundActionButton(
      {this.isProcessing,
      this.callBackOnSubmit,
      this.height,
      this.title,
      this.color,
      this.padding,
      Key? key,
      this.textColor,
      this.textFontSize,
      this.showNextIcon,
      this.minWidth,
      this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      padding: padding ?? EdgeInsets.fromLTRB(5, 5, 5, 5),
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          MaterialButton(
            height: height ?? 10,
            shape: const CircleBorder(),
            onPressed: () => (isProcessing == false) ? callBackOnSubmit!() : () {},
            child: Container(),
            color: color ?? Colors.grey,
          ),
          MaterialButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () => (isProcessing == false) ? callBackOnSubmit!() : () {},
            child: CustomText(
              title!,
              fontSize: textFontSize,
              fontWeight: fontWeight ?? FontWeight.normal,
              color: textColor ?? Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
