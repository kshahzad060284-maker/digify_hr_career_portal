import 'package:career_portal/features/dashboard/domain/models/job_company_info.dart';
import 'package:career_portal/features/dashboard/domain/repositories/job_postings_repository.dart';

class GetJobPostingEmployerInfoUseCase {
  const GetJobPostingEmployerInfoUseCase(this._repository);

  final JobPostingsRepository _repository;

  Future<JobCompanyInfo> call({required String postingGuid}) {
    return _repository.getJobPostingEmployerInfo(postingGuid: postingGuid);
  }
}
