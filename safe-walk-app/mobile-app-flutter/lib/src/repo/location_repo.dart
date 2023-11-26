import 'package:safe_walk_mobile/src/client/location_client.dart';
import 'package:safe_walk_mobile/src/models/general/client_enum.dart';
import 'package:tuple/tuple.dart';
import 'dart:convert' show jsonDecode;
import 'package:http/http.dart' as http;
import '../models/location/gps_location.dart';

class LocationRepo {
  static final LocationRepo _instance = LocationRepo();
  LocationClient? _locationClient;

  LocationClient? getLocationClient() {
    _locationClient = new LocationClient();
    return _locationClient;
  }

  static LocationRepo get instance => _instance;

  Future<GPSLocation> fetchCurrentLocation() async {
    try {
      return LocationRepo.instance.getLocationClient()!.fetchCurrentLocation();
    } catch (error) {
      print("Error in fetchCurrentLocation() in LocationRepo");
      print(error);
      return GPSLocation(latitude: null, longitude: null);
    }
  }
}
