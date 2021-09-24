import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding_platform_interface/geocoding_platform_interface.dart';
import 'package:geolocator_platform_interface/geolocator_platform_interface.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weatherple/core/geocoding/geocoder.dart';

import 'geocoder_impl_test.mocks.dart';

@GenerateMocks([GeolocatorPlatform, GeocodingPlatform])
void main() {
  late GeocoderImpl geocoderImpl;
  late MockGeolocatorPlatform mockGeolocator;
  late MockGeocodingPlatform mockGeocoding;

  setUp(() {
    mockGeolocator = MockGeolocatorPlatform();
    mockGeocoding = MockGeocodingPlatform();
    geocoderImpl = GeocoderImpl(
      geolocator: mockGeolocator,
      geocoding: mockGeocoding,
    );
  });

  final tLatitude = 1.0, tLongitude = 1.0;

  group('getAddress', () {
    test(
      'should forward the call to GeocodingPlatform.placemarkFromCoordinates',
      () async {
        // arrange
        when(mockGeocoding.placemarkFromCoordinates(any, any))
            .thenAnswer((_) async => [Placemark()]);
        // act
        final result = await geocoderImpl.getAddress(
          latitude: tLatitude,
          longitude: tLongitude,
        );
        // assert
        verify(mockGeocoding.placemarkFromCoordinates(tLatitude, tLongitude));
        expect(result, 'null, null');
      },
    );
  });

  group('getDistanceBetween', () {
    test(
      'should forward the call to GeolocatorPlatform.getDistanceBetween',
      () async {
        // arrange
        when(mockGeolocator.distanceBetween(
          tLatitude,
          tLongitude,
          tLatitude,
          tLongitude,
        )).thenReturn(1.0);
        // act
        final result = geocoderImpl.getDistanceBetween(
          startLatitude: tLongitude,
          startLongitude: tLongitude,
          endLatitude: tLatitude,
          endLongitude: tLongitude,
        );
        // assert
        verify(mockGeolocator.distanceBetween(
          tLatitude,
          tLongitude,
          tLatitude,
          tLongitude,
        ));
        expect(result, 1.0);
      },
    );
  });
}
