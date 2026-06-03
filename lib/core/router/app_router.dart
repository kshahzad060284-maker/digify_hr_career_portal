import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../extensions/app_extensions.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/dashboard/presentation/pages/dashbaord_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_job_detail_page.dart';
import '../../features/dashboard/presentation/widgets/dashboard_content.dart';
import '../../features/jobs/job_details_page.dart';
import '../../features/jobs/jobs_page.dart';
import 'app_routes.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.home,
    debugLogDiagnostics: kDebugMode,
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return DashboardWebLayout(child: child);
        },
        routes: [
          GoRoute(
            path: AppRoutes.home,
            name: AppRouteNames.home,
            builder: (context, state) => const DashboardContent(),
          ),
          GoRoute(
            path: AppRoutes.dashboardJob,
            name: AppRouteNames.dashboardJob,
            builder: (context, state) {
              final jobId = state.pathParameters['id'] ?? '';
              return DashboardJobDetailPage(jobId: jobId);
            },
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.login,
        name: AppRouteNames.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.jobs,
        name: AppRouteNames.jobs,
        builder: (context, state) => const JobsPage(),
        routes: [
          GoRoute(
            path: ':id',
            name: AppRouteNames.jobDetails,
            builder: (context, state) {
              final jobId = state.pathParameters['id'] ?? '';
              return JobDetailsPage(jobId: jobId);
            },
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) {
      return _RouterErrorPage(
        errorMessage: state.error?.toString() ?? 'Page not found',
      );
    },
  );
}

class _RouterErrorPage extends StatelessWidget {
  const _RouterErrorPage({required this.errorMessage});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Something went wrong',
              style: context.textTheme.headlineSmall,
            ),
            const Gap(8),
            Text(errorMessage),
            const Gap(16),
            FilledButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('Go home'),
            ),
          ],
        ),
      ),
    );
  }
}
