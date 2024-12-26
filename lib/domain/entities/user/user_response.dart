import 'user.dart';

class UserResponse {
  final User user;
  final String token;

  UserResponse({required this.user, required this.token});
}