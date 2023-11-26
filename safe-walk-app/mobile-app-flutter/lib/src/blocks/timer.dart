import 'dart:async';
import 'package:safe_walk_mobile/src/models/general/client_enum.dart';
import 'package:safe_walk_mobile/src/repo/data_repo.dart';
import 'package:safe_walk_mobile/src/repo/location_repo.dart';
import 'package:safe_walk_mobile/src/store/store.dart';
import 'package:safe_walk_mobile/src/util/util.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tuple/tuple.dart';
import 'stream.dart';

class TimerTrip {
  Timer? currentTimer;

  static TimerTrip? timerClassState;
  static TimerTrip get instance => TimerTrip.timerClassState ??= TimerTrip();
  static setNullInstance() {
    TimerTrip.timerClassState = null;
  }


  void stopTimerAndTripData() {
    currentTimer?.cancel();
    TimerTrip.setNullInstance();
  }
}
