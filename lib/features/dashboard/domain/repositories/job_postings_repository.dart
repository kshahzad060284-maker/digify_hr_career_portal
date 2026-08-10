import 'package:career_portal/features/dashboard/domain/models/apply_job_input.dart';
import 'package:career_portal/features/dashboard/domain/models/dashboard_job.dart';
import 'package:career_portal/features/dashboard/domain/models/employer_assignment_type.dart';
import 'package:career_portal/features/dashboard/domain/models/job_company_info.dart';
import 'package:career_portal/features/dashboard/domain/models/job_postings_page.dart';

abstract interface class JobPostingsRepository {
  Future<JobPostingsPage> getJobPostings({
    required int enterpriseId,
    required int page,
    required int pageSize,
    String? search,
    String? candidateGuid,
  });

  Future<DashboardJob> getJobPosting({
    required String postingGuid,
    required int enterpriseId,
    String? candidateGuid,
  });

  Future<JobCompanyInfo> getEmployerInfo({
    required int enterpriseId,
    required EmployerAssignmentType assignmentType,
  });

  Future<JobCompanyInfo> getJobPostingEmployerInfo({
    required String postingGuid,
  });

  Future<void> applyForJob(ApplyJobInput input);
}
