class GPSLocation {
  double? latitude;
  double? longitude;

  GPSLocation({
    this.latitude,
    this.longitude,
  });

  factory GPSLocation.fromJson(Map<String, dynamic> jsonData) {
    return GPSLocation(
      latitude: jsonData['latitude'],
      longitude: jsonData['longitude'],
    );
  }

  Map<String, dynamic> toJsonMap() {
    final data = Map<String, dynamic>();
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
