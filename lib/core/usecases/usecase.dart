import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>?> call(Params params);
}

class Params<T> extends Equatable {
  final T data;

  const Params({required this.data});

  @override
  List<Object?> get props => [data];
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
