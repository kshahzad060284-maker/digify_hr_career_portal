import 'package:career_portal/core/domain/models/pagination_info.dart';
import 'package:career_portal/features/offers/domain/models/candidate_offer.dart';

enum CandidateOfferProcessingAction { accept, decline }

sealed class CandidateOfferActionResult {
  const CandidateOfferActionResult();
}

final class CandidateOfferActionSuccess extends CandidateOfferActionResult {
  const CandidateOfferActionSuccess(this.action);

  final CandidateOfferProcessingAction action;
}

final class CandidateOfferActionFailure extends CandidateOfferActionResult {
  const CandidateOfferActionFailure({required this.action, this.message});

  final CandidateOfferProcessingAction action;
  final String? message;
}

class CandidateOffersState {
  const CandidateOffersState({
    required this.offers,
    required this.pagination,
    required this.currentPage,
    required this.pageSize,
    this.processingOfferGuid,
    this.processingAction,
  });

  final List<CandidateOffer> offers;
  final PaginationInfo pagination;
  final int currentPage;
  final int pageSize;
  final String? processingOfferGuid;
  final CandidateOfferProcessingAction? processingAction;

  bool isProcessing(String offerGuid) => processingOfferGuid == offerGuid;

  bool isAccepting(String offerGuid) =>
      isProcessing(offerGuid) &&
      processingAction == CandidateOfferProcessingAction.accept;

  bool isDeclining(String offerGuid) =>
      isProcessing(offerGuid) &&
      processingAction == CandidateOfferProcessingAction.decline;

  CandidateOffersState copyWith({
    List<CandidateOffer>? offers,
    PaginationInfo? pagination,
    int? currentPage,
    int? pageSize,
    String? processingOfferGuid,
    CandidateOfferProcessingAction? processingAction,
    bool clearProcessing = false,
  }) {
    return CandidateOffersState(
      offers: offers ?? this.offers,
      pagination: pagination ?? this.pagination,
      currentPage: currentPage ?? this.currentPage,
      pageSize: pageSize ?? this.pageSize,
      processingOfferGuid: clearProcessing
          ? null
          : (processingOfferGuid ?? this.processingOfferGuid),
      processingAction: clearProcessing
          ? null
          : (processingAction ?? this.processingAction),
    );
  }

  static const empty = CandidateOffersState(
    offers: [],
    pagination: PaginationInfo(
      totalPages: 1,
      totalItems: 0,
      hasNext: false,
      hasPrevious: false,
    ),
    currentPage: 1,
    pageSize: 10,
  );
}
