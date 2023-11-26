import 'dart:convert';
import 'dart:io';
import 'package:safe_walk_mobile/src/models/general/server_config_data.dart';
import 'package:safe_walk_mobile/src/store/store.dart';
import 'package:http/http.dart' as http;

class DataClient {
  DataClient() {
    print("CustomerClient Initialized");
  }

  Future<dynamic> getAppData() async {
    final http.Response response = await http.get(
      ServerConfigData.instance.mainServerAddress(path: '/get_app_data/'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ).timeout(Duration(seconds: 3));

    final jsonResponse = json.decode(response.body);
    return jsonResponse;
  }

  Future<dynamic> submitUserQuestionnaire(String bodyData) async {
    final http.Response response = await http
        .post(
          ServerConfigData.instance
              .mainServerAddress(path: '/submit_user_questionnaire/'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: bodyData,
        )
        .timeout(Duration(seconds: 3));

    final jsonResponse = json.decode(response.body);
    return jsonResponse;
  }

  Future<dynamic> submitUserLocationData(String bodyData) async {
    final http.Response response = await http
        .post(
          ServerConfigData.instance
              .mainServerAddress(path: '/submit_location_data/'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: bodyData,
        )
        .timeout(Duration(seconds: 3));

    final jsonResponse = json.decode(response.body);
    return jsonResponse;
  }

  Future<dynamic> checkLocationSafety(String bodyData) async {
    final http.Response response = await http
        .post(
          ServerConfigData.instance
              .mainServerAddress(path: '/check_location_safety/'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: bodyData,
        )
        .timeout(Duration(seconds: 3));

    final jsonResponse = json.decode(response.body);
    return jsonResponse;
  }

  static DataClient? _instance;
  static DataClient get instance => _instance ??= DataClient();
}
