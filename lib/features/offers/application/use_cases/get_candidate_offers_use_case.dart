import 'package:career_portal/features/offers/domain/models/candidate_offers_page.dart';
import 'package:career_portal/features/offers/domain/repositories/candidate_offers_repository.dart';

class GetCandidateOffersUseCase {
  const GetCandidateOffersUseCase(this._repository);

  final CandidateOffersRepository _repository;

  Future<CandidateOffersPage> call({
    required int enterpriseId,
    required String candidateGuid,
    required int page,
    required int pageSize,
  }) {
    return _repository.getCandidateOffers(
      enterpriseId: enterpriseId,
      candidateGuid: candidateGuid,
      page: page,
      pageSize: pageSize,
    );
  }
}
