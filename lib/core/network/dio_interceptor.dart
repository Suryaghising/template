import 'package:dio/dio.dart';

import '../utils/services/local_storage_service.dart';

class DioInterceptor extends Interceptor {
  final LocalStorageService localStorageService;

  DioInterceptor({required this.localStorageService});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (localStorageService.getBearerToken() != null) {
      options.headers['Authorization'] =
          'Bearer ${localStorageService.getBearerToken()}';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      await localStorageService.clearCache();
    }
    super.onError(err, handler);
  }
}
