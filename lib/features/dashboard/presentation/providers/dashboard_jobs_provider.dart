import 'package:career_portal/features/dashboard/domain/models/dashboard_job.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_filters_controller.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_job_search_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _mockJobs = [
  DashboardJob(
    id: '1',
    title: 'Senior Software Engineer',
    department: 'Engineering',
    location: 'San Francisco, CA',
    employmentType: 'Full-time • Hybrid',
    description:
        'We are seeking an experienced Senior Software Engineer to join our platform team.',
    openingsCount: 2,
    isUrgent: true,
  ),
  DashboardJob(
    id: '2',
    title: 'UX Designer',
    department: 'Design',
    location: 'Austin, TX',
    employmentType: 'Full-time • Hybrid',
    description:
        'Seeking a creative UX Designer to enhance our user experience.',
    openingsCount: 1,
    isUrgent: true,
  ),
];

final dashboardAllJobsProvider = Provider<List<DashboardJob>>((ref) {
  return _mockJobs;
});

final dashboardJobLocationsProvider = Provider<List<String>>((ref) {
  final jobs = ref.watch(dashboardAllJobsProvider);
  return jobs.map((job) => job.location).toSet().toList()..sort();
});

final dashboardFilteredJobsProvider = Provider<List<DashboardJob>>((ref) {
  final jobs = ref.watch(dashboardAllJobsProvider);
  final search = ref.watch(dashboardJobSearchControllerProvider);
  final filters = ref.watch(dashboardFiltersControllerProvider);
  final query = search.debouncedQuery.toLowerCase();

  return jobs.where((job) {
    final matchesSearch =
        query.isEmpty ||
        job.title.toLowerCase().contains(query) ||
        job.department.toLowerCase().contains(query) ||
        job.description.toLowerCase().contains(query);

    final matchesLocation =
        filters.isAllLocations || job.location == filters.selectedLocation;

    return matchesSearch && matchesLocation;
  }).toList();
});
