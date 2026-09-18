import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardJobDetailViewState {
  const DashboardJobDetailViewState({this.showBackToTop = false});

  final bool showBackToTop;
}

class DashboardJobDetailViewController
    extends AutoDisposeNotifier<DashboardJobDetailViewState> {
  static const backToTopOffset = 420.0;

  @override
  DashboardJobDetailViewState build() => const DashboardJobDetailViewState();

  void updateScrollOffset(double offset) {
    final showBackToTop = offset > backToTopOffset;
    if (showBackToTop == state.showBackToTop) {
      return;
    }
    state = DashboardJobDetailViewState(showBackToTop: showBackToTop);
  }
}

final dashboardJobDetailViewProvider =
    AutoDisposeNotifierProvider<
      DashboardJobDetailViewController,
      DashboardJobDetailViewState
    >(DashboardJobDetailViewController.new);
