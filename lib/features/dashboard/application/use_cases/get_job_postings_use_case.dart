import 'package:career_portal/features/dashboard/domain/models/job_postings_page.dart';
import 'package:career_portal/features/dashboard/domain/repositories/job_postings_repository.dart';

class GetJobPostingsUseCase {
  const GetJobPostingsUseCase(this._repository);

  final JobPostingsRepository _repository;

  Future<JobPostingsPage> call({
    required int enterpriseId,
    required int page,
    required int pageSize,
    String? search,
    String? candidateGuid,
  }) {
    return _repository.getJobPostings(
      enterpriseId: enterpriseId,
      page: page,
      pageSize: pageSize,
      search: search,
      candidateGuid: candidateGuid,
    );
  }
}
