abstract interface class AuthLocalRepository {
  Future<void> saveCandidateGuid(String candidateGuid);

  String? readCandidateGuid();

  Future<void> clear();
}
