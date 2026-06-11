import 'package:career_portal/core/providers/app_service_provider.dart';
import 'package:career_portal/features/offers/application/use_cases/accept_candidate_offer_use_case.dart';
import 'package:career_portal/features/offers/application/use_cases/decline_candidate_offer_use_case.dart';
import 'package:career_portal/features/offers/application/use_cases/get_candidate_offers_use_case.dart';
import 'package:career_portal/features/offers/data/datasources/candidate_offers_remote_data_source.dart';
import 'package:career_portal/features/offers/data/repositories/candidate_offers_repository_impl.dart';
import 'package:career_portal/features/offers/domain/repositories/candidate_offers_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final candidateOffersRemoteDataSourceProvider =
    Provider<CandidateOffersRemoteDataSource>((ref) {
      return CandidateOffersRemoteDataSource(ref.watch(appServiceProvider));
    });

final candidateOffersRepositoryProvider = Provider<CandidateOffersRepository>((
  ref,
) {
  return CandidateOffersRepositoryImpl(
    ref.watch(candidateOffersRemoteDataSourceProvider),
  );
});

final getCandidateOffersUseCaseProvider = Provider<GetCandidateOffersUseCase>((
  ref,
) {
  return GetCandidateOffersUseCase(
    ref.watch(candidateOffersRepositoryProvider),
  );
});

final acceptCandidateOfferUseCaseProvider =
    Provider<AcceptCandidateOfferUseCase>((ref) {
      return AcceptCandidateOfferUseCase(
        ref.watch(candidateOffersRepositoryProvider),
      );
    });

final declineCandidateOfferUseCaseProvider =
    Provider<DeclineCandidateOfferUseCase>((ref) {
      return DeclineCandidateOfferUseCase(
        ref.watch(candidateOffersRepositoryProvider),
      );
    });
