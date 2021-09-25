import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List<Object?> properties;

  Failure([this.properties = const []]);

  @override
  List<Object?> get props => properties;
}

class UnexpectedFailure extends Failure {
  final String? message;

  UnexpectedFailure(this.message) : super([message]);
}

class NoInternetFailure extends Failure {}

class SecurityFailure extends Failure {
  final String? message;

  SecurityFailure(this.message) : super([message]);
}

class CacheFailure extends Failure {}