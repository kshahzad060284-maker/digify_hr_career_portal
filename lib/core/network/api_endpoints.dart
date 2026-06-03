abstract final class ApiEndpoints {
  ApiEndpoints._();

  static const String basePath = '/api';
  static const String version = 'v1';

  static String get baseUrlPath => '$basePath/$version';

  static String health() => '$baseUrlPath/health';
}

abstract final class RecEndpoints {
  RecEndpoints._();

  static String jobPostings() => '${ApiEndpoints.basePath}/rec/job-postings';

  static String jobPosting(String postingGuid) =>
      '${ApiEndpoints.basePath}/rec/job-postings/$postingGuid';
}

abstract final class AuthEndpoints {
  AuthEndpoints._();

  static String get login => '${ApiEndpoints.baseUrlPath}/auth/login';
  static String get logout => '${ApiEndpoints.baseUrlPath}/auth/logout';
  static String get register => '${ApiEndpoints.baseUrlPath}/auth/register';
  static String get refreshToken =>
      '${ApiEndpoints.baseUrlPath}/auth/refresh-token';
  static String get forgotPassword =>
      '${ApiEndpoints.baseUrlPath}/auth/forgot-password';
  static String get resetPassword =>
      '${ApiEndpoints.baseUrlPath}/auth/reset-password';
}
