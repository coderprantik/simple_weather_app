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
}
