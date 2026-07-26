import 'package:career_portal/features/auth/domain/models/candidate_session.dart';
import 'package:career_portal/features/auth/domain/repositories/auth_repository.dart';

class GetCandidateProfileUseCase {
  const GetCandidateProfileUseCase(this._repository);

  final AuthRepository _repository;

  Future<CandidateSession> call({
    required String candidateGuid,
    required int enterpriseId,
  }) {
    return _repository.getCandidateProfile(
      candidateGuid: candidateGuid,
      enterpriseId: enterpriseId,
    );
  }
}
