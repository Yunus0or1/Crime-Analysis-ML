import 'package:safe_walk_mobile/src/client/data_client.dart';
import 'package:safe_walk_mobile/src/client/location_client.dart';
import 'package:safe_walk_mobile/src/models/general/app_enum.dart';
import 'package:safe_walk_mobile/src/models/general/client_enum.dart';
import 'package:safe_walk_mobile/src/models/location/gps_location.dart';
import 'package:safe_walk_mobile/src/models/main/AppData.dart';
import 'package:safe_walk_mobile/src/models/main/LocationData.dart';
import 'package:safe_walk_mobile/src/models/main/Question.dart';
import 'package:safe_walk_mobile/src/models/states/app_vary_states.dart';
import 'package:safe_walk_mobile/src/repo/location_repo.dart';
import 'package:safe_walk_mobile/src/store/store.dart';
import 'package:safe_walk_mobile/src/util/date_util.dart';
import 'package:tuple/tuple.dart';
import 'dart:convert';

class DataRepo {
  DataClient? _dataClient;

  DataClient? getCustomerClient() {
    if (_dataClient == null) _dataClient = new DataClient();
    return _dataClient;
  }

  static final DataRepo _instance = DataRepo();
  static DataRepo get instance => _instance;

  Future<Tuple2<void, String?>> getAppData() async {
    int retry = 0;

    while (retry++ < 2) {
      try {
        final appDataResponse =
            await DataRepo.instance.getCustomerClient()!.getAppData();

        if (appDataResponse['status'] == true) {
          AppData appData = AppData.fromJson(appDataResponse);
          AppVariableStates.instance.appState = appData;
          return Tuple2(null, ClientEnum.RESPONSE_SUCCESS);
        }
        if (appDataResponse['status'] == false) {
          return Tuple2(null, appDataResponse['responseMessage']);
        }
      } catch (err) {
        print("Error in getAppData() in DataRepo");
        print(err);
      }
    }
    return Tuple2(null, ClientEnum.RESPONSE_CONNECTION_ERROR);
  }

  Future<Tuple2<void, String?>> submitQuestionData(
      List<Question> questionList) async {
    int retry = 0;

    while (retry++ < 2) {
      try {
        String? userId;
        if (!Store.instance!.checkIfUserIdExists()) {
          userId = null;
        } else {
          userId = Store.instance!.appState!.userId;
        }

        String questionRequest = jsonEncode(<String, dynamic>{
          'userId': userId,
          'firebasePushNotificationToken':
              Store.instance!.appState!.firebasePushNotificationToken,
          'questionList': questionList
              .map((singleQuestion) => singleQuestion.toJsonMap())
              .toList()
        });

        final questionDataSubmissionResponse = await DataRepo.instance
            .getCustomerClient()!
            .submitUserQuestionnaire(questionRequest);

        if (questionDataSubmissionResponse['status'] == true) {
          userId = questionDataSubmissionResponse['userId'];
          Store.instance!.updateUserId(userId ?? "");
          return Tuple2(null, ClientEnum.RESPONSE_SUCCESS);
        }
        if (questionDataSubmissionResponse['status'] == false) {
          return Tuple2(
              null, questionDataSubmissionResponse['responseMessage']);
        }
      } catch (err) {
        print("Error in submitQuestionData() in DataRepo");
        print(err);
      }
    }
    return Tuple2(null, ClientEnum.RESPONSE_CONNECTION_ERROR);
  }

  Future<Tuple2<void, String?>> submitLocationData(
      LocationData locationData) async {
    int retry = 0;

    while (retry++ < 2) {
      try {
        final locationDataSubmissionResponse = await DataRepo.instance
            .getCustomerClient()!
            .submitUserLocationData(locationData.toJsonEncodedString());

        if (locationDataSubmissionResponse['status'] == true) {
          return Tuple2(null, ClientEnum.RESPONSE_SUCCESS);
        }
        if (locationDataSubmissionResponse['status'] == false) {
          return Tuple2(
              null, locationDataSubmissionResponse['responseMessage']);
        }
      } catch (err) {
        print("Error in submitLocationData() in DataRepo");
        print(err);
      }
    }
    return Tuple2(null, ClientEnum.RESPONSE_CONNECTION_ERROR);
  }

  Future<Tuple2<void, String?>> checkLocationSafety(
      LocationData locationData) async {
    int retry = 0;

    while (retry++ < 2) {
      try {
        final checkLocationSafetyResponse = await DataRepo.instance
            .getCustomerClient()!
            .checkLocationSafety(locationData.toJsonEncodedString());

        return Tuple2(null, checkLocationSafetyResponse['responseMessage']);
      } catch (err) {
        print("Error in checkLocationSafety() in DataRepo");
        print(err);
      }
    }
    return Tuple2(null, ClientEnum.RESPONSE_CONNECTION_ERROR);
  }

  List<Question> getQuestionList() {
    return ([
      Question(
          question: "Your age?",
          fieldName: "age",
          choiceList: ["15-29", "30-40", "45+"],
          value: ""),
      Question(
          question: "Your gender?",
          fieldName: "gender",
          choiceList: ["Male", "Female", "Not to mention"],
          value: "")
    ]);
  }
}
