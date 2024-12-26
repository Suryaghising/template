import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/utils/services/local_storage_service.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit({required this.localStorageService}) : super(SplashInitial());

  final LocalStorageService localStorageService;

  checkUserLoggedIn() async {
    emit(SplashLoading());
    await Future.delayed(const Duration(milliseconds: 200));
    final userLoggedInStatus = localStorageService.isUserLoggedIn();
    if (userLoggedInStatus) {
      emit(UserAuthenticated());
    } else {
      emit(UserUnauthenticated());
    }
  }
}
