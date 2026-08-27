import 'package:career_portal/features/auth/domain/repositories/auth_repository.dart';

class ForgotPasswordUseCase {
  const ForgotPasswordUseCase(this._repository);

  final AuthRepository _repository;

  Future<String> call({required int enterpriseId, required String email}) {
    return _repository.forgotPassword(enterpriseId: enterpriseId, email: email);
  }
}
