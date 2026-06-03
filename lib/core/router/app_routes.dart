abstract final class AppRoutes {
  AppRoutes._();

  static const String home = '/';
  static const String dashboardJob = '/job/:id';
  static const String jobs = '/jobs';
  static const String jobDetails = '/jobs/:id';
}

abstract final class AppRouteNames {
  AppRouteNames._();

  static const String home = 'home';
  static const String dashboardJob = 'dashboard-job';
  static const String jobs = 'jobs';
  static const String jobDetails = 'job-details';
}
