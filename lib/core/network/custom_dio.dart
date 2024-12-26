import 'package:dio/dio.dart';
import 'package:requests_inspector/requests_inspector.dart';

import '../constants/api_urls.dart';
import 'dio_interceptor.dart';

class ConfiguredDio {
  late final Dio dio;
  final DioInterceptor dioInterceptor;

  ConfiguredDio({required this.dioInterceptor}) {
    dio = Dio(BaseOptions(
        baseUrl: ApiUrls.kBaseUrl,
        connectTimeout: const Duration(seconds: 10)));
    dio.interceptors.add(dioInterceptor);
    dio.interceptors.add(RequestsInspectorInterceptor());
  }
}
