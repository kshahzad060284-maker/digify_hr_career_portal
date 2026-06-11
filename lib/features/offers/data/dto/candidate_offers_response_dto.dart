import 'package:career_portal/features/offers/data/dto/candidate_offer_dto.dart';
import 'package:career_portal/features/offers/data/dto/candidate_offers_pagination_dto.dart';

class CandidateOffersResponseDto {
  const CandidateOffersResponseDto({
    required this.success,
    required this.offers,
    this.pagination,
    this.message,
  });

  final bool success;
  final String? message;
  final CandidateOffersPaginationDto? pagination;
  final List<CandidateOfferDto> offers;

  factory CandidateOffersResponseDto.fromJson(Map<String, dynamic> json) {
    final paginationJson = json['pagination'];
    CandidateOffersPaginationDto? pagination;
    if (paginationJson is Map<String, dynamic>) {
      pagination = CandidateOffersPaginationDto.fromJson(paginationJson);
    }

    final data = json['data'];
    final offers = data is List
        ? data
              .whereType<Map<String, dynamic>>()
              .map(CandidateOfferDto.fromJson)
              .toList()
        : <CandidateOfferDto>[];

    return CandidateOffersResponseDto(
      success: json['success'] == true,
      message: json['message']?.toString(),
      pagination: pagination,
      offers: offers,
    );
  }
}
