import 'package:weatherple/core/geocoding/geocoder.dart';
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
  Future<Either<Failure, LocationData>> getCachedLocation() {
    // TODO: implement getCachedLocation
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, LocationData>> getCurrentLocation() {
    // TODO: implement getCurrentLocation
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> getHasLocationChanged() {
    // TODO: implement getHasLocationChanged
    throw UnimplementedError();
  }
}
