import 'package:career_portal/core/network/api_endpoints.dart';
import 'package:career_portal/core/network/app_exception.dart';
import 'package:career_portal/core/network/app_service.dart';
import 'package:career_portal/features/dashboard/data/dto/apply_job_response_dto.dart';
import 'package:career_portal/features/dashboard/data/dto/job_posting_detail_response_dto.dart';
import 'package:career_portal/features/dashboard/data/dto/job_postings_response_dto.dart';
import 'package:career_portal/features/dashboard/data/mappers/apply_job_multipart_mapper.dart';
import 'package:career_portal/features/dashboard/data/mappers/job_posting_mapper.dart';
import 'package:career_portal/features/dashboard/domain/models/apply_job_input.dart';
import 'package:career_portal/features/dashboard/domain/models/dashboard_job.dart';
import 'package:career_portal/features/dashboard/domain/models/job_postings_page.dart';

class JobPostingsRemoteDataSource {
  const JobPostingsRemoteDataSource(this._appService);

  final AppService _appService;

  Future<JobPostingsPage> getJobPostings({
    required int enterpriseId,
    required int page,
    required int pageSize,
    String? search,
  }) async {
    try {
      final queryParameters = <String, dynamic>{
        'enterprise_id': enterpriseId,
        'page': page,
        'page_size': pageSize,
      };
      final trimmedSearch = search?.trim();
      if (trimmedSearch != null && trimmedSearch.isNotEmpty) {
        queryParameters['search'] = trimmedSearch;
      }

      final response = await _appService.get<Map<String, dynamic>>(
        RecEndpoints.jobPostings(),
        queryParameters: queryParameters,
        parser: (data) {
          if (data is Map<String, dynamic>) return data;
          throw AppException(message: 'Invalid job postings response.');
        },
      );

      final dto = JobPostingsResponseDto.fromJson(response);
      if (!dto.success) {
        throw AppException(
          message: dto.message ?? 'Failed to fetch job postings.',
        );
      }

      final pagination = dto.pagination;
      if (pagination == null) {
        throw AppException(
          message: 'Job postings pagination metadata missing.',
        );
      }

      return JobPostingMapper.toPage(dtos: dto.jobs, pagination: pagination);
    } on AppException {
      rethrow;
    } catch (error) {
      throw AppException(
        message: 'Failed to fetch job postings.',
        details: error,
      );
    }
  }

  Future<DashboardJob> getJobPosting({
    required String postingGuid,
    required int enterpriseId,
  }) async {
    try {
      final response = await _appService.get<Map<String, dynamic>>(
        RecEndpoints.jobPosting(postingGuid),
        queryParameters: {'enterprise_id': enterpriseId},
        parser: (data) {
          if (data is Map<String, dynamic>) return data;
          throw AppException(message: 'Invalid job posting response.');
        },
      );

      final dto = JobPostingDetailResponseDto.fromJson(response);
      if (!dto.success) {
        throw AppException(
          message: dto.message ?? 'Failed to fetch job posting.',
        );
      }

      final job = dto.job;
      if (job == null) {
        throw AppException(message: 'Job posting data missing.');
      }

      return JobPostingMapper.toDomain(job);
    } on AppException {
      rethrow;
    } catch (error) {
      throw AppException(
        message: 'Failed to fetch job posting.',
        details: error,
      );
    }
  }

  Future<void> applyForJob(ApplyJobInput input) async {
    try {
      final formData = ApplyJobMultipartMapper.toFormData(input);
      final response = await _appService.postMultipart<Map<String, dynamic>>(
        RecEndpoints.applyJobPosting(input.postingGuid),
        data: formData,
        parser: (data) {
          if (data is Map<String, dynamic>) return data;
          throw AppException(message: 'Invalid job application response.');
        },
      );

      final dto = ApplyJobResponseDto.fromJson(response);
      if (!dto.success) {
        throw AppException(
          message: dto.message ?? 'Failed to submit job application.',
        );
      }
    } on AppException {
      rethrow;
    } catch (error) {
      throw AppException(
        message: 'Failed to submit job application.',
        details: error,
      );
    }
  }
}
