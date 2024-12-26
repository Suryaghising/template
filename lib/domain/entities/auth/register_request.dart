import '../../../data/models/auth/register_request_model.dart';

class RegisterRequest {
  final String email;
  final String password;
  final String firstName;
  final String lastName;

  RegisterRequest({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });

  RegisterRequestModel toRegisterRequestModel() {
    return RegisterRequestModel(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
    );
  }
}
