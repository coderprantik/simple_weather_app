import 'dart:io';

import 'package:flutter/services.dart';
import 'package:geolocator_platform_interface/geolocator_platform_interface.dart';
import 'package:weatherple/core/error/exceptions.dart';
import 'package:weatherple/core/geocoding/geocoder.dart';
import 'package:weatherple/core/values/message.dart';
import 'package:weatherple/features/location/data/datasources/location_cache_data_source.dart';
import 'package:weatherple/features/location/data/datasources/location_service_data_source.dart';
import 'package:weatherple/features/location/domain/entities/location_data.dart';
import 'package:weatherple/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:weatherple/features/location/domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationServiceDataSource serviceDataSource;
  final LocationCacheDataSource cacheDataSource;
  final Geocoder geocoder;

  LocationRepositoryImpl({
    required this.serviceDataSource,
    required this.cacheDataSource,
    required this.geocoder,
  });

  @override
  Future<Either<Failure, LocationData>> getCurrentLocation(
      [bool cache = true]) async {
    try {
      final locationDataModel = await serviceDataSource.getCurrentLocation();
      if (cache) cacheDataSource.cacheLocationData(locationDataModel);
      return Right(locationDataModel);
    } on PermissionDeniedException catch (e) {
      return Left(SecurityFailure(e.message));
    } on ServiceDisabledException {
      return Left(SecurityFailure(MESSAGE.LOCATION_SERVICE_DISABLED));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LocationData>> getCachedLocation() async {
    try {
      return Right(await cacheDataSource.getCachedLocationData());
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> getHasLocationChanged() async {
    late Failure _failure;
    late LocationData currentLocationData, cacheLocationData;

    /// currentLocationData
    var locationData = await getCurrentLocation(false);

    locationData.fold(
      (failure) => _failure = failure,
      (locationData) => currentLocationData = locationData,
    );

    if (locationData.isLeft()) return Left(_failure);

    /// cacheLocationData
    locationData = await getCachedLocation();

    locationData.fold(
      (failure) => _failure = failure,
      (locationData) => cacheLocationData = locationData,
    );

    if (locationData.isLeft()) return Left(_failure);

    try {
      final distance = geocoder.getDistanceBetween(
        startLatitude: currentLocationData.latitude,
        startLongitude: currentLocationData.longitude,
        endLatitude: cacheLocationData.latitude,
        endLongitude: cacheLocationData.longitude,
      );
      return Right(distance > 20000);
    } on SocketException {
      return Left(NoInternetFailure());
    } on PlatformException catch (e) {
      return Left(UnexpectedFailure('${e.message}, ${e.code}\n${e.details}'));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
