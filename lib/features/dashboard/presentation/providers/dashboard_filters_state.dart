class DashboardFiltersState {
  const DashboardFiltersState({this.selectedLocation});

  static const allLocationsKey = '__all_locations__';

  final String? selectedLocation;

  bool get isAllLocations =>
      selectedLocation == null || selectedLocation == allLocationsKey;

  DashboardFiltersState copyWith({
    String? selectedLocation,
    bool clearLocation = false,
  }) {
    return DashboardFiltersState(
      selectedLocation: clearLocation
          ? null
          : (selectedLocation ?? this.selectedLocation),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DashboardFiltersState &&
          selectedLocation == other.selectedLocation;

  @override
  int get hashCode => selectedLocation.hashCode;
}
