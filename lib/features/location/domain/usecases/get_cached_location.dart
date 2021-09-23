import 'package:weatherple/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:weatherple/core/usecases/usecase.dart';
import 'package:weatherple/features/location/domain/entities/location_data.dart';
import 'package:weatherple/features/location/domain/repositories/location_repository.dart';

class GetCachedLocation implements Usecase<LocationData, NoParam> {
  final LocationRepository repository;

  GetCachedLocation({required this.repository});

  @override
  Future<Either<Failure, LocationData>> call(NoParam param) {
    return repository.getCachedLocation();
  }
}
