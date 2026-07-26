import 'package:career_portal/features/auth/domain/repositories/auth_local_repository.dart';

class SaveCandidateGuidUseCase {
  const SaveCandidateGuidUseCase(this._repository);

  final AuthLocalRepository _repository;

  Future<void> call(String candidateGuid) {
    return _repository.saveCandidateGuid(candidateGuid);
  }
}
