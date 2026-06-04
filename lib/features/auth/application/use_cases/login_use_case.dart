import 'package:career_portal/features/auth/domain/models/candidate_session.dart';
import 'package:career_portal/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  const LoginUseCase(this._repository);

  final AuthRepository _repository;

  Future<CandidateSession> call({
    required int enterpriseId,
    required String email,
    required String password,
  }) {
    return _repository.login(
      enterpriseId: enterpriseId,
      email: email,
      password: password,
    );
  }
}
