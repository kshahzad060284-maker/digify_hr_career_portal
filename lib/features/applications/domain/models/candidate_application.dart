enum CandidateApplicationStatus {
  newApplication,
  inProgress,
  rejected,
  hired,
  withdrawn,
}

class CandidateApplication {
  const CandidateApplication({
    required this.applicationGuid,
    required this.applicationNumber,
    required this.postingGuid,
    required this.postingTitle,
    required this.requisitionTitle,
    required this.stageCode,
    required this.statusCode,
    required this.status,
    this.appliedDate,
    this.resumeFileName,
  });

  final String applicationGuid;
  final String applicationNumber;
  final String postingGuid;
  final String postingTitle;
  final String requisitionTitle;
  final String stageCode;
  final String statusCode;
  final CandidateApplicationStatus status;
  final DateTime? appliedDate;
  final String? resumeFileName;
}
