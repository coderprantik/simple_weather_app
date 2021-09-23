import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weatherple/core/usecases/usecase.dart';
import 'package:weatherple/features/location/domain/entities/location_data.dart';
import 'package:weatherple/features/location/domain/usecases/get_cached_location.dart';

import 'location_repository.mocks.dart';

void main() {
  late MockLocationRepository mockLocationRepository;
  late GetCachedLocation getCachedLocation;

  setUp(() {
    mockLocationRepository = MockLocationRepository();

    getCachedLocation = GetCachedLocation(repository: mockLocationRepository);
  });

  final tLocationData = LocationData(
    latitude: 1.0,
    longitude: 1.0,
    address: 'address',
  );

  test(
    'should get Location Data from repository',
    () async {
      // arrange
      when(mockLocationRepository.getCachedLocation())
          .thenAnswer((_) async => Right(tLocationData));
      // act
      final result = await getCachedLocation(NoParam());
      // assert
      expect(result, Right(tLocationData));
      verify(mockLocationRepository.getCachedLocation());
      verifyNoMoreInteractions(mockLocationRepository);
    },
  );
}
