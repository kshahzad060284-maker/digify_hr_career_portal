import 'package:career_portal/core/network/api_endpoints.dart';
import 'package:career_portal/core/network/app_exception.dart';
import 'package:career_portal/core/network/app_service.dart';
import 'package:career_portal/features/offers/data/dto/candidate_offers_response_dto.dart';
import 'package:career_portal/features/offers/data/dto/offer_action_response_dto.dart';
import 'package:career_portal/features/offers/domain/config/offers_config.dart';
import 'package:career_portal/features/offers/data/mappers/candidate_offer_mapper.dart';
import 'package:career_portal/features/offers/domain/models/candidate_offers_page.dart';

class CandidateOffersRemoteDataSource {
  const CandidateOffersRemoteDataSource(this._appService);

  final AppService _appService;

  Future<CandidateOffersPage> getCandidateOffers({
    required int enterpriseId,
    required String candidateGuid,
    required int page,
    required int pageSize,
  }) async {
    try {
      final response = await _appService.get<Map<String, dynamic>>(
        CandidateEndpoints.offers(),
        queryParameters: <String, dynamic>{
          'enterprise_id': enterpriseId,
          'candidate_guid': candidateGuid,
          'page': page,
          'limit': pageSize,
        },
        parser: (data) {
          if (data is Map<String, dynamic>) return data;
          throw AppException(message: 'Invalid candidate offers response.');
        },
      );

      final dto = CandidateOffersResponseDto.fromJson(response);
      if (!dto.success) {
        throw AppException(
          message: dto.message ?? 'Failed to fetch candidate offers.',
        );
      }

      final pagination = dto.pagination;
      if (pagination == null) {
        throw AppException(
          message: 'Candidate offers pagination metadata missing.',
        );
      }

      return CandidateOfferMapper.toPage(
        dtos: dto.offers,
        pagination: pagination,
      );
    } on AppException {
      rethrow;
    } catch (error) {
      throw AppException(
        message: 'Failed to fetch candidate offers.',
        details: error,
      );
    }
  }

  Future<void> acceptOffer({required String offerGuid}) async {
    try {
      final response = await _appService.post<Map<String, dynamic>>(
        RecEndpoints.acceptJobOffer(offerGuid),
        data: <String, dynamic>{'updated_by': OffersConfig.updatedBy},
        parser: (data) {
          if (data is Map<String, dynamic>) return data;
          throw AppException(message: 'Invalid accept offer response.');
        },
      );

      final dto = OfferActionResponseDto.fromJson(response);
      if (!dto.success) {
        throw AppException(message: dto.message ?? 'Failed to accept offer.');
      }
    } on AppException {
      rethrow;
    } catch (error) {
      throw AppException(message: 'Failed to accept offer.', details: error);
    }
  }

  Future<void> declineOffer({
    required String offerGuid,
    required String declineComments,
  }) async {
    try {
      final response = await _appService.post<Map<String, dynamic>>(
        RecEndpoints.declineJobOffer(offerGuid),
        data: <String, dynamic>{
          'decline_comments': declineComments,
          'updated_by': OffersConfig.updatedBy,
        },
        parser: (data) {
          if (data is Map<String, dynamic>) return data;
          throw AppException(message: 'Invalid decline offer response.');
        },
      );

      final dto = OfferActionResponseDto.fromJson(response);
      if (!dto.success) {
        throw AppException(message: dto.message ?? 'Failed to decline offer.');
      }
    } on AppException {
      rethrow;
    } catch (error) {
      throw AppException(message: 'Failed to decline offer.', details: error);
    }
  }
}
