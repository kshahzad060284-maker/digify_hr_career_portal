import 'package:career_portal/core/domain/models/pagination_info.dart';
import 'package:career_portal/features/dashboard/domain/models/dashboard_job.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_filters_controller.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_job_search_controller.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_jobs_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const dashboardJobsPageSize = 10;

class DashboardJobsPageNotifier extends Notifier<int> {
  @override
  int build() {
    ref.listen(
      dashboardJobSearchControllerProvider.select((s) => s.debouncedQuery),
      (_, _) => state = 1,
    );
    ref.listen(
      dashboardFiltersControllerProvider.select((s) => s.selectedLocation),
      (_, _) => state = 1,
    );
    return 1;
  }

  void goToPage(int page) => state = page;

  void goToPreviousPage() => state = state - 1;

  void goToNextPage() => state = state + 1;
}

final dashboardJobsCurrentPageProvider =
    NotifierProvider<DashboardJobsPageNotifier, int>(
      DashboardJobsPageNotifier.new,
    );

final dashboardJobsEffectivePageProvider = Provider<int>((ref) {
  final totalItems = ref.watch(dashboardFilteredJobsProvider).length;
  final rawPage = ref.watch(dashboardJobsCurrentPageProvider);
  final totalPages = totalItems == 0
      ? 1
      : (totalItems / dashboardJobsPageSize).ceil();
  return rawPage.clamp(1, totalPages);
});

final dashboardJobsPaginationInfoProvider = Provider<PaginationInfo>((ref) {
  final totalItems = ref.watch(dashboardFilteredJobsProvider).length;
  final currentPage = ref.watch(dashboardJobsEffectivePageProvider);

  return PaginationInfo.fromTotals(
    totalItems: totalItems,
    pageSize: dashboardJobsPageSize,
    currentPage: currentPage,
  );
});

final dashboardPaginatedJobsProvider = Provider<List<DashboardJob>>((ref) {
  final jobs = ref.watch(dashboardFilteredJobsProvider);
  final currentPage = ref.watch(dashboardJobsEffectivePageProvider);

  if (jobs.isEmpty) {
    return const [];
  }

  final startIndex = (currentPage - 1) * dashboardJobsPageSize;
  final endIndex = (startIndex + dashboardJobsPageSize).clamp(0, jobs.length);
  return jobs.sublist(startIndex, endIndex);
});
