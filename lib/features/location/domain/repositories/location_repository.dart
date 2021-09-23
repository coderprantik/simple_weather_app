import 'package:dartz/dartz.dart';
import 'package:weatherple/core/error/failures.dart';
import 'package:weatherple/features/location/domain/entities/location_data.dart';

abstract class LocationRepository {
  Future<Either<Failure, LocationData>> getCurrentLocation();

  Future<Either<Failure, LocationData>> getCachedLocation();

  Future<Either<Failure, bool>> getHasLocationChanged();
}
