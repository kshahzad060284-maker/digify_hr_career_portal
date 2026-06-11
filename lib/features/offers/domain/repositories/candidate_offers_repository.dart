import 'package:career_portal/features/offers/domain/models/candidate_offers_page.dart';

abstract interface class CandidateOffersRepository {
  Future<CandidateOffersPage> getCandidateOffers({
    required int enterpriseId,
    required String candidateGuid,
    required int page,
    required int pageSize,
  });

  Future<void> acceptOffer({required String offerGuid});

  Future<void> declineOffer({
    required String offerGuid,
    required String declineComments,
  });
}
