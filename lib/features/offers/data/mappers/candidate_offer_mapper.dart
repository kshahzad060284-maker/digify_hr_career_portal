import 'package:career_portal/core/domain/models/pagination_info.dart';
import 'package:career_portal/features/offers/data/dto/candidate_offer_dto.dart';
import 'package:career_portal/features/offers/data/dto/candidate_offers_pagination_dto.dart';
import 'package:career_portal/features/offers/domain/models/candidate_offer.dart';
import 'package:career_portal/features/offers/domain/models/candidate_offers_page.dart';
import 'package:intl/intl.dart';

class CandidateOfferMapper {
  const CandidateOfferMapper._();

  static CandidateOffer toDomain(CandidateOfferDto dto) {
    return CandidateOffer(
      offerGuid: dto.offerGuid,
      offerNumber: _orMissing(dto.offerNumber),
      jobTitle: _orMissing(dto.jobTitle),
      postingTitle: dto.postingTitle.trim(),
      department: dto.departmentName.trim(),
      location: _orMissing(dto.location),
      workMode: _orMissing(_formatCodeLabel(dto.workModeCode)),
      employmentType: _orMissing(
        _formatEmploymentLabel(dto.employmentTypeCode, dto.workModeCode),
      ),
      salary: _formatSalary(
        amount: dto.componentAmount ?? dto.annualSalary,
        currencyCode: dto.currencyCode,
        frequencyCode: dto.frequencyCode,
      ),
      status: _mapStatus(dto.statusCode),
      statusCode: _orMissing(dto.statusCode),
      stage: _orMissing(dto.stage),
      stageDescription: _orMissing(dto.stageDescription),
      sentDate: _parseDate(dto.offerDate),
      expiryDate: _parseDate(dto.expiryDate),
      startDate: _parseDate(dto.startDate),
    );
  }

  static CandidateOffersPage toPage({
    required List<CandidateOfferDto> dtos,
    required CandidateOffersPaginationDto pagination,
  }) {
    final offers = dtos.map(toDomain).toList(growable: false);

    return CandidateOffersPage(
      offers: offers,
      pagination: PaginationInfo.fromTotals(
        totalItems: pagination.total,
        pageSize: pagination.limit,
        currentPage: pagination.page,
      ),
      currentPage: pagination.page,
      pageSize: pagination.limit,
    );
  }

  static CandidateOfferStatus _mapStatus(String statusCode) {
    switch (statusCode.toUpperCase()) {
      case 'ACCEPTED':
        return CandidateOfferStatus.accepted;
      case 'DECLINED':
      case 'REJECTED':
        return CandidateOfferStatus.declined;
      case 'EXPIRED':
        return CandidateOfferStatus.expired;
      case 'EXTENDED':
      case 'PENDING':
      default:
        return CandidateOfferStatus.pending;
    }
  }

  static String _formatSalary({
    required double? amount,
    required String currencyCode,
    required String frequencyCode,
  }) {
    if (amount == null) return CandidateOffer.missingValue;

    final frequency = _formatCodeLabel(frequencyCode);
    final parts = <String>[
      if (currencyCode.trim().isNotEmpty) currencyCode.trim(),
      NumberFormat.decimalPattern().format(amount),
      if (frequency.isNotEmpty) frequency,
    ];
    return parts.join(' ');
  }

  static String _formatEmploymentLabel(String employmentCode, String workMode) {
    final employment = _formatCodeLabel(employmentCode);
    final mode = _formatCodeLabel(workMode);
    if (employment.isEmpty) return mode;
    if (mode.isEmpty) return employment;
    return '$employment · $mode';
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

  static String _orMissing(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? CandidateOffer.missingValue : trimmed;
  }

  static DateTime? _parseDate(String value) {
    if (value.trim().isEmpty) return null;
    return DateTime.tryParse(value);
  }
}
