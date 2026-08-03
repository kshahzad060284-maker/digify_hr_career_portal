import 'package:career_portal/features/dashboard/presentation/providers/dashboard_filters_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardFiltersController extends Notifier<DashboardFiltersState> {
  @override
  DashboardFiltersState build() => const DashboardFiltersState();

  void onLocationChanged(String? value) {
    state = _isAll(value, DashboardFiltersState.allLocationsKey)
        ? state.copyWith(clearLocation: true)
        : state.copyWith(selectedLocation: value);
  }

  void onDepartmentChanged(String? value) {
    state = _isAll(value, DashboardFiltersState.allDepartmentsKey)
        ? state.copyWith(clearDepartment: true)
        : state.copyWith(selectedDepartment: value);
  }

  void onEmploymentTypeChanged(String? value) {
    state = _isAll(value, DashboardFiltersState.allEmploymentTypesKey)
        ? state.copyWith(clearEmploymentType: true)
        : state.copyWith(selectedEmploymentType: value);
  }

  void clear(DashboardFilterType type) {
    state = switch (type) {
      DashboardFilterType.location => state.copyWith(clearLocation: true),
      DashboardFilterType.department => state.copyWith(clearDepartment: true),
      DashboardFilterType.employmentType => state.copyWith(
        clearEmploymentType: true,
      ),
    };
  }

  void clearAll() {
    state = const DashboardFiltersState();
  }

  bool _isAll(String? value, String allKey) => value == null || value == allKey;
}

final dashboardFiltersControllerProvider =
    NotifierProvider<DashboardFiltersController, DashboardFiltersState>(
      DashboardFiltersController.new,
    );
