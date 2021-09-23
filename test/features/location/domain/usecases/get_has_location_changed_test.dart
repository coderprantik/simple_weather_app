import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weatherple/core/usecases/usecase.dart';
import 'package:weatherple/features/location/usecases/get_has_location_changed.dart';

import 'location_repository.mocks.dart';

void main() {
  late MockLocationRepository mockLocationRepository;
  late GetHasLocationChanged getHasLocationChanged;

  setUp(() {
    mockLocationRepository = MockLocationRepository();

    getHasLocationChanged = GetHasLocationChanged(
      repository: mockLocationRepository,
    );
  });

  test(
    'should call repository',
    () async {
      // arrange
      when(mockLocationRepository.getHasLocationChanged())
          .thenAnswer((_) async => Right(true));
      // act
      final result = await getHasLocationChanged(NoParam());
      // assert
      expect(result, Right(true));
      verify(mockLocationRepository.getHasLocationChanged());
      verifyNoMoreInteractions(mockLocationRepository);
    },
  );
}
