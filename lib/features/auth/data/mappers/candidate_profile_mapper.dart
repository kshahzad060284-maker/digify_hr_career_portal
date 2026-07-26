import 'package:career_portal/features/auth/data/dto/candidate_profile_response_dto.dart';
import 'package:career_portal/features/auth/domain/models/candidate_session.dart';

abstract final class CandidateProfileMapper {
  CandidateProfileMapper._();

  static CandidateSession toSession(CandidateProfileDto dto) {
    return CandidateSession(
      candidateUserId: 0,
      candidateUserGuid: '',
      candidateId: dto.candidateId,
      candidateGuid: dto.candidateGuid,
      fullName: dto.fullName,
      email: dto.email,
      userStatus: dto.status,
    );
  }
}
