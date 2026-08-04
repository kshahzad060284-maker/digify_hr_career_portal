import 'package:career_portal/core/domain/models/pagination_info.dart';
import 'package:career_portal/features/applications/data/dto/candidate_application_dto.dart';
import 'package:career_portal/features/applications/data/dto/candidate_applications_pagination_dto.dart';
import 'package:career_portal/features/applications/domain/models/candidate_application.dart';
import 'package:career_portal/features/applications/domain/models/candidate_applications_page.dart';

class CandidateApplicationMapper {
  const CandidateApplicationMapper._();

  static CandidateApplication toDomain(CandidateApplicationDto dto) {
    return CandidateApplication(
      applicationId: dto.applicationId,
      applicationGuid: dto.applicationGuid,
      applicationNumber: dto.applicationNumber,
      postingGuid: dto.postingGuid,
      postingTitle: dto.postingTitle,
      requisitionTitle: dto.requisitionTitle,
      stageCode: dto.currentStageCode,
      statusCode: dto.statusCode,
      status: _mapStatus(dto.statusCode),
      appliedDate: _parseDate(dto.appliedDate),
      resumeFileName: dto.resumeFileName,
    );
  }

  static CandidateApplicationsPage toPage({
    required List<CandidateApplicationDto> dtos,
    required CandidateApplicationsPaginationDto pagination,
  }) {
    return CandidateApplicationsPage(
      applications: dtos.map(toDomain).toList(growable: false),
      pagination: PaginationInfo(
        totalPages: pagination.totalPages,
        totalItems: pagination.total,
        hasNext: pagination.hasNext,
        hasPrevious: pagination.hasPrevious,
      ),
      currentPage: pagination.page,
      pageSize: pagination.pageSize,
    );
  }

  static CandidateApplicationStatus _mapStatus(String statusCode) {
    switch (statusCode.trim().toUpperCase()) {
      case 'HIRED':
      case 'SELECTED':
      case 'ACCEPTED':
        return CandidateApplicationStatus.hired;
      case 'REJECTED':
      case 'DECLINED':
        return CandidateApplicationStatus.rejected;
      case 'WITHDRAWN':
      case 'WITHDRAW':
        return CandidateApplicationStatus.withdrawn;
      case 'IN_PROGRESS':
      case 'INTERVIEW':
      case 'SHORTLISTED':
        return CandidateApplicationStatus.inProgress;
      case 'NEW':
      default:
        return CandidateApplicationStatus.newApplication;
    }
  }

  static DateTime? _parseDate(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    return DateTime.tryParse(value);
  }
}
