import 'package:career_portal/features/dashboard/data/datasources/job_postings_remote_data_source.dart';
import 'package:career_portal/features/dashboard/domain/models/apply_job_input.dart';
import 'package:career_portal/features/dashboard/domain/models/dashboard_job.dart';
import 'package:career_portal/features/dashboard/domain/models/job_postings_page.dart';
import 'package:career_portal/features/dashboard/domain/repositories/job_postings_repository.dart';

class JobPostingsRepositoryImpl implements JobPostingsRepository {
  const JobPostingsRepositoryImpl(this._remoteDataSource);

  final JobPostingsRemoteDataSource _remoteDataSource;

  @override
  Future<JobPostingsPage> getJobPostings({
    required int enterpriseId,
    required int page,
    required int pageSize,
    String? search,
    String? candidateGuid,
  }) {
    return _remoteDataSource.getJobPostings(
      enterpriseId: enterpriseId,
      page: page,
      pageSize: pageSize,
      search: search,
      candidateGuid: candidateGuid,
    );
  }

  @override
  Future<DashboardJob> getJobPosting({
    required String postingGuid,
    required int enterpriseId,
    String? candidateGuid,
  }) {
    return _remoteDataSource.getJobPosting(
      postingGuid: postingGuid,
      enterpriseId: enterpriseId,
      candidateGuid: candidateGuid,
    );
  }

  @override
  Future<void> applyForJob(ApplyJobInput input) {
    return _remoteDataSource.applyForJob(input);
  }
}
