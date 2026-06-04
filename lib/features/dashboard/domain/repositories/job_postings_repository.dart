import 'package:career_portal/features/dashboard/domain/models/apply_job_input.dart';
import 'package:career_portal/features/dashboard/domain/models/dashboard_job.dart';
import 'package:career_portal/features/dashboard/domain/models/job_postings_page.dart';

abstract interface class JobPostingsRepository {
  Future<JobPostingsPage> getJobPostings({
    required int enterpriseId,
    required int page,
    required int pageSize,
    String? search,
  });

  Future<DashboardJob> getJobPosting({
    required String postingGuid,
    required int enterpriseId,
  });

  Future<void> applyForJob(ApplyJobInput input);
}
