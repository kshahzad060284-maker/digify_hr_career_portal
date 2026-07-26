class CandidateSession {
  const CandidateSession({
    required this.candidateUserId,
    required this.candidateUserGuid,
    required this.candidateId,
    required this.candidateGuid,
    required this.fullName,
    required this.email,
    required this.userStatus,
  });

  final int candidateUserId;
  final String candidateUserGuid;
  final int candidateId;
  final String candidateGuid;
  final String fullName;
  final String email;
  final String userStatus;

  bool get isLoggedIn => candidateGuid.isNotEmpty;
}
