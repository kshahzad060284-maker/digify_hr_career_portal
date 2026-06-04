import 'package:career_portal/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:career_portal/features/auth/domain/models/candidate_session.dart';
import 'package:career_portal/features/auth/domain/models/register_candidate_input.dart';
import 'package:career_portal/features/auth/domain/models/register_candidate_result.dart';
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
}
