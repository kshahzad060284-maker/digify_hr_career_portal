import 'package:career_portal/features/dashboard/domain/models/job_company_info.dart';
import 'package:career_portal/features/dashboard/domain/repositories/job_postings_repository.dart';

class GetJobEmployerInfoUseCase {
  const GetJobEmployerInfoUseCase(this._repository);

  final JobPostingsRepository _repository;

  Future<JobCompanyInfo> call({
    required String postingGuid,
    required int enterpriseId,
  }) {
    return _repository.getJobEmployerInfo(
      postingGuid: postingGuid,
      enterpriseId: enterpriseId,
    );
  }
}
