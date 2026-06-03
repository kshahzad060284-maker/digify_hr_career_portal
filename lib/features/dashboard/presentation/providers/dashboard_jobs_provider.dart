import 'package:career_portal/features/dashboard/domain/models/dashboard_job.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_filters_controller.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_jobs_list_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardAllJobsProvider = Provider<List<DashboardJob>>((ref) {
  return ref.watch(dashboardJobsControllerProvider).value?.jobs ?? const [];
});

final dashboardJobLocationsProvider = Provider<List<String>>((ref) {
  final jobs = ref.watch(dashboardAllJobsProvider);
  return jobs
      .map((job) => job.location)
      .where((l) => l.isNotEmpty)
      .toSet()
      .toList()
    ..sort();
});

final dashboardFilteredJobsProvider = Provider<List<DashboardJob>>((ref) {
  final jobs = ref.watch(dashboardAllJobsProvider);
  final filters = ref.watch(dashboardFiltersControllerProvider);

  if (filters.isAllLocations) {
    return jobs;
  }

  return jobs.where((job) => job.location == filters.selectedLocation).toList();
});
