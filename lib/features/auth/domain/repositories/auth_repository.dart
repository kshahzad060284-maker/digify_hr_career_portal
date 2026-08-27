import 'package:career_portal/features/auth/domain/models/candidate_session.dart';
import 'package:career_portal/features/auth/domain/models/register_candidate_input.dart';
import 'package:career_portal/features/auth/domain/models/register_candidate_result.dart';
import 'package:career_portal/features/auth/domain/models/verify_reset_otp_result.dart';

abstract interface class AuthRepository {
  Future<CandidateSession> login({
    required int enterpriseId,
    required String email,
    required String password,
  });

  Future<RegisterCandidateResult> registerCandidate(
    RegisterCandidateInput input,
  );

  Future<CandidateSession> getCandidateProfile({
    required String candidateGuid,
    required int enterpriseId,
  });

  Future<String> forgotPassword({
    required int enterpriseId,
    required String email,
  });

  Future<VerifyResetOtpResult> verifyResetOtp({
    required int enterpriseId,
    required String email,
    required String otp,
  });

  Future<String> resetPassword({
    required String resetToken,
    required String newPassword,
    required String confirmPassword,
  });
}
