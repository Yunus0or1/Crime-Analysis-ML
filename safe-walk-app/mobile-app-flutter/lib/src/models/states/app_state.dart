import 'package:safe_walk_mobile/src/models/main/AppData.dart';
import 'package:safe_walk_mobile/src/models/main/Question.dart';

class AppState {
  String? userId = '';
  String? firebasePushNotificationToken = '';

  AppData? appData = new AppData(
      appVersion: 1,
      questionVersion: 1,
      updateMust: false,
      questionList: []);

  AppState() {}

  AppState.fromJsonMap(Map<String, dynamic> data) {
    userId = data['userId'];
    firebasePushNotificationToken = data['firebasePushNotificationToken'];
    appData = AppData.fromJson(data['appData']);
  }

  Map<String, dynamic> toJsonMap() {
    final data = Map<String, dynamic>();
    data['userId'] = userId;
    data['firebasePushNotificationToken'] = firebasePushNotificationToken;
    data['appData'] = appData!.toJsonMap();
    return data;
  }
}
