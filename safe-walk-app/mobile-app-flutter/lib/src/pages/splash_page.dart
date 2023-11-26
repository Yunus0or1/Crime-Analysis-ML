import 'dart:async';
import 'package:safe_walk_mobile/src/component/buttons/general_action_button.dart';
import 'package:safe_walk_mobile/src/models/general/client_enum.dart';
import 'package:safe_walk_mobile/src/models/main/AppData.dart';
import 'package:safe_walk_mobile/src/models/states/app_vary_states.dart';
import 'package:safe_walk_mobile/src/repo/data_repo.dart';
import 'package:safe_walk_mobile/src/util/util.dart';
import 'package:flutter/material.dart';
import 'package:safe_walk_mobile/src/store/store.dart';
import 'package:tuple/tuple.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController controller;
  bool noInternet = false;
  bool updateApp = false;

  @override
  void initState() {
    super.initState();
    initAppAndNavigate();
    initAnimationController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void initAnimationController() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
  }

  void refreshUI() {
    if (mounted) {
      setState(() {});
    }
  }

  Future initAppAndNavigate() async {
    final isInternet = await Util.checkInternet();
    if (isInternet) {
      var _duration = new Duration(seconds: 1);
      return new Timer(_duration, navigationPage);
    } else {
      await Future.delayed(Duration(seconds: 1));
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/noInternet', (Route<dynamic> route) => false);
    }
  }

  Future<void> navigationPage() async {
    Tuple2<void, String?> appDataResponse =
        await DataRepo.instance.getAppData();

    if (appDataResponse.item2 != ClientEnum.RESPONSE_SUCCESS) {
      noInternet = true;
      refreshUI();
      return;
    }

    AppData? newAppData = AppVariableStates.instance.appState;
    AppData? currentAppData = Store.instance?.appState?.appData;

    int newAppVersion = newAppData.appVersion;
    int currentAppVersion = currentAppData?.appVersion ?? 1;
    bool appUpdateMust = newAppData.updateMust;

    int newQuestionVersion = newAppData.questionVersion;
    int currentQuestionVersion = currentAppData!.questionVersion;

    if (newAppVersion > currentAppVersion) {
      updateApp = true;
      refreshUI();
      return;
    }

    if (newQuestionVersion > currentQuestionVersion) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/question', (Route<dynamic> route) => false);
      return;
    }

    if (Store.instance!.checkIfUserIdExists()) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/question', (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    if (noInternet) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildTitle("No internet connection or server is down."),
          SizedBox(height: 10),
          GeneralActionButton(
              title: 'Reload',
              color: Colors.indigo,
              textFontSize: 17,
              borderRadius: 20,
              isProcessing: false,
              callBackOnSubmit: () async {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/', (Route<dynamic> route) => false);
              }),
        ],
      );
    }

    if (updateApp) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildTitle("Please update the app from the Play Store"),
          SizedBox(height: 10),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        buildSpinner(),
        SizedBox(height: 20.0),
        buildLogo(),
      ],
    );
  }

  Widget buildLogo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("SafeWalk",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(
          height: 60,
          width: 100,
          child: Image.asset("assets/images/splash.png"),
        )
      ],
    );
  }

  Widget buildTitle(String title) {
    return Center(
      child: Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
          ),
        ),
      ),
    );
  }

  Widget buildSpinner() {
    return SizedBox(
        height: 5.0,
        width: 200,
        child: LinearProgressIndicator(
          value: controller.value,
          semanticsLabel: 'Linear progress indicator',
        ));
  }
}
