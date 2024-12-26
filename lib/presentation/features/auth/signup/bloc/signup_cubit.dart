import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../../domain/entities/auth/register_request.dart';
import '../../../../../domain/usecases/auth/register_user_usecase.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit({required this.registerUserUsecase}) : super(SignupInitial());

  final RegisterUserUsecase registerUserUsecase;

  signUp(RegisterRequest registerRequest) async {
    emit(SignupLoading());
    final result = await registerUserUsecase(Params(data: registerRequest));
    result!.fold(
        (failure) =>
            emit(SignupFailure(message: (failure as ServerFailure).message)),
        (user) => emit(SignupSuccess()));
  }
}
