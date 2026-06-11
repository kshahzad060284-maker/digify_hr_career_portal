import 'package:career_portal/features/offers/data/datasources/candidate_offers_remote_data_source.dart';
import 'package:career_portal/features/offers/domain/models/candidate_offers_page.dart';
import 'package:career_portal/features/offers/domain/repositories/candidate_offers_repository.dart';

class CandidateOffersRepositoryImpl implements CandidateOffersRepository {
  const CandidateOffersRepositoryImpl(this._remoteDataSource);

  final CandidateOffersRemoteDataSource _remoteDataSource;

  @override
  Future<CandidateOffersPage> getCandidateOffers({
    required int enterpriseId,
    required String candidateGuid,
    required int page,
    required int pageSize,
  }) {
    return _remoteDataSource.getCandidateOffers(
      enterpriseId: enterpriseId,
      candidateGuid: candidateGuid,
      page: page,
      pageSize: pageSize,
    );
  }

  @override
  Future<void> acceptOffer({required String offerGuid}) {
    return _remoteDataSource.acceptOffer(offerGuid: offerGuid);
  }

  @override
  Future<void> declineOffer({
    required String offerGuid,
    required String declineComments,
  }) {
    return _remoteDataSource.declineOffer(
      offerGuid: offerGuid,
      declineComments: declineComments,
    );
  }
}
