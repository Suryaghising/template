import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/custom_dio.dart';
import 'core/network/dio_interceptor.dart';
import 'core/network/network_info.dart';
import 'core/routes/app_router.dart';
import 'core/utils/services/form_validation_service.dart';
import 'core/utils/services/local_storage_service.dart';
import 'core/utils/services/network_handler.dart';
import 'data/datasources/auth/auth_local_data_source.dart';
import 'data/datasources/auth/auth_remote_data_source.dart';
import 'data/repositories/auth/auth_repository_impl.dart';
import 'domain/repositories/auth/auth_repository.dart';
import 'domain/usecases/auth/login_user_usecase.dart';
import 'domain/usecases/auth/register_user_usecase.dart';
import 'presentation/features/auth/bloc/password_visibility/password_visibility_cubit.dart';
import 'presentation/features/auth/login/bloc/login_cubit.dart';
import 'presentation/features/auth/signup/bloc/signup_cubit.dart';
import 'presentation/features/dashboard/bloc/nav_bar_cubit.dart';
import 'presentation/features/splash/bloc/splash_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => AppRouter());

  // services
  sl.registerLazySingleton<LocalStorageService>(
      () => LocalStorageServiceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<FormValidationService>(
      () => FormValidationServiceImpl());
  sl.registerLazySingleton<NetworkHandler>(
      () => NetworkHandlerImpl(networkInfo: sl()));

  // external
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));

  // dio service
  sl.registerSingleton<DioInterceptor>(
      DioInterceptor(localStorageService: sl()));

  final dio = ConfiguredDio(dioInterceptor: sl<DioInterceptor>()).dio;
  sl.registerSingleton<Dio>(dio);

  // bloc
  sl.registerFactory(() => LoginCubit(loginUserUseCase: sl()));
  sl.registerFactory(() => SignupCubit(registerUserUsecase: sl()));
  sl.registerFactory(() => PasswordVisibilityCubit());
  sl.registerFactory(() => NavBarCubit());
  sl.registerFactory(() => SplashCubit(localStorageService: sl()));

  // use case
  sl.registerLazySingleton(() => LoginUserUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => RegisterUserUsecase(authRepository: sl()));

  // repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
      authLocalDataSource: sl(),
      authRemoteDataSource: sl(),
      networkHandler: sl()));

  // data source
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(dio: sl()));
  sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(localStorageService: sl()));
}
