import 'package:career_portal/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:career_portal/features/auth/domain/models/candidate_session.dart';
import 'package:career_portal/features/auth/domain/models/register_candidate_input.dart';
import 'package:career_portal/features/auth/domain/models/register_candidate_result.dart';
import 'package:career_portal/features/auth/domain/models/verify_reset_otp_result.dart';
import 'package:career_portal/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<CandidateSession> login({
    required int enterpriseId,
    required String email,
    required String password,
  }) {
    return _remoteDataSource.login(
      enterpriseId: enterpriseId,
      email: email,
      password: password,
    );
  }

  @override
  Future<RegisterCandidateResult> registerCandidate(
    RegisterCandidateInput input,
  ) {
    return _remoteDataSource.registerCandidate(input);
  }

  @override
  Future<CandidateSession> getCandidateProfile({
    required String candidateGuid,
    required int enterpriseId,
  }) {
    return _remoteDataSource.getCandidateProfile(
      candidateGuid: candidateGuid,
      enterpriseId: enterpriseId,
    );
  }

  @override
  Future<String> forgotPassword({
    required int enterpriseId,
    required String email,
  }) {
    return _remoteDataSource.forgotPassword(
      enterpriseId: enterpriseId,
      email: email,
    );
  }

  @override
  Future<VerifyResetOtpResult> verifyResetOtp({
    required int enterpriseId,
    required String email,
    required String otp,
  }) {
    return _remoteDataSource.verifyResetOtp(
      enterpriseId: enterpriseId,
      email: email,
      otp: otp,
    );
  }

  @override
  Future<String> resetPassword({
    required String resetToken,
    required String newPassword,
    required String confirmPassword,
  }) {
    return _remoteDataSource.resetPassword(
      resetToken: resetToken,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
  }
}
