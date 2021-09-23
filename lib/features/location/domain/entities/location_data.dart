import 'package:equatable/equatable.dart';

class LocationData extends Equatable {
  final double latitude;
  final double longitude;
  final String address;

  LocationData({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  @override
  List<Object?> get props => [latitude, longitude, address];
}
