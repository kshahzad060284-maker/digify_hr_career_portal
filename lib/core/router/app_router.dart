import 'package:career_portal/core/deep_link/deep_link.dart';
import 'package:career_portal/core/enterprise/enterprise_session.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../extensions/app_extensions.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/signup_page.dart';
import '../../features/dashboard/presentation/pages/dashbaord_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_job_detail_page.dart';
import '../../features/dashboard/presentation/widgets/dashboard_content.dart';
import '../../features/jobs/job_details_page.dart';
import '../../features/jobs/jobs_page.dart';
import '../../features/offers/presentation/pages/candidate_offers_page.dart';
import 'app_routes.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.home,
    debugLogDiagnostics: kDebugMode,
    redirect: (context, state) => EnterpriseSession.syncFromUri(state.uri),
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return DashboardWebLayout(
            showOffersNavButton:
                state.matchedLocation != AppRoutes.candidateOffers,
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: AppRoutes.home,
            name: AppRouteNames.home,
            builder: (context, state) => const DashboardContent(),
          ),
          GoRoute(
            path: AppRoutes.jobDetail,
            name: AppRouteNames.jobDetail,
            redirect: (context, state) {
              if (DeepLink.jobIdOf(state.uri) == null) return AppRoutes.home;
              return null;
            },
            builder: (context, state) {
              return DashboardJobDetailPage(
                jobId: DeepLink.jobIdOf(state.uri)!,
              );
            },
          ),
          GoRoute(
            path: AppRoutes.candidateOffers,
            name: AppRouteNames.candidateOffers,
            builder: (context, state) => const CandidateOffersPage(),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.authLogin,
        name: AppRouteNames.authLogin,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.authSignUp,
        name: AppRouteNames.authSignUp,
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        path: AppRoutes.login,
        name: AppRouteNames.login,
        redirect: (context, state) => AppRoutes.authLogin,
      ),
      GoRoute(
        path: AppRoutes.register,
        name: AppRouteNames.register,
        redirect: (context, state) => AppRoutes.authSignUp,
      ),
      GoRoute(
        path: AppRoutes.signUp,
        name: AppRouteNames.signUp,
        redirect: (context, state) => AppRoutes.authSignUp,
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
});

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
