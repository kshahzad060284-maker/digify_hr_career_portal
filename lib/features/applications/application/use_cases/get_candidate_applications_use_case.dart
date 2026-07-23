import 'package:career_portal/features/applications/domain/models/candidate_applications_page.dart';
import 'package:career_portal/features/applications/domain/repositories/candidate_applications_repository.dart';

class GetCandidateApplicationsUseCase {
  const GetCandidateApplicationsUseCase(this._repository);

  final CandidateApplicationsRepository _repository;

  Future<CandidateApplicationsPage> call({
    required int enterpriseId,
    required String candidateGuid,
    required int page,
    required int pageSize,
  }) {
    return _repository.getCandidateApplications(
      enterpriseId: enterpriseId,
      candidateGuid: candidateGuid,
      page: page,
      pageSize: pageSize,
    );
  }
}
