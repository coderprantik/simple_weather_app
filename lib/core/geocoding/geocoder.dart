import 'package:geocoding_platform_interface/geocoding_platform_interface.dart';
import 'package:geolocator/geolocator.dart';

abstract class GeoCoder {
  Future<String> getAddress();

  Future<int> getDistanceBetween({
    required double firstPlace,
    required double secondPlace,
  });
}

class GeocoderImpl implements GeoCoder {
  final Geolocator geolocator;
  final GeocodingPlatform geocoding;

  GeocoderImpl({
    required this.geolocator,
    required this.geocoding,
  });

  @override
  Future<String> getAddress() {
    // TODO: implement getAddress
    throw UnimplementedError();
  }

  @override
  Future<int> getDistanceBetween(
      {required double firstPlace, required double secondPlace}) {
    // TODO: implement getDistanceBetween
    throw UnimplementedError();
  }
}
