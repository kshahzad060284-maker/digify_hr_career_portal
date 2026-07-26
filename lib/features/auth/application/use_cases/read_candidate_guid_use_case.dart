import 'package:career_portal/features/auth/domain/repositories/auth_local_repository.dart';

class ReadCandidateGuidUseCase {
  const ReadCandidateGuidUseCase(this._repository);

  final AuthLocalRepository _repository;

  String? call() {
    return _repository.readCandidateGuid();
  }
}
