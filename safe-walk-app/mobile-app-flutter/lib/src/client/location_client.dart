import 'dart:async';
import 'package:safe_walk_mobile/src/models/location/gps_location.dart';
import 'package:safe_walk_mobile/src/models/states/app_vary_states.dart';
import 'package:safe_walk_mobile/src/util/util.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io' show Platform;

class LocationClient {
  static GPSLocation? pickedLocation;

  Future<GPSLocation> fetchCurrentLocation() async {
    bool gpsServiceEnabled = await Geolocator.isLocationServiceEnabled();
    GPSLocation gpsLocation = new GPSLocation();

    if (gpsServiceEnabled) {
      try {
        Position position = await Geolocator.getCurrentPosition();
        gpsLocation.latitude = position.latitude;
        gpsLocation.longitude = position.longitude;
      } catch (error) {
        print("ERROR IN fetchCurrentLocation in LocationClient");
        print(error);
      }

      return gpsLocation;
    } else if (!gpsServiceEnabled &&
        !AppVariableStates.instance.askGPSLocation) {
      try {
        print('Asking for GPS Location Dialog Box');
        await Geolocator.getCurrentPosition();
      } catch (error) {
        print(error);
      }
      AppVariableStates.instance.askGPSLocation = true;
      Future.delayed(const Duration(seconds: 20), () {
        AppVariableStates.instance.askGPSLocation = false;
      });
    }

    return gpsLocation;
  }

  // ----------------------------------------------------------------------- //
  static LocationClient? _instance;
  static LocationClient get instance => _instance ??= LocationClient();
  // ----------------------------------------------------------------------- //
}
