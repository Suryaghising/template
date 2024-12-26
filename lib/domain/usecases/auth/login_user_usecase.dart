import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/user/user.dart';
import '../../repositories/auth/auth_repository.dart';

class LoginUserUseCase extends UseCase<User, Params> {

  final AuthRepository authRepository;

  LoginUserUseCase({required this.authRepository});

  @override
  Future<Either<Failure, User>?> call(Params params) async {
    return await authRepository.login(params.data[0], params.data[1]);
  }
}