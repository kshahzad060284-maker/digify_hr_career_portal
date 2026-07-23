class CandidateApplicationsPaginationDto {
  const CandidateApplicationsPaginationDto({
    required this.page,
    required this.pageSize,
    required this.total,
    required this.totalPages,
    required this.hasNext,
    required this.hasPrevious,
  });

  final int page;
  final int pageSize;
  final int total;
  final int totalPages;
  final bool hasNext;
  final bool hasPrevious;

  factory CandidateApplicationsPaginationDto.fromJson(
    Map<String, dynamic> json,
  ) {
    return CandidateApplicationsPaginationDto(
      page: _asInt(json['page'], fallback: 1),
      pageSize: _asInt(json['page_size'] ?? json['limit'], fallback: 10),
      total: _asInt(json['total']),
      totalPages: _asInt(json['total_pages'], fallback: 1),
      hasNext: json['has_next'] == true,
      hasPrevious: json['has_previous'] == true,
    );
  }
}

int _asInt(dynamic value, {int fallback = 0}) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value) ?? fallback;
  return fallback;
}
