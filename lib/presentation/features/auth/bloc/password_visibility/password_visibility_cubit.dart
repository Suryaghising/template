import 'package:bloc/bloc.dart';

part 'password_visibility_state.dart';

class PasswordVisibilityCubit extends Cubit<PasswordVisibilityState> {
  PasswordVisibilityCubit() : super(PasswordVisibilityState(isVisible: false));

  void toggleVisibility() {
    emit(state.copyWith(isVisible: !state.isVisible));
  }
}
