import 'package:career_portal/features/dashboard/domain/models/dashboard_job.dart';
import 'package:career_portal/features/dashboard/domain/repositories/job_postings_repository.dart';

class GetJobPostingUseCase {
  const GetJobPostingUseCase(this._repository);

  final JobPostingsRepository _repository;

  Future<DashboardJob> call({
    required String postingGuid,
    required int enterpriseId,
    String? candidateGuid,
  }) {
    return _repository.getJobPosting(
      postingGuid: postingGuid,
      enterpriseId: enterpriseId,
      candidateGuid: candidateGuid,
    );
  }
}
