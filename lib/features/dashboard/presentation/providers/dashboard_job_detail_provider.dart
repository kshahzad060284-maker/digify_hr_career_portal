import 'package:career_portal/features/dashboard/presentation/controllers/dashboard_job_detail_controller.dart';
import 'package:career_portal/features/dashboard/presentation/state/dashboard_job_detail_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

export 'dashboard_jobs_di_provider.dart';

final dashboardJobDetailControllerProvider =
    AutoDisposeAsyncNotifierProvider.family<
      DashboardJobDetailController,
      DashboardJobDetailState,
      String
    >(DashboardJobDetailController.new);
