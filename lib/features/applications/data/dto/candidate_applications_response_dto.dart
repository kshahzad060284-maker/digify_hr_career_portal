import 'package:career_portal/features/applications/data/dto/candidate_application_dto.dart';
import 'package:career_portal/features/applications/data/dto/candidate_applications_pagination_dto.dart';

class CandidateApplicationsResponseDto {
  const CandidateApplicationsResponseDto({
    required this.success,
    required this.applications,
    this.pagination,
    this.message,
  });

  final bool success;
  final String? message;
  final CandidateApplicationsPaginationDto? pagination;
  final List<CandidateApplicationDto> applications;

  factory CandidateApplicationsResponseDto.fromJson(Map<String, dynamic> json) {
    CandidateApplicationsPaginationDto? pagination;
    final meta = json['meta'];
    if (meta is Map<String, dynamic>) {
      final paginationJson = meta['pagination'];
      if (paginationJson is Map<String, dynamic>) {
        pagination = CandidateApplicationsPaginationDto.fromJson(
          paginationJson,
        );
      }
    } else {
      final paginationJson = json['pagination'];
      if (paginationJson is Map<String, dynamic>) {
        pagination = CandidateApplicationsPaginationDto.fromJson(
          paginationJson,
        );
      }
    }

    final data = json['data'];
    final applications = data is List
        ? data
              .whereType<Map<String, dynamic>>()
              .map(CandidateApplicationDto.fromJson)
              .toList()
        : <CandidateApplicationDto>[];

    return CandidateApplicationsResponseDto(
      success: json['success'] == true,
      message: json['message']?.toString(),
      pagination: pagination,
      applications: applications,
    );
  }
}
