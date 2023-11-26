import 'package:safe_walk_mobile/src/configs/server_config.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class ServerConfigData {
  String updateTo = "";
  String updateMust = "";
  String versionSpecificServer = "";

  Uri mainServerAddress({String? path}) {
    // Only HTTP and HTTPS differentiate here
    switch (ServerConfig.getEnvironment()) {
      case 'dev':
        return Uri.https(ServerConfigData.instance.versionSpecificServer, path!);
      case 'prod':
        return Uri.https(
            ServerConfigData.instance.versionSpecificServer, path!);
      default:
        return Uri.https(ServerConfigData.instance.versionSpecificServer, path!);
    }
  }

  static ServerConfigData? _serverConfigState;
  static ServerConfigData get instance =>
      _serverConfigState ??= ServerConfigData();
  static setNullInstance() => _serverConfigState = null;
}
