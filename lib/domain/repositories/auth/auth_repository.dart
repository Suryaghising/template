import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/auth/register_request.dart';
import '../../entities/user/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String email, String password);

  Future<Either<Failure, User>> signUp(RegisterRequest registerRequest);
}