import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weatherple/core/usecases/usecase.dart';
import 'package:weatherple/features/location/domain/entities/location_data.dart';
import 'package:weatherple/features/location/domain/repositories/location_repository.dart';
import 'package:weatherple/features/location/usecases/get_current_location.dart';

import 'location_repository.mocks.dart';


@GenerateMocks([LocationRepository])
void main() {
  late MockLocationRepository mockLocationRepository;
  late GetCurrentLocation getCurrentLocation;

  setUp(() {
    mockLocationRepository = MockLocationRepository();

    getCurrentLocation = GetCurrentLocation(repository: mockLocationRepository);
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
      when(mockLocationRepository.getCurrentLocation())
          .thenAnswer((_) async => Right(tLocationData));
      // act
      final result = await getCurrentLocation(NoParam());
      // assert
      expect(result, Right(tLocationData));
      verify(mockLocationRepository.getCurrentLocation());
      verifyNoMoreInteractions(mockLocationRepository);
    },
  );
}
