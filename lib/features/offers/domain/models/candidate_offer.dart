enum CandidateOfferStatus { pending, accepted, declined, expired }

class CandidateOffer {
  const CandidateOffer({
    required this.offerGuid,
    required this.offerNumber,
    required this.jobTitle,
    required this.postingTitle,
    required this.department,
    required this.location,
    required this.workMode,
    required this.employmentType,
    required this.salary,
    required this.status,
    required this.statusCode,
    required this.stage,
    required this.stageDescription,
    this.sentDate,
    this.expiryDate,
    this.startDate,
  });

  final String offerGuid;
  final String offerNumber;
  final String jobTitle;
  final String postingTitle;
  final String department;
  final String location;
  final String workMode;
  final String employmentType;
  final String salary;
  final CandidateOfferStatus status;
  final String statusCode;
  final String stage;
  final String stageDescription;
  final DateTime? sentDate;
  final DateTime? expiryDate;
  final DateTime? startDate;

  bool get canRespond {
    final code = statusCode.trim().toUpperCase();
    return code == 'EXTENDED' || code == 'EXTEND' || code == 'PENDING';
  }
}
