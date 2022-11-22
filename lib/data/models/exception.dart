enum AppExceptionType {
  general,
}

class AppException implements Exception {
  AppExceptionType type;

  AppException({this.type = AppExceptionType.general});

  @override
  String toString() {
    switch (type) {
      case AppExceptionType.general:
        return "General exception";
      default:
        return "Unknown exception";
    }
  }
}
