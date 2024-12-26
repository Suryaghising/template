part of 'splash_cubit.dart';

@immutable
sealed class SplashState {}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class UserAuthenticated extends SplashState {}

class UserUnauthenticated extends SplashState {}
