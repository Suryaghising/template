import '../../../domain/entities/user/user.dart';

class UserModel extends User {
  UserModel({required super.id, required super.name, required super.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final firstName = json['firstName'];
    final lastName = json['lastName'];
    final name = '$firstName $lastName';
    return UserModel(
      id: json['id'],
      name: name,
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
