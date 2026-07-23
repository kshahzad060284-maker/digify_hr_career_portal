import 'package:career_portal/core/network/api_endpoints.dart';
import 'package:career_portal/core/network/app_exception.dart';
import 'package:career_portal/core/network/app_service.dart';
import 'package:career_portal/features/applications/data/dto/candidate_applications_response_dto.dart';
import 'package:career_portal/features/applications/data/mappers/candidate_application_mapper.dart';
import 'package:career_portal/features/applications/domain/models/candidate_applications_page.dart';

class CandidateApplicationsRemoteDataSource {
  const CandidateApplicationsRemoteDataSource(this._appService);

  final AppService _appService;

  Future<CandidateApplicationsPage> getCandidateApplications({
    required int enterpriseId,
    required String candidateGuid,
    required int page,
    required int pageSize,
  }) async {
    try {
      final response = await _appService.get<Map<String, dynamic>>(
        RecruitmentEndpoints.applications(),
        queryParameters: <String, dynamic>{
          'enterprise_id': enterpriseId,
          'candidate_guid': candidateGuid,
          'page': page,
          'limit': pageSize,
        },
        parser: (data) {
          if (data is Map<String, dynamic>) return data;
          throw AppException(message: 'Invalid applications response.');
        },
      );

      final dto = CandidateApplicationsResponseDto.fromJson(response);
      if (!dto.success) {
        throw AppException(
          message: dto.message ?? 'Failed to fetch applications.',
        );
      }

      final pagination = dto.pagination;
      if (pagination == null) {
        throw AppException(
          message: 'Applications pagination metadata missing.',
        );
      }

      return CandidateApplicationMapper.toPage(
        dtos: dto.applications,
        pagination: pagination,
      );
    } on AppException {
      rethrow;
    } catch (error) {
      throw AppException(
        message: 'Failed to fetch applications.',
        details: error,
      );
    }
  }
}
