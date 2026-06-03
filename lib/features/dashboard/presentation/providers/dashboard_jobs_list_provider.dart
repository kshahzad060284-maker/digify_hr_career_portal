import 'package:career_portal/features/dashboard/presentation/controllers/dashboard_jobs_controller.dart';
import 'package:career_portal/features/dashboard/presentation/state/dashboard_jobs_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
export 'dashboard_jobs_di_provider.dart';

final dashboardJobsControllerProvider =
    AsyncNotifierProvider<DashboardJobsController, DashboardJobsState>(
      DashboardJobsController.new,
    );
