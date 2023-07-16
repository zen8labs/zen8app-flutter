import 'package:dio/dio.dart';
import 'package:zen8app/utils/utils.dart';

//Do not modify
extension StreamAppExceptionConverting<T> on Stream<T> {
  Stream<AppException> asAppException() {
    return map((e) => e.ex.asAppException());
  }
}

//Configurable
class DatePattern {
  DatePattern._();

  static const yyMMyyyyHHmm = "dd/MM/yyyy";
  static const mmmddHHmm = "MMM dd, HH:mm";
}

//Local store keys
class LocalStoreKey {
  LocalStoreKey._();

  static const credential = "credential";
  static const user = "user";
}

class AppEvent {
  static const forceLogout = "logout";
}

//App Error
enum AppExceptionType { other }

extension _AppExceptionConverting on Extendable {
  AppException asAppException() {
    if (base is AppException) {
      return base as AppException;
    }
    try {
      String? description =
          (base as DioException).response?.data["message"] as String?;
      return AppException(description: description, underlyingError: base);
    } catch (_) {
      return AppException(underlyingError: base);
    }
  }
}
