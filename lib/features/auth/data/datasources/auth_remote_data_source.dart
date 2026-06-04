import 'package:career_portal/core/network/api_endpoints.dart';
import 'package:career_portal/core/network/app_exception.dart';
import 'package:career_portal/core/network/app_service.dart';
import 'package:career_portal/features/auth/data/dto/login_response_dto.dart';
import 'package:career_portal/features/auth/data/dto/register_response_dto.dart';
import 'package:career_portal/features/auth/data/mappers/candidate_session_mapper.dart';
import 'package:career_portal/features/auth/data/mappers/register_candidate_result_mapper.dart';
import 'package:career_portal/features/auth/data/mappers/register_multipart_mapper.dart';
import 'package:career_portal/features/auth/domain/models/candidate_session.dart';
import 'package:career_portal/features/auth/domain/models/register_candidate_input.dart';
import 'package:career_portal/features/auth/domain/models/register_candidate_result.dart';

class AuthRemoteDataSource {
  const AuthRemoteDataSource(this._appService);

  final AppService _appService;

  Future<CandidateSession> login({
    required int enterpriseId,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _appService.post<Map<String, dynamic>>(
        CandidateAuthEndpoints.login(),
        data: <String, dynamic>{
          'enterprise_id': enterpriseId,
          'email': email,
          'password': password,
        },
        parser: (data) {
          if (data is Map<String, dynamic>) return data;
          throw AppException(message: 'Invalid login response.');
        },
      );

      final dto = LoginResponseDto.fromJson(response);
      if (!dto.success) {
        throw AppException(message: dto.message ?? 'Login failed.');
      }

      final user = dto.user;
      if (user == null || user.candidateUserGuid.isEmpty) {
        throw AppException(message: 'Login response data missing.');
      }

      return CandidateSessionMapper.toDomain(user);
    } on AppException {
      rethrow;
    } catch (error) {
      throw AppException(message: 'Login failed.', details: error);
    }
  }

  Future<RegisterCandidateResult> registerCandidate(
    RegisterCandidateInput input,
  ) async {
    try {
      final formData = RegisterMultipartMapper.toFormData(input);
      final response = await _appService.postMultipart<Map<String, dynamic>>(
        CandidateAuthEndpoints.register(),
        data: formData,
        parser: (data) {
          if (data is Map<String, dynamic>) return data;
          throw AppException(message: 'Invalid registration response.');
        },
      );

      final dto = RegisterResponseDto.fromJson(response);
      if (!dto.success) {
        throw AppException(message: dto.message ?? 'Registration failed.');
      }

      final result = RegisterCandidateResultMapper.toDomain(dto);
      if (result.candidateUserGuid.isEmpty) {
        throw AppException(message: 'Registration response data missing.');
      }

      return result;
    } on AppException {
      rethrow;
    } catch (error) {
      throw AppException(message: 'Registration failed.', details: error);
    }
  }
}
