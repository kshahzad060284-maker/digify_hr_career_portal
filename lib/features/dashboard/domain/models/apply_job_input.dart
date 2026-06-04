import 'dart:typed_data';

class ApplyJobInput {
  const ApplyJobInput({
    required this.postingGuid,
    required this.enterpriseId,
    required this.candidateGuid,
    required this.sourceCode,
    required this.resumeFileName,
    required this.resumeBytes,
    this.createdBy = 'CANDIDATE',
  });

  final String postingGuid;
  final int enterpriseId;
  final String candidateGuid;
  final String sourceCode;
  final String resumeFileName;
  final Uint8List resumeBytes;
  final String createdBy;
}
