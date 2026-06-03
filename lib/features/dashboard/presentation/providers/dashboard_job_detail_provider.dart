import 'package:career_portal/features/dashboard/domain/models/dashboard_job.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_jobs_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardJobByIdProvider = Provider.family<DashboardJob?, String>((
  ref,
  jobId,
) {
  final jobs = ref.watch(dashboardAllJobsProvider);
  for (final job in jobs) {
    if (job.id == jobId) {
      return job;
    }
  }
  return null;
});
