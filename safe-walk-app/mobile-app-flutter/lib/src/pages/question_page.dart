import 'package:geolocator/geolocator.dart';
import 'package:safe_walk_mobile/src/blocks/stream.dart';
import 'package:safe_walk_mobile/src/component/cards/question_card.dart';
import 'package:safe_walk_mobile/src/component/general/loading_widget.dart';
import 'package:safe_walk_mobile/src/models/general/client_enum.dart';
import 'package:safe_walk_mobile/src/models/main/Question.dart';
import 'package:safe_walk_mobile/src/models/states/app_vary_states.dart';
import 'package:safe_walk_mobile/src/models/states/event.dart';
import 'package:safe_walk_mobile/src/repo/data_repo.dart';
import 'package:safe_walk_mobile/src/store/store.dart';
import 'package:safe_walk_mobile/src/util/util.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:safe_walk_mobile/src/component/buttons/general_action_button.dart';
import 'package:safe_walk_mobile/src/component/general/common_ui.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isProcessing = false;

  List<Question> questionList =
      AppVariableStates.instance.appState.questionList;

  @override
  void initState() {
    super.initState();
    eventChecker();
    checkPermission();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void eventChecker() async {
    Streamer.getEventStream().listen((data) {
      if (data.eventType == EventType.REFRESH_HOME_PAGE ||
          data.eventType == EventType.REFRESH_ALL_PAGES) {
        refreshUI();
      }
    });
  }

  Future<void> checkPermission() async {
    await Future.delayed(new Duration(milliseconds: 1000));
    LocationPermission gpsPermission = await Geolocator.requestPermission();
    bool gpsServiceEnabled = await Geolocator.isLocationServiceEnabled();
    print('GPS PERMISSION: ' + gpsPermission.toString());
  }

  void refreshUI() {
    if (mounted) {
      setState(() {
        // _scaffoldKey = new GlobalKey<ScaffoldState>();
      });
    }
  }

  void updateQuestionnaire(Question question, String singleChoice) {
    for (Question singleQuestion in questionList) {
      if (singleQuestion.fieldName == question.fieldName) {
        singleQuestion.value = singleChoice;
      }
    }
    refreshUI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 1,
          centerTitle: true,
          title: Text(
            'Questionnaire',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: buildBody());
  }

  Widget buildBody() {
    if (isProcessing) return LoadingWidget();

    List<Widget> widgetList = [];

    widgetList.addAll(questionList
        .map((singleQuestion) => QuestionCard(
              question: singleQuestion,
              updateQuestionnaire: updateQuestionnaire,
            ))
        .toList());

    widgetList.add(GeneralActionButton(
        title: 'SAVE',
        height: 40,
        textFontSize: 17,
        borderRadius: 20,
        showNextIcon: false,
        padding: EdgeInsets.fromLTRB(25, 10, 25, 20),
        isProcessing: isProcessing,
        callBackOnSubmit: () => submitData(context)));

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widgetList,
      ),
    );
  }

  void submitData(BuildContext context) async {
    for (Question question in questionList) {
      if (question.value == "") {
        Util.showSnackBar(
            context: context, message: "Please complete the questionnaire");
        return;
      }
    }

    isProcessing = true;
    refreshUI();
    Tuple2<void, String?> questionnaireDataSubmitResponse =
        await DataRepo.instance.submitQuestionData(questionList);
    isProcessing = false;
    refreshUI();

    if (questionnaireDataSubmitResponse.item2 == ClientEnum.RESPONSE_SUCCESS) {
      Util.showSnackBar(
          context: context, message: "Your data is successfully submitted");

      Store.instance!.updateAppData(AppVariableStates.instance.appState);

      Navigator.of(context)
          .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
      return;
    }

    Util.handleErrorResponse(
        errorResponseCode: questionnaireDataSubmitResponse.item2,
        context: context,
        awaitDurationMiliSecond: 200);
  }

  Future<void> refreshPage() async {
    Streamer.putEventStream(Event(EventType.REFRESH_HOME_PAGE));
    return;
  }
}
