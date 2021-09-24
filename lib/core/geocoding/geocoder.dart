import 'package:geocoding_platform_interface/geocoding_platform_interface.dart';
import 'package:geolocator_platform_interface/geolocator_platform_interface.dart';

abstract class GeoCoder {
  Future<String> getAddress(
      {required double latitude, required double longitude});

  double getDistanceBetween({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  });
}

class GeocoderImpl implements GeoCoder {
  final GeolocatorPlatform geolocator;
  final GeocodingPlatform geocoding;

  GeocoderImpl({
    required this.geolocator,
    required this.geocoding,
  });

  @override
  Future<String> getAddress({
    required double latitude,
    required double longitude,
  }) async {
    final placemarks = await geocoding.placemarkFromCoordinates(
      latitude,
      longitude,
    );

    if (placemarks.isEmpty) return '';

    final placemark = placemarks.first;

    return '${placemark.subLocality}, ${placemark.locality}';
  }

  @override
  double getDistanceBetween({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) {
    return geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
  }
}
