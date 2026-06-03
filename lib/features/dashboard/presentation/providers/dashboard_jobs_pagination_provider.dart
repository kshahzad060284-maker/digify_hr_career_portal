import 'package:career_portal/core/domain/models/pagination_info.dart';
import 'package:career_portal/features/dashboard/domain/config/dashboard_jobs_config.dart';
import 'package:career_portal/features/dashboard/domain/models/dashboard_job.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_jobs_list_provider.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_jobs_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const dashboardJobsPageSize = DashboardJobsConfig.defaultPageSize;

final dashboardJobsEffectivePageProvider = Provider<int>((ref) {
  return ref.watch(dashboardJobsControllerProvider).value?.currentPage ?? 1;
});

final dashboardJobsPaginationInfoProvider = Provider<PaginationInfo>((ref) {
  return ref.watch(dashboardJobsControllerProvider).value?.pagination ??
      const PaginationInfo(
        totalPages: 1,
        totalItems: 0,
        hasNext: false,
        hasPrevious: false,
      );
});

final dashboardPaginatedJobsProvider = Provider<List<DashboardJob>>((ref) {
  return ref.watch(dashboardFilteredJobsProvider);
});

final dashboardJobsTotalCountProvider = Provider<int>((ref) {
  final jobsState = ref.watch(dashboardJobsControllerProvider).value;
  if (jobsState == null) return 0;
  return jobsState.pagination.totalItems;
});
