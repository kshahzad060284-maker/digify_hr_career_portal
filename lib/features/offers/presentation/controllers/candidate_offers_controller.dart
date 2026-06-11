import 'package:career_portal/core/network/app_exception.dart';
import 'package:career_portal/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:career_portal/features/offers/domain/config/offers_config.dart';
import 'package:career_portal/features/offers/domain/models/candidate_offers_page.dart';
import 'package:career_portal/features/offers/presentation/providers/candidate_offers_di_provider.dart';
import 'package:career_portal/features/offers/presentation/state/candidate_offers_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CandidateOffersController
    extends AutoDisposeAsyncNotifier<CandidateOffersState> {
  @override
  Future<CandidateOffersState> build() async {
    ref.listen(authSessionProvider, (previous, next) {
      final previousGuid = previous?.session?.candidateGuid;
      final nextGuid = next.session?.candidateGuid;
      if (previousGuid != nextGuid) {
        ref.invalidateSelf();
      }
    });

    return _loadPage(1);
  }

  Future<void> refresh() => _reloadFromFirstPage();

  Future<void> goToPage(int page) async {
    final safePage = page < 1 ? 1 : page;
    state = const AsyncLoading<CandidateOffersState>().copyWithPrevious(state);
    state = await AsyncValue.guard(() => _loadPage(safePage));
  }

  Future<void> goToPreviousPage() async {
    final current = state.value;
    if (current == null || !current.pagination.hasPrevious) return;
    await goToPage(current.currentPage - 1);
  }

  Future<void> goToNextPage() async {
    final current = state.value;
    if (current == null || !current.pagination.hasNext) return;
    await goToPage(current.currentPage + 1);
  }

  Future<void> _reloadFromFirstPage() async {
    state = const AsyncLoading<CandidateOffersState>().copyWithPrevious(state);
    state = await AsyncValue.guard(() => _loadPage(1));
  }

  Future<CandidateOffersState> _loadPage(int page) async {
    final candidateGuid = ref.read(authSessionProvider).session?.candidateGuid;
    if (candidateGuid == null || candidateGuid.isEmpty) {
      throw AppException(message: 'Candidate session required to load offers.');
    }

    final useCase = ref.read(getCandidateOffersUseCaseProvider);
    final pageResult = await useCase(
      enterpriseId: OffersConfig.defaultEnterpriseId,
      candidateGuid: candidateGuid,
      page: page,
      pageSize: OffersConfig.defaultPageSize,
    );

    return _mapToState(pageResult);
  }

  CandidateOffersState _mapToState(CandidateOffersPage page) {
    return CandidateOffersState(
      offers: page.offers,
      pagination: page.pagination,
      currentPage: page.currentPage,
      pageSize: page.pageSize,
    );
  }

  Future<void> acceptOffer(String offerGuid) async {
    final current = state.value;
    if (current == null || current.isProcessing(offerGuid)) return;

    state = AsyncData(
      current.copyWith(
        processingOfferGuid: offerGuid,
        processingAction: CandidateOfferProcessingAction.accept,
      ),
    );

    try {
      await ref
          .read(acceptCandidateOfferUseCaseProvider)
          .call(offerGuid: offerGuid);
      await _reloadFromFirstPage();
    } catch (error) {
      _clearProcessing();
      rethrow;
    }
  }

  Future<void> declineOffer({
    required String offerGuid,
    required String declineComments,
  }) async {
    final current = state.value;
    if (current == null || current.isProcessing(offerGuid)) return;

    state = AsyncData(
      current.copyWith(
        processingOfferGuid: offerGuid,
        processingAction: CandidateOfferProcessingAction.decline,
      ),
    );

    try {
      await ref
          .read(declineCandidateOfferUseCaseProvider)
          .call(offerGuid: offerGuid, declineComments: declineComments);
      await _reloadFromFirstPage();
    } catch (error) {
      _clearProcessing();
      rethrow;
    }
  }

  void _clearProcessing() {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(current.copyWith(clearProcessing: true));
  }
}
