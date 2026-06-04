import 'package:career_portal/features/auth/domain/models/candidate_session.dart';

class RegisterCandidateResult {
  const RegisterCandidateResult({
    required this.message,
    required this.candidateId,
    required this.candidateGuid,
    required this.candidateUserId,
    required this.candidateUserGuid,
  });

  final String message;
  final int candidateId;
  final String candidateGuid;
  final int candidateUserId;
  final String candidateUserGuid;

  CandidateSession toSession({
    required String fullName,
    required String email,
  }) {
    return CandidateSession(
      candidateUserId: candidateUserId,
      candidateUserGuid: candidateUserGuid,
      candidateId: candidateId,
      candidateGuid: candidateGuid,
      fullName: fullName,
      email: email,
      userStatus: 'ACTIVE',
    );
  }
}
