import 'package:career_portal/features/offers/domain/repositories/candidate_offers_repository.dart';

class AcceptCandidateOfferUseCase {
  const AcceptCandidateOfferUseCase(this._repository);

  final CandidateOffersRepository _repository;

  Future<void> call({required String offerGuid}) {
    return _repository.acceptOffer(offerGuid: offerGuid);
  }
}
