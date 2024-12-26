part of 'password_visibility_cubit.dart';

class PasswordVisibilityState {
  final bool isVisible;

  PasswordVisibilityState({required this.isVisible});

  PasswordVisibilityState copyWith({
    bool? isVisible,
  }) {
    return PasswordVisibilityState(
      isVisible: isVisible ?? this.isVisible,
    );
  }
}
