class PaginationInfo {
  const PaginationInfo({
    required this.totalPages,
    required this.totalItems,
    required this.hasNext,
    required this.hasPrevious,
  });

  final int totalPages;
  final int totalItems;
  final bool hasNext;
  final bool hasPrevious;

  factory PaginationInfo.fromTotals({
    required int totalItems,
    required int pageSize,
    required int currentPage,
  }) {
    final totalPages = totalItems == 0 ? 1 : (totalItems / pageSize).ceil();
    final safePage = currentPage.clamp(1, totalPages);

    return PaginationInfo(
      totalPages: totalPages,
      totalItems: totalItems,
      hasNext: safePage < totalPages,
      hasPrevious: safePage > 1 && totalItems > 0,
    );
  }
}
