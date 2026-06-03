class DashboardJobSearchState {
  const DashboardJobSearchState({this.query = '', this.debouncedQuery = ''});

  final String query;

  final String debouncedQuery;

  bool get hasQuery => debouncedQuery.isNotEmpty;

  DashboardJobSearchState copyWith({String? query, String? debouncedQuery}) {
    return DashboardJobSearchState(
      query: query ?? this.query,
      debouncedQuery: debouncedQuery ?? this.debouncedQuery,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DashboardJobSearchState &&
          query == other.query &&
          debouncedQuery == other.debouncedQuery;

  @override
  int get hashCode => Object.hash(query, debouncedQuery);
}
