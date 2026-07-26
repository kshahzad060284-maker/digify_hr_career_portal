import 'package:career_portal/features/auth/domain/repositories/auth_local_repository.dart';

class ClearCandidateGuidUseCase {
  const ClearCandidateGuidUseCase(this._repository);

  final AuthLocalRepository _repository;

  Future<void> call() {
    return _repository.clear();
  }
}
