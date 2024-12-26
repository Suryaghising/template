import '../../../data/models/user/user_model.dart';

class User {
  final int id;
  final String name;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });

  UserModel toUserModel() {
    return UserModel(
      id: id,
      name: name,
      email: email,
    );
  }
}
