class DashboardFiltersState {
  const DashboardFiltersState({
    this.selectedLocation,
    this.selectedDepartment,
    this.selectedEmploymentType,
  });

  static const allLocationsKey = '__all_locations__';
  static const allDepartmentsKey = '__all_departments__';
  static const allEmploymentTypesKey = '__all_employment_types__';

  final String? selectedLocation;
  final String? selectedDepartment;
  final String? selectedEmploymentType;

  bool get isAllLocations =>
      selectedLocation == null || selectedLocation == allLocationsKey;

  bool get isAllDepartments =>
      selectedDepartment == null || selectedDepartment == allDepartmentsKey;

  bool get isAllEmploymentTypes =>
      selectedEmploymentType == null ||
      selectedEmploymentType == allEmploymentTypesKey;

  bool get hasActiveFilters =>
      !isAllLocations || !isAllDepartments || !isAllEmploymentTypes;

  DashboardFiltersState copyWith({
    String? selectedLocation,
    String? selectedDepartment,
    String? selectedEmploymentType,
    bool clearLocation = false,
    bool clearDepartment = false,
    bool clearEmploymentType = false,
  }) {
    return DashboardFiltersState(
      selectedLocation: clearLocation
          ? null
          : (selectedLocation ?? this.selectedLocation),
      selectedDepartment: clearDepartment
          ? null
          : (selectedDepartment ?? this.selectedDepartment),
      selectedEmploymentType: clearEmploymentType
          ? null
          : (selectedEmploymentType ?? this.selectedEmploymentType),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DashboardFiltersState &&
          selectedLocation == other.selectedLocation &&
          selectedDepartment == other.selectedDepartment &&
          selectedEmploymentType == other.selectedEmploymentType;

  @override
  int get hashCode =>
      Object.hash(selectedLocation, selectedDepartment, selectedEmploymentType);
}
