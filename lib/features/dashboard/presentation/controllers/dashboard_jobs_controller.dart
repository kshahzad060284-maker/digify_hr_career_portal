import 'dart:async' show unawaited;

import 'package:career_portal/core/utils/debouncer.dart';
import 'package:career_portal/features/dashboard/domain/config/dashboard_jobs_config.dart';
import 'package:career_portal/features/dashboard/domain/models/job_postings_page.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_jobs_di_provider.dart';
import 'package:career_portal/features/dashboard/presentation/state/dashboard_jobs_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardJobsController extends AsyncNotifier<DashboardJobsState> {
  static const _debounceDuration = Duration(milliseconds: 400);

  late final Debouncer _debouncer;
  String _searchQuery = '';

  @override
  Future<DashboardJobsState> build() async {
    _debouncer = Debouncer(duration: _debounceDuration);
    ref.onDispose(_debouncer.dispose);
    return _loadPage(1);
  }

  void onSearchChanged(String value) {
    _debouncer.run(() {
      _searchQuery = value.trim();
      unawaited(_reloadFromFirstPage());
    });
  }

  void onSearchSubmitted(String value) {
    _debouncer.cancel();
    _searchQuery = value.trim();
    unawaited(_reloadFromFirstPage());
  }

  Future<void> ensureLoaded() async {
    if (state.isLoading) return;
    if (state.hasValue) return;
    await _reloadFromFirstPage();
  }

  Future<void> refresh() => _reloadFromFirstPage();

  Future<void> goToPage(int page) async {
    final safePage = page < 1 ? 1 : page;
    state = const AsyncLoading<DashboardJobsState>().copyWithPrevious(state);
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
    state = const AsyncLoading<DashboardJobsState>().copyWithPrevious(state);
    state = await AsyncValue.guard(() => _loadPage(1));
  }

  Future<DashboardJobsState> _loadPage(int page) async {
    final useCase = ref.read(getJobPostingsUseCaseProvider);
    final pageResult = await useCase(
      enterpriseId: DashboardJobsConfig.defaultEnterpriseId,
      page: page,
      pageSize: DashboardJobsConfig.defaultPageSize,
      search: _searchQuery.isEmpty ? null : _searchQuery,
    );
    return _mapToState(pageResult);
  }

  DashboardJobsState _mapToState(JobPostingsPage page) {
    return DashboardJobsState(
      jobs: page.jobs,
      pagination: page.pagination,
      currentPage: page.currentPage,
      pageSize: page.pageSize,
      search: _searchQuery,
    );
  }
}
