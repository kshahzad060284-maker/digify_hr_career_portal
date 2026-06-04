import 'package:career_portal/features/auth/domain/models/register_candidate_input.dart';
import 'package:career_portal/features/auth/domain/models/register_candidate_result.dart';
import 'package:career_portal/features/auth/domain/repositories/auth_repository.dart';

class RegisterCandidateUseCase {
  const RegisterCandidateUseCase(this._repository);

  final AuthRepository _repository;

  Future<RegisterCandidateResult> call(RegisterCandidateInput input) {
    return _repository.registerCandidate(input);
  }
}
