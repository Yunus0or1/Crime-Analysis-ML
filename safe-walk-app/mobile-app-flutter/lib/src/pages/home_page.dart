import 'dart:ffi';

import 'package:geolocator/geolocator.dart';
import 'package:safe_walk_mobile/src/blocks/stream.dart';
import 'package:safe_walk_mobile/src/cache/cache_response.dart';
import 'package:safe_walk_mobile/src/client/location_client.dart';
import 'package:safe_walk_mobile/src/component/buttons/round_button.dart';
import 'package:safe_walk_mobile/src/component/cards/information_card.dart';
import 'package:safe_walk_mobile/src/component/general/drawerUI.dart';
import 'package:safe_walk_mobile/src/component/general/loading_widget.dart';
import 'package:safe_walk_mobile/src/models/general/app_enum.dart';
import 'package:safe_walk_mobile/src/models/general/client_enum.dart';
import 'package:safe_walk_mobile/src/models/general/intro_data.dart';
import 'package:safe_walk_mobile/src/models/location/gps_location.dart';
import 'package:safe_walk_mobile/src/models/main/LocationData.dart';
import 'package:safe_walk_mobile/src/models/states/event.dart';
import 'package:safe_walk_mobile/src/repo/data_repo.dart';
import 'package:safe_walk_mobile/src/store/store.dart';
import 'package:safe_walk_mobile/src/util/util.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:safe_walk_mobile/src/component/buttons/general_action_button.dart';
import 'package:safe_walk_mobile/src/component/general/common_ui.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isProcessing = false;
  bool locationPermissionEnabled = true;
  LocationData locationData = new LocationData(latitude: 0.0, longitude: 0.0);

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
    LocationPermission gpsPermission = await Geolocator.requestPermission();
    bool gpsServiceEnabled = await Geolocator.isLocationServiceEnabled();
    print('GPS PERMISSION: ' + gpsPermission.toString());

    switch (gpsPermission) {
      case LocationPermission.always:
        fetchLocation();
        break;

      case LocationPermission.whileInUse:
        fetchLocation();
        break;

      default:
        locationPermissionEnabled = false;
        refreshUI();
        break;
    }
  }

  void fetchLocation() async {
    GPSLocation gpsLocation =
        await LocationClient.instance.fetchCurrentLocation();
    locationData.latitude = gpsLocation.latitude;
    locationData.longitude = gpsLocation.longitude;
    locationPermissionEnabled = true;

    refreshUI();
  }

  void refreshUI() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 1,
          centerTitle: true,
          title: Text(
            'HOME',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: buildBody(),
          ),
        ));
  }

  Widget buildBody() {
    if (isProcessing) return LoadingWidget();

    if(!locationPermissionEnabled) return buildLocationPermission();

    List<Widget> children = [];

    children.add(Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(20),
      width: double.infinity,
      child: CustomText(
          'You can tap on any button to let us know your situation.',
          fontSize: 18),
    ));

    if (locationData.longitude != 0.0) {
      children.add(Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(15),
        width: double.infinity,
        child: CustomText(
            'Lat: ${locationData.latitude!.toStringAsFixed(2)}, Ln: ${locationData.longitude!.toStringAsFixed(2)}',
            fontSize: 18),
      ));
    }

    children.add(Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: buildButtonChild(),
    ));

    children.add(Padding(
      padding: EdgeInsets.only(left: 50, top: 20),
      child: Divider(
        color: Colors.grey,
        thickness: 2,
      ),
    ));

    children.add(buildCheckSafetySection());

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }

  Widget buildLocationPermission(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          width: double.infinity,
          child: CustomText('Please enable location from the settings and then refresh.',
              fontSize: 18),
        ),
        GeneralActionButton(
            title: 'Refresh',
            color: Colors.indigo,
            textFontSize: 17,
            borderRadius: 20,
            isProcessing: isProcessing,
            callBackOnSubmit: ()  async {
              isProcessing = true;
              refreshUI();
              await checkPermission();
              isProcessing = false;
              refreshUI();
            }),
      ],
    );
  }

  List<Widget> buildButtonChild() {
    return [
      Expanded(
        child: RoundActionButton(
            title: 'Safe',
            color: Colors.blue,
            textFontSize: 17,
            isProcessing: isProcessing,
            callBackOnSubmit: () => submitLocationData(context, 'Safe')),
      ),
      Expanded(
        child: RoundActionButton(
            title: 'Unsafe',
            color: Colors.red,
            textFontSize: 17,
            isProcessing: isProcessing,
            callBackOnSubmit: () => submitLocationData(context, 'Unsafe')),
      ),
      Expanded(
        child: RoundActionButton(
            title: 'Neutral',
            textFontSize: 17,
            isProcessing: isProcessing,
            callBackOnSubmit: () => submitLocationData(context, 'Neutral')),
      )
    ];
  }

  Widget buildCheckSafetySection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          width: double.infinity,
          child: CustomText('You can also check for the safety of this place.',
              fontSize: 18),
        ),
        GeneralActionButton(
            title: 'Check',
            color: Colors.indigo,
            textFontSize: 17,
            borderRadius: 20,
            isProcessing: isProcessing,
            callBackOnSubmit: () => checkLocationSafety(context)),
      ],
    );
  }

  void checkLocationSafety(BuildContext context) async {
    if (locationData.longitude == 0.0) {
      Util.showSnackBar(
          context: context, message: "Please enable the GPS Location");
      fetchLocation();
      return;
    }
    isProcessing = true;
    refreshUI();

    locationData.id = "";
    locationData.note = "";
    locationData.safetyInfo = "";
    Tuple2<void, String?> checkLocationSafetyTResponse =
        await DataRepo.instance.checkLocationSafety(locationData);

    isProcessing = false;
    refreshUI();

    Util.showSnackBar(
        context: context, message: checkLocationSafetyTResponse.item2 ?? "");
  }

  void submitLocationData(BuildContext context, String safetyInfo) async {
    if (locationData.longitude == 0.0) {
      Util.showSnackBar(
          context: context, message: "Please enable the GPS Location");
      return;
    }
    isProcessing = true;
    refreshUI();

    locationData.id = Store.instance!.appState!.userId;
    locationData.note = "";
    locationData.safetyInfo = safetyInfo;
    Tuple2<void, String?> roadDataSubmitResponse =
        await DataRepo.instance.submitLocationData(locationData);

    isProcessing = false;
    refreshUI();

    if (roadDataSubmitResponse.item2 == ClientEnum.RESPONSE_SUCCESS) {
      Util.showSnackBar(
          context: context, message: "Your data is successfully submitted");

      refreshUI();
      return;
    }

    Util.handleErrorResponse(
        errorResponseCode: roadDataSubmitResponse.item2,
        context: context,
        awaitDurationMiliSecond: 200);
  }

  Future<void> refreshPage() async {
    Streamer.putEventStream(Event(EventType.REFRESH_HOME_PAGE));
    return;
  }
}
