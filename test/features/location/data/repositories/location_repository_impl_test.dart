import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:weatherple/core/geocoding/geocoder.dart';
import 'package:weatherple/features/location/data/datasources/location_cache_data_source.dart';
import 'package:weatherple/features/location/data/datasources/location_service_data_source.dart';
import 'package:weatherple/features/location/data/repositories/location_data_repository_impl.dart';

import 'location_repository_impl_test.mocks.dart';

@GenerateMocks([LocationServiceDataSource, LocationCacheDataSource, Geocoder])
void main() {
  late LocationRepositoryImpl locationRepositoryImpl;
  late MockLocationServiceDataSource mockServiceDataSource;
  late MockLocationCacheDataSource mockCacheDataSource;
  late MockGeocoder mockGeocoder;

  setUp(() {
    mockServiceDataSource = MockLocationServiceDataSource();
    mockCacheDataSource = MockLocationCacheDataSource();
    mockGeocoder = MockGeocoder();

    locationRepositoryImpl = LocationRepositoryImpl(
      serviceDataSource: mockServiceDataSource,
      cacheDataSource: mockCacheDataSource,
      geocoder: mockGeocoder,
    );
  });
}
