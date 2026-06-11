class OfferActionResponseDto {
  const OfferActionResponseDto({required this.success, this.message});

  final bool success;
  final String? message;

  factory OfferActionResponseDto.fromJson(Map<String, dynamic> json) {
    return OfferActionResponseDto(
      success: json['success'] == true,
      message: json['message']?.toString(),
    );
  }
}
