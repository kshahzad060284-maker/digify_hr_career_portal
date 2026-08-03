import 'package:career_portal/core/domain/models/pagination_info.dart';
import 'package:career_portal/features/dashboard/data/dto/job_posting_dto.dart';
import 'package:career_portal/features/dashboard/data/dto/job_posting_pagination_dto.dart';
import 'package:career_portal/features/dashboard/domain/models/dashboard_job.dart';
import 'package:career_portal/features/dashboard/domain/models/job_application_status.dart';
import 'package:career_portal/features/dashboard/domain/models/job_postings_page.dart';

class JobPostingMapper {
  const JobPostingMapper._();

  static DashboardJob toDomain(JobPostingDto dto) {
    final description = dto.aboutTheRole.trim().isNotEmpty
        ? dto.aboutTheRole
        : dto.postingDescription;

    return DashboardJob(
      id: dto.postingGuid.isNotEmpty
          ? dto.postingGuid
          : dto.postingId.toString(),
      title: dto.postingTitle,
      department: dto.positionName,
      location: _formatCodeLabel(dto.workModeCode),
      employmentType: _formatEmploymentLabel(
        dto.employmentTypeCode,
        dto.workModeCode,
      ),
      description: description,
      responsibilities: dto.responsibilities,
      qualifications: dto.qualifications,
      salaryRange: '',
      startDate: dto.targetStartDate ?? dto.startDate ?? '',
      level: dto.priorityCode,
      contactEmail: 'support@digifyapps.net',
      openingsCount: dto.numberOfOpenings,
      isUrgent: dto.priorityCode.toUpperCase() == 'HIGH',
      applicationStatus: JobApplicationStatus.tryParse(
        applicationStatus: dto.applicationStatus,
        appliedFlag: dto.appliedFlag,
      ),
      applicationId: dto.applicationId,
      applicationGuid: dto.applicationGuid,
    );
  }

  static JobPostingsPage toPage({
    required List<JobPostingDto> dtos,
    required JobPostingPaginationDto pagination,
  }) {
    final jobs = dtos.map(toDomain).toList(growable: false);

    return JobPostingsPage(
      jobs: jobs,
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

  static String _formatEmploymentLabel(String employmentCode, String workMode) {
    final employment = _formatCodeLabel(employmentCode);
    final mode = _formatCodeLabel(workMode);
    if (employment.isEmpty) return mode;
    if (mode.isEmpty) return employment;
    return '$employment • $mode';
  }

  static String _formatCodeLabel(String code) {
    if (code.trim().isEmpty) return '';
    return code
        .toLowerCase()
        .split('_')
        .map(
          (part) => part.isEmpty
              ? part
              : '${part[0].toUpperCase()}${part.substring(1)}',
        )
        .join(' ');
  }
}
