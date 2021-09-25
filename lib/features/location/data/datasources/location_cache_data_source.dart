import 'package:weatherple/features/location/data/models/location_data_model.dart';

abstract class LocationCacheDataSource {
  Future<LocationDataModel> getCachedLocationData();

  Future<bool> cacheLocationData(LocationDataModel locationDataModel);
}
