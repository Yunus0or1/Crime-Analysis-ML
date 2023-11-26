import 'package:safe_walk_mobile/src/configs/server_config.dart';
import 'package:safe_walk_mobile/src/services/notification_service.dart';
import 'package:safe_walk_mobile/src/store/store.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'router.dart';
import 'package:safe_walk_mobile/src/models/states/app_vary_states.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_fonts/google_fonts.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppSate();
  }
}

class _AppSate extends State<App> {
  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>(debugLabel: "navigator");

  @override
  void initState() {
    super.initState();
    initProject();
  }

  void initProject() async {
    AppVariableStates.instance.navigatorKey = navigatorKey;
    await ServerConfig.setMainServer();
    await Store.initStore();
    await firebaseCloudMessagingListeners();
  }

  @override
  Widget build(BuildContext context) {
    // start app
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'SafeWalk',
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.black),
        brightness: Brightness.light,
        primaryColor: Colors.black,
        textTheme: GoogleFonts.latoTextTheme(),
      ),
      builder: (context, child) {
        return MediaQuery(
          child: child!,
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        );
      },
      onGenerateRoute: buildRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
