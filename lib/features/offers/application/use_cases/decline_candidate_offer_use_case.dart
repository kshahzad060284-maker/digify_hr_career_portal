import 'package:career_portal/features/offers/domain/repositories/candidate_offers_repository.dart';

class DeclineCandidateOfferUseCase {
  const DeclineCandidateOfferUseCase(this._repository);

  final CandidateOffersRepository _repository;

  Future<void> call({
    required String offerGuid,
    required String declineComments,
  }) {
    return _repository.declineOffer(
      offerGuid: offerGuid,
      declineComments: declineComments,
    );
  }
}
