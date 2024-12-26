import '../../../core/utils/services/local_storage_service.dart';
import '../../../domain/entities/user/user_response.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUserLogin(UserResponse userResponse);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final LocalStorageService localStorageService;

  AuthLocalDataSourceImpl({required this.localStorageService});

  @override
  Future<void> cacheUserLogin(UserResponse userResponse) async {
    await localStorageService.saveUserLogin(userResponse);
  }
}
