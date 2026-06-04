import 'package:career_portal/features/auth/domain/models/candidate_session.dart';
import 'package:career_portal/features/auth/domain/models/register_candidate_input.dart';
import 'package:career_portal/features/auth/domain/models/register_candidate_result.dart';

abstract interface class AuthRepository {
  Future<CandidateSession> login({
    required int enterpriseId,
    required String email,
    required String password,
  });

  Future<RegisterCandidateResult> registerCandidate(
    RegisterCandidateInput input,
  );
}
