import 'package:dio/dio.dart';

import '../../../core/constants/api_urls.dart';
import '../../../domain/entities/auth/register_request.dart';
import '../../../domain/entities/user/user_response.dart';
import '../../models/user/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserResponse> login(String email, String password);

  Future<UserResponse> signUp(RegisterRequest registerRequest);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<UserResponse> login(String email, String password) async {
    final response = await dio.post(ApiUrls.kLogin, data: {
      'email': email,
      'password': password,
    });
    final data = response.data;
    final user = UserModel.fromJson(data['user']);
    final token = data['accessToken'];
    return UserResponse(user: user, token: token);
  }

  @override
  Future<UserResponse> signUp(RegisterRequest registerRequest) async {
    final response = await dio.post(ApiUrls.kRegister,
        data: registerRequest.toRegisterRequestModel().toJson());
    final data = response.data;
    final user = UserModel.fromJson(data['user']);
    final token = data['accessToken'];
    return UserResponse(user: user, token: token);
  }
}
