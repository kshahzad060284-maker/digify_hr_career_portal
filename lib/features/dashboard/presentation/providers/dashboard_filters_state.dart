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

  String get locationValue => selectedLocation ?? allLocationsKey;
  String get departmentValue => selectedDepartment ?? allDepartmentsKey;
  String get employmentTypeValue =>
      selectedEmploymentType ?? allEmploymentTypesKey;

  bool get isAllLocations =>
      selectedLocation == null || selectedLocation == allLocationsKey;

  bool get isAllDepartments =>
      selectedDepartment == null || selectedDepartment == allDepartmentsKey;

  bool get isAllEmploymentTypes =>
      selectedEmploymentType == null ||
      selectedEmploymentType == allEmploymentTypesKey;

  bool get hasActiveFilters =>
      !isAllLocations || !isAllDepartments || !isAllEmploymentTypes;

  List<DashboardActiveFilter> get activeFilters => [
    if (!isAllLocations)
      DashboardActiveFilter(
        label: selectedLocation!,
        type: DashboardFilterType.location,
      ),
    if (!isAllDepartments)
      DashboardActiveFilter(
        label: selectedDepartment!,
        type: DashboardFilterType.department,
      ),
    if (!isAllEmploymentTypes)
      DashboardActiveFilter(
        label: selectedEmploymentType!,
        type: DashboardFilterType.employmentType,
      ),
  ];

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

enum DashboardFilterType { location, department, employmentType }

class DashboardActiveFilter {
  const DashboardActiveFilter({required this.label, required this.type});

  final String label;
  final DashboardFilterType type;
}

class DashboardFilterOptions {
  const DashboardFilterOptions({
    required this.locations,
    required this.departments,
    required this.employmentTypes,
  });

  final List<String> locations;
  final List<String> departments;
  final List<String> employmentTypes;
}
