class AppException implements Exception {
  final int? type;
  final String? description;
  final dynamic underlyingError;

  AppException({this.type, this.description, this.underlyingError});

  @override
  String toString() {
    if (description != null) {
      return description!;
    }

    if (underlyingError != null) {
      return underlyingError.toString();
    }

    return "Unknown Error";
  }
}
