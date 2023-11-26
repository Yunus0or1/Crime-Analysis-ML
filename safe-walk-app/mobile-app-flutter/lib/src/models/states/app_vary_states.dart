import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:safe_walk_mobile/src/models/main/AppData.dart';
import 'package:safe_walk_mobile/src/models/states/app_state.dart';

class AppVariableStates {
  bool askGPSLocation = false;
  AppData appState = new AppData(
      appVersion: 1,
      questionVersion: 1,
      updateMust: false,
      questionList: []);

  GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>(debugLabel: "navigator");

  static AppVariableStates? _boolState;
  static AppVariableStates get instance => _boolState ??= AppVariableStates();
}
