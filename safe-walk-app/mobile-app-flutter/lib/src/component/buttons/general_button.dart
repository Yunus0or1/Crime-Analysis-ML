import 'package:flutter/material.dart';

class GeneralButton extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  final String? message;
  final Function()? onPressAction;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  GeneralButton(
      {this.width,
      this.height,
      this.color,
      this.message,
      this.onPressAction,
      this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: RaisedButton(
        onPressed: () {
          if(onPressAction != null) onPressAction!();
        },
        child: Text(
          message!,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        color: color,
        shape: Border.all(width: 1.0, color: Colors.transparent),
      ),
    );
  }
}
