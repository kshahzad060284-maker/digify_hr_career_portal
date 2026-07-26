import 'package:career_portal/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:career_portal/features/auth/domain/repositories/auth_local_repository.dart';

class AuthLocalRepositoryImpl implements AuthLocalRepository {
  const AuthLocalRepositoryImpl(this._localDataSource);

  final AuthLocalDataSource _localDataSource;

  @override
  Future<void> saveCandidateGuid(String candidateGuid) {
    return _localDataSource.saveCandidateGuid(candidateGuid);
  }

  @override
  String? readCandidateGuid() {
    return _localDataSource.readCandidateGuid();
  }

  @override
  Future<void> clear() {
    return _localDataSource.clear();
  }
}
