import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/utils/services/network_handler.dart';
import '../../../domain/entities/auth/register_request.dart';
import '../../../domain/entities/user/user.dart';
import '../../../domain/repositories/auth/auth_repository.dart';
import '../../datasources/auth/auth_local_data_source.dart';
import '../../datasources/auth/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final NetworkHandler networkHandler;
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  AuthRepositoryImpl({required this.networkHandler,
    required this.authRemoteDataSource,
    required this.authLocalDataSource});

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    return networkHandler.handle(() async {
      final userResponse = await authRemoteDataSource.login(email, password);
      await authLocalDataSource.cacheUserLogin(userResponse);
      return userResponse.user;
    });
  }

  @override
  Future<Either<Failure, User>> signUp(RegisterRequest registerRequest) async {
    return networkHandler.handle(() async {
      final userResponse = await authRemoteDataSource.signUp(registerRequest);
      await authLocalDataSource.cacheUserLogin(userResponse);
      return userResponse.user;
    });
  }
}
