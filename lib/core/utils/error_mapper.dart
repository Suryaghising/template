import 'package:template/core/error/failure.dart';

class ErrorMapper {

  ErrorMapper._();

  static String mapErrorToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    } else if (failure is ParsingError) {
      return failure.message;
    } else if (failure is CacheFailure) {
      return 'Cache error occurred';
    } else if (failure is NetworkFailure) {
      return 'Network error occurred';
    } else {
      return 'An unexpected error occurred';
    }
  }
}