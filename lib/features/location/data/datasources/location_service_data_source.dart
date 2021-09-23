import 'package:weatherple/features/location/domain/entities/location_data.dart';

abstract class LocationServiceDataSource {
  Future<LocationData> getCurrentLocation();
}