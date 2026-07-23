import 'package:career_portal/core/enterprise/enterprise_id_provider.dart';
import 'package:career_portal/core/network/app_exception.dart';
import 'package:career_portal/features/applications/domain/config/applications_config.dart';
import 'package:career_portal/features/applications/domain/models/candidate_applications_page.dart';
import 'package:career_portal/features/applications/presentation/providers/candidate_applications_di_provider.dart';
import 'package:career_portal/features/applications/presentation/state/candidate_applications_state.dart';
import 'package:career_portal/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CandidateApplicationsController
    extends AutoDisposeAsyncNotifier<CandidateApplicationsState> {
  @override
  Future<CandidateApplicationsState> build() async {
    ref.watch(enterpriseIdProvider);
    return _loadPage(1);
  }

  Future<void> refresh() => _reloadFromFirstPage();

  Future<void> goToPage(int page) async {
    final safePage = page < 1 ? 1 : page;
    state = const AsyncLoading<CandidateApplicationsState>().copyWithPrevious(
      state,
    );
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
    state = const AsyncLoading<CandidateApplicationsState>();
    state = await AsyncValue.guard(() => _loadPage(1));
  }

  Future<CandidateApplicationsState> _loadPage(int page) async {
    final candidateGuid = ref.read(authSessionProvider).session?.candidateGuid;
    if (candidateGuid == null || candidateGuid.isEmpty) {
      throw AppException(
        message: 'Candidate session required to load applications.',
      );
    }

    final useCase = ref.read(getCandidateApplicationsUseCaseProvider);
    final pageResult = await useCase(
      enterpriseId: ref.read(enterpriseIdProvider),
      candidateGuid: candidateGuid,
      page: page,
      pageSize: ApplicationsConfig.defaultPageSize,
    );

    return _mapToState(pageResult);
  }

  CandidateApplicationsState _mapToState(CandidateApplicationsPage page) {
    return CandidateApplicationsState(
      applications: page.applications,
      pagination: page.pagination,
      currentPage: page.currentPage,
      pageSize: page.pageSize,
    );
  }
}
