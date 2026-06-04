import 'package:career_portal/features/auth/data/dto/candidate_user_dto.dart';
import 'package:career_portal/features/auth/domain/models/candidate_session.dart';

abstract final class CandidateSessionMapper {
  CandidateSessionMapper._();

  static CandidateSession toDomain(CandidateUserDto dto) {
    return CandidateSession(
      candidateUserId: dto.candidateUserId,
      candidateUserGuid: dto.candidateUserGuid,
      candidateId: dto.candidateId,
      candidateGuid: dto.candidateGuid,
      fullName: dto.fullName,
      email: dto.email,
      userStatus: dto.userStatus,
    );
  }
}
