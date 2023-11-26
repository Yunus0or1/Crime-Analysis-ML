import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:safe_walk_mobile/src/models/general/client_enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import 'package:package_info/package_info.dart';

class Util {
  static Future<bool> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

  static showSnackBar({required BuildContext context, required String message, int? duration}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: duration ?? 3000),
    ));
  }

  static Future<void> getPermissions() async {
    if (Platform.isAndroid) {
      await Permission.locationAlways.request();
    }
  }

  static Future<void> handleErrorResponse(
      {String? errorResponseCode,
      BuildContext? context,
      int awaitDurationMiliSecond = 0}) async {
    if (errorResponseCode == ClientEnum.RESPONSE_INVALID_JWT_TOKEN) {
      Navigator.of(context!)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
    // This Future delay is needed when we render something from FutureBuilder and let that build the UI first.
    await Future.delayed(new Duration(milliseconds: awaitDurationMiliSecond));
    if (errorResponseCode == ClientEnum.RESPONSE_EMAIL_TAKEN) {
      Util.showSnackBar(
          context: context!,
          message: "Email is already registered. Try another one");
    } else if (errorResponseCode == ClientEnum.RESPONSE_NO_AIRPORT) {
      Util.showSnackBar(
          context: context!,
          message: "No main is available to provide service");
    } else if (errorResponseCode == ClientEnum.RESPONSE_PHONE_TAKEN) {
      Util.showSnackBar(
          context: context!,
          message: "Phone Number is already registered. Try another one");
    } else if (errorResponseCode != ClientEnum.RESPONSE_SUCCESS) {
      Util.showSnackBar(
          context: context!, message: "Something went wrong. Please try again.");
    }
    return;
  }

  static String createUUID() {
    return 'USER-' + Uuid().v4().toString().replaceAll("-", "-");
  }

  static Color colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  static void printBig(dynamic text) {
    debugPrint(text.toString(), wrapWidth: 1024);
  }

  static void prettyPrintJson(String input) {
    const JsonDecoder decoder = JsonDecoder();
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    final dynamic object = decoder.convert(input);
    final dynamic prettyString = encoder.convert(object);
    prettyString.split('\n').forEach((dynamic element) => print(element));
  }


  static Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final appCurrentVersion =
        packageInfo.version + "+" + packageInfo.buildNumber;

    return appCurrentVersion;
  }

  static String getID(String bigStringId) {
    return bigStringId.split("_")[1].toUpperCase();
  }
}
