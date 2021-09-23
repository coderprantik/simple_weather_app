import 'package:flutter_test/flutter_test.dart';
import 'package:weatherple/core/geocoding/geocoder.dart';

import 'geocoder_impl_test.mocks.dart';

// @GenerateMocks([Geolocator, Geocoding])
void main() {
  late GeocoderImpl geoCoderImpl;
  late MockGeolocator mockGeolocator;
  late MockGeocoding mockGeocoding;

  setUp(() {
    mockGeolocator = MockGeolocator();
    mockGeocoding = MockGeocoding();
    geoCoderImpl = GeocoderImpl(
      geolocator: mockGeolocator,
      geocoding: mockGeocoding,
    );
  });
}
