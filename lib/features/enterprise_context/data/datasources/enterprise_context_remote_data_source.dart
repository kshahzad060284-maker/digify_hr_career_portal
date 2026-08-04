import 'package:career_portal/core/network/api_endpoints.dart';
import 'package:career_portal/core/network/app_exception.dart';
import 'package:career_portal/core/network/app_service.dart';
import 'package:career_portal/features/enterprise_context/data/dto/enterprise_context_dto.dart';

abstract class EnterpriseContextRemoteDataSource {
  Future<EnterpriseContextDto> getEnterpriseContext();
}

class EnterpriseContextRemoteDataSourceImpl
    implements EnterpriseContextRemoteDataSource {
  const EnterpriseContextRemoteDataSourceImpl({required AppService appService})
    : _appService = appService;

  final AppService _appService;

  @override
  Future<EnterpriseContextDto> getEnterpriseContext() async {
    try {
      final response = await _appService.get<Map<String, dynamic>>(
        ApiEndpoints.publicEnterpriseContext,
        parser: (data) {
          if (data is! Map<String, dynamic>) {
            throw AppException(
              message: 'Invalid enterprise context response',
              statusCode: 500,
            );
          }
          return data;
        },
      );

      final status = response['status'] as String?;
      if (status != 'S') {
        throw AppException(
          message:
              response['message'] as String? ??
              'Failed to resolve enterprise context',
          statusCode: 400,
        );
      }

      final data = response['data'];
      if (data is! Map<String, dynamic>) {
        throw AppException(
          message: 'Invalid enterprise context response',
          statusCode: 500,
        );
      }

      return EnterpriseContextDto.fromJson(data);
    } on AppException {
      rethrow;
    } catch (e) {
      throw AppException(
        message: 'Failed to resolve enterprise context: $e',
        details: e,
      );
    }
  }
}
