import 'package:career_portal/features/dashboard/data/dto/job_posting_dto.dart';

class JobPostingDetailResponseDto {
  const JobPostingDetailResponseDto({
    required this.success,
    this.message,
    this.job,
  });

  final bool success;
  final String? message;
  final JobPostingDto? job;

  factory JobPostingDetailResponseDto.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    JobPostingDto? job;
    if (data is Map<String, dynamic>) {
      job = JobPostingDto.fromJson(data);
    }

    return JobPostingDetailResponseDto(
      success: json['success'] == true,
      message: json['message']?.toString(),
      job: job,
    );
  }
}
