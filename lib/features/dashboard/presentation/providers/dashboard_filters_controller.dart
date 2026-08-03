import 'package:career_portal/features/dashboard/presentation/providers/dashboard_filters_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardFiltersController extends Notifier<DashboardFiltersState> {
  @override
  DashboardFiltersState build() => const DashboardFiltersState();

  void onLocationChanged(String? value) {
    state = state.copyWith(selectedLocation: value);
  }

  void onDepartmentChanged(String? value) {
    state = state.copyWith(selectedDepartment: value);
  }

  void onEmploymentTypeChanged(String? value) {
    state = state.copyWith(selectedEmploymentType: value);
  }
}

final dashboardFiltersControllerProvider =
    NotifierProvider<DashboardFiltersController, DashboardFiltersState>(
      DashboardFiltersController.new,
    );
