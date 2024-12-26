import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/entities/user/user_response.dart';
import '../../constants/cache_keys.dart';

abstract class LocalStorageService {
  String? getBearerToken();

  Future<void> clearCache();

  Future<void> saveUserLogin(UserResponse userResponse);

  bool isUserLoggedIn();
}

class LocalStorageServiceImpl implements LocalStorageService {
  final SharedPreferences sharedPreferences;

  LocalStorageServiceImpl({required this.sharedPreferences});

  @override
  String? getBearerToken() =>
      sharedPreferences.getString(CacheKeys.kCacheAuthToken);

  @override
  Future<void> clearCache() async {
    await sharedPreferences.remove(CacheKeys.kCacheAuthToken);
  }

  @override
  Future<void> saveUserLogin(UserResponse userResponse) async {
    await sharedPreferences.setString(
        CacheKeys.kCacheAuthToken, userResponse.token);
    await sharedPreferences.setString(CacheKeys.kCacheUser,
        jsonEncode(userResponse.user.toUserModel().toJson()));
  }

  @override
  bool isUserLoggedIn() {
    return (sharedPreferences.getString(CacheKeys.kCacheAuthToken)) != null;
  }
}
