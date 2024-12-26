import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];

  const Failure([List properties = const <dynamic>[]]);
}

class ServerFailure extends Failure {
  final String message;

  const ServerFailure({required this.message});
}

class ParsingError extends Failure {

  final String message;

  const ParsingError({required this.message});
}

class CacheFailure extends Failure {
}

class NetworkFailure extends Failure {

}