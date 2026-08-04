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

  static const missingValue = '--';

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

  String get subtitle {
    return [
      if (!isMissing(offerNumber)) offerNumber,
      if (!isMissing(department)) department,
      if (!isMissing(postingTitle) && postingTitle != jobTitle) postingTitle,
    ].join(' · ');
  }

  String? get visibleStageDescription =>
      isMissing(stageDescription) ? null : stageDescription.trim();

  bool get isExpiryUrgent {
    if (!canRespond || expiryDate == null) return false;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final expiry = DateTime(
      expiryDate!.year,
      expiryDate!.month,
      expiryDate!.day,
    );
    return !expiry.isAfter(today);
  }

  static bool isMissing(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty || trimmed == missingValue;
  }
}
