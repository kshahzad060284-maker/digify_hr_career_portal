import 'package:career_portal/features/dashboard/domain/models/apply_job_input.dart';
import 'package:dio/dio.dart';

abstract final class ApplyJobMultipartMapper {
  ApplyJobMultipartMapper._();

  static FormData toFormData(ApplyJobInput input) {
    return FormData.fromMap(<String, dynamic>{
      'enterprise_id': input.enterpriseId,
      'candidate_guid': input.candidateGuid,
      'source_code': input.sourceCode,
      'created_by': input.createdBy,
      'resume_file': MultipartFile.fromBytes(
        input.resumeBytes,
        filename: input.resumeFileName,
      ),
    });
  }
}
