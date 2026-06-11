class CandidateOffersPaginationDto {
  const CandidateOffersPaginationDto({
    required this.page,
    required this.limit,
    required this.total,
  });

  final int page;
  final int limit;
  final int total;

  factory CandidateOffersPaginationDto.fromJson(Map<String, dynamic> json) {
    return CandidateOffersPaginationDto(
      page: _asInt(json['page'], fallback: 1),
      limit: _asInt(json['limit'], fallback: 10),
      total: _asInt(json['total']),
    );
  }
}

int _asInt(dynamic value, {int fallback = 0}) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value) ?? fallback;
  return fallback;
}
