import '../../../domain/entities/auth/register_request.dart';

class RegisterRequestModel extends RegisterRequest {
  RegisterRequestModel(
      {required super.email,
      required super.password,
      required super.firstName,
      required super.lastName});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}
