import 'dart:convert';

import 'package:weatherple/features/location/domain/entities/location_data.dart';

class LocationDataModel extends LocationData {
  final double latitude, longitude;
  final String address;

  LocationDataModel({
    required this.latitude,
    required this.longitude,
    required this.address,
  }) : super(
          latitude: latitude,
          longitude: longitude,
          address: address,
        );

  factory LocationDataModel.fromMap(Map<String, dynamic> map) =>
      LocationDataModel(
        latitude: map['latitude'],
        longitude: map['longitude'],
        address: map['address'],
      );

  factory LocationDataModel.fromJson(String json) =>
      LocationDataModel.fromMap(jsonDecode(json));

  Map<String, dynamic> toMap() => {
        'latitude': latitude,
        'longitude': longitude,
        'address': address,
      };

  String toJson() => jsonEncode(toMap());
}
