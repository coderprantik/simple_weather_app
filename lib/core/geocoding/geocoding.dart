import 'package:geocoding/geocoding.dart' as geo;

class Geocoding {
  Future<List<geo.Placemark>> placemarkFromCoordinates(
    double latitude,
    double longitude, {
    String? localeIdentifier,
  }) async =>
      geo.placemarkFromCoordinates(
        latitude,
        longitude,
        localeIdentifier: localeIdentifier,
      );
}
