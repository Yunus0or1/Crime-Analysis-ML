import 'dart:convert';
import 'package:safe_walk_mobile/src/models/main/AppData.dart';
import 'package:safe_walk_mobile/src/models/states/app_state.dart';
import 'package:safe_walk_mobile/src/models/states/app_vary_states.dart';
import 'package:safe_walk_mobile/src/util/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Store {
  AppState? _appState;

  final String _APP_DATA_KEY = 'APP_DATA_KEY';

  Store() {}

  Future _initAppDataFromDB() async {
    final prefs = await SharedPreferences.getInstance();
    // deleteAppData();
    if (prefs.containsKey(_APP_DATA_KEY)) {
      print("SharedPreference Key found");
      try {
        Map<String, dynamic> data =
            json.decode(prefs.getString(_APP_DATA_KEY)!);
        _appState = AppState.fromJsonMap(data);
      } catch (err) {
        print("SharedPreference Parse error");
        print(err);
        prefs.remove(_APP_DATA_KEY);
        _appState = new AppState();
      }
    } else {
      print("SharedPreference Key not found");
      _appState = new AppState();
    }
  }

  Future putAppData() async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> jsonMap = _appState!.toJsonMap();
    prefs.setString(_APP_DATA_KEY, json.encode(jsonMap));
    print("Write sharedPreference");
  }

  Future deleteAppData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_APP_DATA_KEY);
    _appState = new AppState();
  }

  bool checkIfUserIdExists() {
    if (Store.instance!.appState!.userId == '') return false;
    return true;
  }

  setFirebasePushNotificationToken(String? firebasePushNotificationToken) async {
    appState?.firebasePushNotificationToken = firebasePushNotificationToken;
    await putAppData();
  }

  Future<String> createUserId() async {
    String userId = Util.createUUID();
    Store.instance!._appState!.userId = userId;
    await putAppData();
    return userId;
  }

  Future<void> updateUserId(String userId) async {
    Store.instance!._appState!.userId = userId;
    await putAppData();
  }

  Future<void> updateAppData(AppData? appData) async {
    Store.instance!._appState!.appData = appData;
    await putAppData();
  }

  setFirebaseSMSToken(String firebaseToken) {}

  getFirebaseSMSToken() {}

  // ----------------------------------------------------------------------- //
  // This is called before getting instance.

  static Future initStore() async {
    _instance = Store();
    await _instance!._initAppDataFromDB();
  }

  // -------------------------------------------------------------------------//

  static Store? _instance;

  static Store? get instance => _instance;

  AppState? get appState => _appState;
}
