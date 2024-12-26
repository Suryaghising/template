import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../constants/app_strings.dart';
import '../../error/failure.dart';
import '../../network/network_info.dart';

abstract class NetworkHandler {
  Future<Either<Failure, T>> handle<T>(Future<T> Function() action);
}

class NetworkHandlerImpl implements NetworkHandler {
  final NetworkInfo networkInfo;

  NetworkHandlerImpl({required this.networkInfo});

  @override
  Future<Either<Failure, T>> handle<T>(Future<T> Function() action) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await action();
        return Right(result);
      } on DioException catch (e) {
        return Left(ServerFailure(message: e.response?.data['message']));
      } catch (e) {
        return const Left(
            ServerFailure(message: AppStrings.somethingWentWrong));
      }
    } else {
      return const Left(ServerFailure(message: 'No internet connection.'));
    }
  }
}
