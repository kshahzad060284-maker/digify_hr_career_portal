import 'package:career_portal/core/utils/debouncer.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_job_search_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardJobSearchController extends Notifier<DashboardJobSearchState> {
  static const _debounceDuration = Duration(milliseconds: 400);

  late final Debouncer _debouncer;

  @override
  DashboardJobSearchState build() {
    _debouncer = Debouncer(duration: _debounceDuration);
    ref.onDispose(_debouncer.dispose);
    return const DashboardJobSearchState();
  }

  void onSearchChanged(String value) {
    state = state.copyWith(query: value);
    _debouncer.run(() {
      state = state.copyWith(debouncedQuery: value.trim());
    });
  }

  void onSearchSubmitted(String value) {
    _debouncer.cancel();
    final trimmed = value.trim();
    state = state.copyWith(query: value, debouncedQuery: trimmed);
  }

  void clearSearch() {
    _debouncer.cancel();
    state = const DashboardJobSearchState();
  }
}

final dashboardJobSearchControllerProvider =
    NotifierProvider<DashboardJobSearchController, DashboardJobSearchState>(
      DashboardJobSearchController.new,
    );
