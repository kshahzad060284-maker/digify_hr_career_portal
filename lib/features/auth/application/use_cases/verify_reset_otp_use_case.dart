import 'package:career_portal/features/auth/domain/models/verify_reset_otp_result.dart';
import 'package:career_portal/features/auth/domain/repositories/auth_repository.dart';

class VerifyResetOtpUseCase {
  const VerifyResetOtpUseCase(this._repository);

  final AuthRepository _repository;

  Future<VerifyResetOtpResult> call({
    required int enterpriseId,
    required String email,
    required String otp,
  }) {
    return _repository.verifyResetOtp(
      enterpriseId: enterpriseId,
      email: email,
      otp: otp,
    );
  }
}
