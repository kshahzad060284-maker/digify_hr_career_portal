class AppException implements Exception {
  AppException({
    required this.message,
    this.statusCode,
    this.endpoint,
    this.details,
  });

  final String message;
  final int? statusCode;
  final String? endpoint;
  final Object? details;

  @override
  String toString() {
    final buffer = StringBuffer('AppException(message: $message');

    if (statusCode != null) {
      buffer.write(', statusCode: $statusCode');
    }

    if (endpoint != null) {
      buffer.write(', endpoint: $endpoint');
    }

    if (details != null) {
      buffer.write(', details: $details');
    }

    buffer.write(')');
    return buffer.toString();
  }
}
