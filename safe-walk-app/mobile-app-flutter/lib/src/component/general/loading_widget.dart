import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final String? status;
  final bool displayRetry;
  final String? retryTitle;
  final Function()? retryAction;

  LoadingWidget({
    this.status,
    this.displayRetry = false,
    this.retryAction,
    this.retryTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: buildChildren(context),
        ),
      ),
    );
  }

  List<Widget> buildChildren(BuildContext context) {
    // Build children list
    final children = <Widget>[];
    // add retry or progressbar
    if (displayRetry) {
      children.add(buildRetryButton(context));
    } else {
      children.add(SizedBox(
          height: 30.0,
          width: 30.0,
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.black),
              strokeWidth: 5.0)));
    }
    // add status
    children.add(
      Text(
        status ?? "Please wait...",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.grey),
      ),
    );
    // Add padding to all children
    return children.map((child) {
      return Padding(
        padding: EdgeInsets.all(10.0),
        child: child,
      );
    }).toList();
  }

  Widget buildRetryButton(BuildContext context) {
    return MaterialButton(
      child: Text(retryTitle ?? 'Refresh'),
      onPressed: () => onRetryButtonPress(context),
      color: Colors.black,
      textColor: Colors.black,
      highlightColor: Colors.black,
    );
  }

  void onRetryButtonPress(BuildContext context) {
    if (retryAction != null) {
      retryAction!();
    }
  }
}
