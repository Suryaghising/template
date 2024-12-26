part of 'signup_cubit.dart';

@immutable
sealed class SignupState {}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {}

class SignupFailure extends SignupState {
  final String message;

  SignupFailure({required this.message});
}
