import 'package:career_portal/features/auth/data/dto/register_response_dto.dart';
import 'package:career_portal/features/auth/domain/models/register_candidate_result.dart';

abstract final class RegisterCandidateResultMapper {
  RegisterCandidateResultMapper._();

  static RegisterCandidateResult toDomain(RegisterResponseDto dto) {
    return RegisterCandidateResult(
      message: dto.message ?? 'Registration successful.',
      candidateId: dto.candidateId ?? 0,
      candidateGuid: dto.candidateGuid ?? '',
      candidateUserId: dto.candidateUserId ?? 0,
      candidateUserGuid: dto.candidateUserGuid ?? '',
    );
  }
}
