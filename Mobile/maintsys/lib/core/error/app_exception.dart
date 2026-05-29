class AppException implements Exception {
  const AppException(this.message, {this.code, this.cause});

  final String message;
  final String? code;
  final Object? cause;

  @override
  String toString() {
    if (code == null) return message;
    return '$message ($code)';
  }
}

class AuthException extends AppException {
  const AuthException(super.message, {super.code, super.cause});
}

class NetworkException extends AppException {
  const NetworkException(super.message, {super.code, super.cause});
}

class SyncException extends AppException {
  const SyncException(super.message, {super.code, super.cause});
}
