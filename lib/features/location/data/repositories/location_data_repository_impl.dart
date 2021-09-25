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
  Future<Either<Failure, LocationData>> getCurrentLocation() async {
    try {
      final locationDataModel = await serviceDataSource.getCurrentLocation();
      cacheDataSource.cacheLocationData(locationDataModel);
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
  Future<Either<Failure, bool>> getHasLocationChanged() {
    // TODO: implement getHasLocationChanged
    throw UnimplementedError();
  }
}
