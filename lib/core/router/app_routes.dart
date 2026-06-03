abstract final class AppRoutes {
  AppRoutes._();

  static const String home = '/';
  static const String authLogin = '/auth/login';
  static const String authSignUp = '/auth/signup';
  static const String dashboardJob = '/job/:id';
  static const String jobs = '/jobs';
  static const String jobDetails = '/jobs/:id';

  /// Legacy paths — prefer [authLogin] / [authSignUp].
  static const String login = '/login';
  static const String register = '/register';
  static const String signUp = '/signup';
}

abstract final class AppRouteNames {
  AppRouteNames._();

  static const String home = 'home';
  static const String authLogin = 'auth-login';
  static const String authSignUp = 'auth-signup';
  static const String dashboardJob = 'dashboard-job';
  static const String jobs = 'jobs';
  static const String jobDetails = 'job-details';

  /// Legacy route names.
  static const String login = 'login';
  static const String register = 'register';
  static const String signUp = 'sign-up';
}
