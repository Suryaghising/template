import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../../domain/usecases/auth/login_user_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.loginUserUseCase}) : super(LoginInitial());

  final LoginUserUseCase loginUserUseCase;

  login(String email, String password) async {
    emit(LoginLoading());
    final failureOrLogin =
        await loginUserUseCase(Params(data: [email, password]));
    failureOrLogin!.fold((failure) {
      emit(LoginFailure(message: (failure as ServerFailure).message));
    }, (success) {
      emit(LoginSuccess());
    });
  }
}
