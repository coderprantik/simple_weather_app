import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weatherple/features/location/data/models/location_data_model.dart';
import 'package:weatherple/features/location/domain/entities/location_data.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tLocationDataModel = LocationDataModel(
    latitude: 1.0,
    longitude: 1.0,
    address: 'address',
  );
  test(
    'should be a subclass of LocationData class',
    () async {
      // assert
      expect(tLocationDataModel, isA<LocationData>());
    },
  );
  // Normally it doesn't work
  final jsonString = jsonEncode(
    jsonDecode(fixture('cached_location_data.json')),
  );

  group('fromJson --> fromMap', () {
    test(
      'should return valid model from JSON (String)',
      () async {
        // act
        final result = LocationDataModel.fromJson(jsonString);
        // assert
        expect(result, tLocationDataModel);
      },
    );
  });

  group('toJson --> toMap', () {
    test(
      'should return a proper JSON value',
      () async {
        // act
        final result = tLocationDataModel.toJson();
        // assert
        expect(result, jsonString);
      },
    );
  });
}
