class ApplyJobResponseDto {
  const ApplyJobResponseDto({required this.success, this.message});

  final bool success;
  final String? message;

  factory ApplyJobResponseDto.fromJson(Map<String, dynamic> json) {
    return ApplyJobResponseDto(
      success: json['success'] == true,
      message: json['message']?.toString(),
    );
  }
}
