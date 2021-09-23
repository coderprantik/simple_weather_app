import 'package:weatherple/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:weatherple/core/usecases/usecase.dart';
import 'package:weatherple/features/location/domain/repositories/location_repository.dart';

class GetHasLocationChanged implements Usecase<bool, NoParam> {
  final LocationRepository repository;

  GetHasLocationChanged({required this.repository});

  @override
  Future<Either<Failure, bool>> call(NoParam param) {
    return repository.getHasLocationChanged();
  }
}
