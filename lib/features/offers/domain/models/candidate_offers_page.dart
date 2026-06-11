import 'package:career_portal/core/domain/models/pagination_info.dart';
import 'package:career_portal/features/offers/domain/models/candidate_offer.dart';

class CandidateOffersPage {
  const CandidateOffersPage({
    required this.offers,
    required this.pagination,
    required this.currentPage,
    required this.pageSize,
  });

  final List<CandidateOffer> offers;
  final PaginationInfo pagination;
  final int currentPage;
  final int pageSize;
}
