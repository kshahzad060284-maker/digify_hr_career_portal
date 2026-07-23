import 'package:career_portal/features/dashboard/data/dto/job_posting_dto.dart';
import 'package:career_portal/features/dashboard/data/dto/job_posting_pagination_dto.dart';

class JobPostingsResponseDto {
  const JobPostingsResponseDto({
    required this.success,
    required this.jobs,
    this.pagination,
    this.message,
    this.authenticated,
    this.candidateGuid,
  });

  final bool success;
  final String? message;
  final bool? authenticated;
  final String? candidateGuid;
  final JobPostingPaginationDto? pagination;
  final List<JobPostingDto> jobs;

  factory JobPostingsResponseDto.fromJson(Map<String, dynamic> json) {
    final meta = json['meta'];
    JobPostingPaginationDto? pagination;
    if (meta is Map<String, dynamic>) {
      final paginationJson = meta['pagination'];
      if (paginationJson is Map<String, dynamic>) {
        pagination = JobPostingPaginationDto.fromJson(paginationJson);
      }
    }

    final data = json['data'];
    final jobs = data is List
        ? data
              .whereType<Map<String, dynamic>>()
              .map(JobPostingDto.fromJson)
              .toList()
        : <JobPostingDto>[];

    return JobPostingsResponseDto(
      success: json['success'] == true,
      message: json['message']?.toString(),
      authenticated: json['authenticated'] is bool
          ? json['authenticated'] as bool
          : null,
      candidateGuid: json['candidate_guid']?.toString(),
      pagination: pagination,
      jobs: jobs,
    );
  }
}
