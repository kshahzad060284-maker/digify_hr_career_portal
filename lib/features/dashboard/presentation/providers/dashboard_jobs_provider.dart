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

final dashboardJobDepartmentsProvider = Provider<List<String>>((ref) {
  final jobs = ref.watch(dashboardAllJobsProvider);
  return jobs
      .map((job) => job.department)
      .where((d) => d.isNotEmpty)
      .toSet()
      .toList()
    ..sort();
});

final dashboardJobEmploymentTypesProvider = Provider<List<String>>((ref) {
  final jobs = ref.watch(dashboardAllJobsProvider);
  return jobs
      .map((job) => job.employmentType)
      .where((t) => t.isNotEmpty)
      .toSet()
      .toList()
    ..sort();
});

final dashboardFilteredJobsProvider = Provider<List<DashboardJob>>((ref) {
  final jobs = ref.watch(dashboardAllJobsProvider);
  final filters = ref.watch(dashboardFiltersControllerProvider);

  return jobs.where((job) {
    if (!filters.isAllLocations && job.location != filters.selectedLocation) {
      return false;
    }
    if (!filters.isAllDepartments &&
        job.department != filters.selectedDepartment) {
      return false;
    }
    if (!filters.isAllEmploymentTypes &&
        job.employmentType != filters.selectedEmploymentType) {
      return false;
    }
    return true;
  }).toList();
});
