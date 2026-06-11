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
      offerNumber: dto.offerNumber,
      jobTitle: dto.jobTitle,
      postingTitle: dto.postingTitle,
      department: dto.departmentName,
      location: dto.location,
      workMode: _formatCodeLabel(dto.workModeCode),
      employmentType: _formatEmploymentLabel(
        dto.employmentTypeCode,
        dto.workModeCode,
      ),
      salary: _formatSalary(dto.annualSalary, dto.currencyCode),
      status: _mapStatus(dto.statusCode),
      statusCode: dto.statusCode,
      stage: dto.stage,
      stageDescription: dto.stageDescription,
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

  static String _formatSalary(double? annualSalary, String currencyCode) {
    if (annualSalary == null || annualSalary <= 0) return '';
    final currency = currencyCode.trim().isEmpty ? 'USD' : currencyCode.trim();
    final formatted = NumberFormat.decimalPattern().format(annualSalary);
    return '$currency $formatted / year';
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

  static DateTime? _parseDate(String value) {
    if (value.trim().isEmpty) return null;
    return DateTime.tryParse(value);
  }
}
