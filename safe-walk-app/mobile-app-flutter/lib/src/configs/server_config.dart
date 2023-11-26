import 'dart:io';
import 'package:safe_walk_mobile/src/models/general/server_config_data.dart';
import 'package:flutter/foundation.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class ServerConfig {
  static String getEnvironment() {
    if (Platform.isIOS) return 'prod';
    if (kReleaseMode) {
      // is Release Mode ??
      return "prod";
    }
    return "dev";
  }

  static final String environmentMode = getEnvironment();

  static Future<void> setMainServer({String? path}) async {
    switch (getEnvironment()) {
      case 'dev':
        ServerConfigData.instance.versionSpecificServer =
            await ServerConfig.loadDevIp();
        break;
      case 'prod':
        ServerConfigData.instance.versionSpecificServer = 'yunus.ngrok.io';
        break;
    }
  }

  static Future<String> loadDevIp() async {
    // This is important to load Ip address. Only two lines are there
    String ipAddresses = await rootBundle.loadString('assets/text/dev_ip.txt');
    return ipAddresses.split('\n')[0];
  }
}
