import 'package:weatherple/features/location/data/models/location_data_model.dart';

abstract class LocationServiceDataSource {
  Future<LocationDataModel> getCurrentLocation();
}