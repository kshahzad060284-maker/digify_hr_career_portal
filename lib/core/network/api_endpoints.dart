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

  static String applyJobPosting(String postingGuid) =>
      '${ApiEndpoints.basePath}/rec/job-postings/$postingGuid/apply';

  static String acceptJobOffer(String offerGuid) =>
      '${ApiEndpoints.basePath}/rec/job-offers/$offerGuid/accept';

  static String declineJobOffer(String offerGuid) =>
      '${ApiEndpoints.basePath}/rec/job-offers/$offerGuid/decline';
}

abstract final class CandidateAuthEndpoints {
  CandidateAuthEndpoints._();

  static String login() => '${ApiEndpoints.basePath}/candidate/login';

  static String register() => '${ApiEndpoints.basePath}/candidate/register';
}

abstract final class CandidateEndpoints {
  CandidateEndpoints._();

  static String offers() => '${ApiEndpoints.basePath}/candidate/offers';
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
