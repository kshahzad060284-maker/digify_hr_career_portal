abstract final class AppRoutes {
  AppRoutes._();

  static const String home = '/';
  static const String authLogin = '/auth/login';
  static const String authSignUp = '/auth/signup';
  static const String jobDetail = '/job';
  static const String candidateOffers = '/offers';
  static const String jobs = '/jobs';
  static const String jobDetails = '/jobs/:id';

  static const String login = '/login';
  static const String register = '/register';
  static const String signUp = '/signup';
}

abstract final class AppRouteNames {
  AppRouteNames._();

  static const String home = 'home';
  static const String authLogin = 'auth-login';
  static const String authSignUp = 'auth-signup';
  static const String jobDetail = 'job-detail';
  static const String candidateOffers = 'candidate-offers';
  static const String jobs = 'jobs';
  static const String jobDetails = 'job-details';

  static const String login = 'login';
  static const String register = 'register';
  static const String signUp = 'sign-up';
}
