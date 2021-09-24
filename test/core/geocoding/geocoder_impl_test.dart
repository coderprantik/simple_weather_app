import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding_platform_interface/geocoding_platform_interface.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/annotations.dart';
import 'package:weatherple/core/geocoding/geocoder.dart';

import 'geocoder_impl_test.mocks.dart';

@GenerateMocks([Geolocator, GeocodingPlatform])
void main() {
  late GeocoderImpl geoCoderImpl;
  late MockGeolocator mockGeolocator;
  late MockGeocodingPlatform mockGeocoding;

  setUp(() {
    mockGeolocator = MockGeolocator();
    mockGeocoding = MockGeocodingPlatform();
    geoCoderImpl = GeocoderImpl(
      geolocator: mockGeolocator,
      geocoding: mockGeocoding,
    );
  });
}
