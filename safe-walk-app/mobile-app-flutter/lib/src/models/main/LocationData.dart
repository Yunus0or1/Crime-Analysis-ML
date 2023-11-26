import 'dart:convert';


class LocationData {
  String? id;
  double? latitude;
  double? longitude;
  String? safetyInfo;
  String? note;
  LocationData({
    this.id,
    this.latitude,
    this.longitude,
    this.safetyInfo,
    this.note,
  });

  factory LocationData.fromJson(Map<String, dynamic> jsonData) {
    return LocationData(
      id: jsonData['id'],
      latitude: jsonData['latitude'],
      longitude: jsonData['longitude'],
      safetyInfo: jsonData['safetyInfo'],
      note: jsonData['note'],
    );
  }

  Map<String, dynamic> toJsonMap() {
    final data = Map<String, dynamic>();
    data['id'] = id;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['safetyInfo'] = safetyInfo;
    data['note'] = note;

    return data;
  }

  String toJsonEncodedString() {
    String data = jsonEncode(<String, dynamic>{
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'safetyInfo': safetyInfo,
      'note': note
    });

    return data;
  }
}
