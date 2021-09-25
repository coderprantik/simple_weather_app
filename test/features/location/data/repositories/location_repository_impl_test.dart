import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator_platform_interface/geolocator_platform_interface.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weatherple/core/error/exceptions.dart';
import 'package:weatherple/core/error/failures.dart';
import 'package:weatherple/core/geocoding/geocoder.dart';
import 'package:weatherple/core/values/message.dart';
import 'package:weatherple/features/location/data/datasources/location_cache_data_source.dart';
import 'package:weatherple/features/location/data/datasources/location_service_data_source.dart';
import 'package:weatherple/features/location/data/models/location_data_model.dart';
import 'package:weatherple/features/location/data/repositories/location_data_repository_impl.dart';

import 'location_repository_impl_test.mocks.dart';

@GenerateMocks([LocationServiceDataSource, LocationCacheDataSource, Geocoder])
void main() {
  late LocationRepositoryImpl locationRepositoryImpl;
  late MockLocationServiceDataSource mockServiceDataSource;
  late MockLocationCacheDataSource mockCacheDataSource;
  late MockGeocoder mockGeocoder;

  setUp(() {
    mockServiceDataSource = MockLocationServiceDataSource();
    mockCacheDataSource = MockLocationCacheDataSource();
    mockGeocoder = MockGeocoder();

    locationRepositoryImpl = LocationRepositoryImpl(
      serviceDataSource: mockServiceDataSource,
      cacheDataSource: mockCacheDataSource,
      geocoder: mockGeocoder,
    );
  });

  final tLocationDataModel = LocationDataModel(
    latitude: 1.0,
    longitude: 1.0,
    address: 'address',
  );

  group('getCurrentLocation', () {
    test(
      'should get LocationDataModel and then cache it',
      () async {
        // arrange
        when(mockServiceDataSource.getCurrentLocation())
            .thenAnswer((_) async => tLocationDataModel);
        when(mockCacheDataSource.cacheLocationData(any))
            .thenAnswer((_) async => true);
        // act
        final result = await locationRepositoryImpl.getCurrentLocation();
        // assert
        verify(mockServiceDataSource.getCurrentLocation());
        expect(result, Right(tLocationDataModel));
        verifyNoMoreInteractions(mockServiceDataSource);

        verify(mockCacheDataSource.cacheLocationData(tLocationDataModel));
        verifyNoMoreInteractions(mockCacheDataSource);
      },
    );

    test(
      'should return SecurityFailure when location permission is denied',
      () async {
        // arrange
        when(mockServiceDataSource.getCurrentLocation())
            .thenThrow(PermissionDeniedException(''));
        // act
        final result = await locationRepositoryImpl.getCurrentLocation();
        // assert
        expect(result, Left(SecurityFailure('')));
        verifyNoMoreInteractions(mockCacheDataSource);
      },
    );

    test(
      '''should return SecurityFailure with proper message
       when location service is disabled''',
      () async {
        // arrange
        when(mockServiceDataSource.getCurrentLocation())
            .thenThrow(ServiceDisabledException());
        // act
        final result = await locationRepositoryImpl.getCurrentLocation();
        // assert
        expect(
          result,
          Left(SecurityFailure(MESSAGE.LOCATION_SERVICE_DISABLED)),
        );
        verifyNoMoreInteractions(mockCacheDataSource);
      },
    );

    test(
      'should return UnknownFailure if it throws an unexpected or unknown exception',
      () async {
        // arrange
        when(mockServiceDataSource.getCurrentLocation())
            .thenThrow(SocketException(''));
        // act
        final result = await locationRepositoryImpl.getCurrentLocation();
        // assert
        expect(result, Left(UnexpectedFailure(SocketException('').toString())));
        verifyNoMoreInteractions(mockCacheDataSource);
      },
    );
  });

  group('getCachedLocation', () {
    test(
      'should get LocationDataModel when there is a cache',
      () async {
        // arrange
        when(mockCacheDataSource.getCachedLocationData())
            .thenAnswer((_) async => tLocationDataModel);
        // act
        final result = await locationRepositoryImpl.getCachedLocation();
        // assert
        expect(result, Right(tLocationDataModel));
      },
    );
    test(
      'should return CacheFailure when there is no cache',
      () async {
        // arrange
        when(mockCacheDataSource.getCachedLocationData())
            .thenThrow(CacheException());
        // act
        final result = await locationRepositoryImpl.getCachedLocation();
        // assert
        expect(result, Left(CacheFailure()));
      },
    );
  });
}
