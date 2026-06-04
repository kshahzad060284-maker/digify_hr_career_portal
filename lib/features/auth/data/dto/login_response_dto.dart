import 'package:career_portal/features/auth/data/dto/candidate_user_dto.dart';

class LoginResponseDto {
  const LoginResponseDto({required this.success, this.message, this.user});

  final bool success;
  final String? message;
  final CandidateUserDto? user;

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    CandidateUserDto? user;
    if (data is Map<String, dynamic>) {
      user = CandidateUserDto.fromJson(data);
    }

    return LoginResponseDto(
      success: json['success'] == true,
      message: json['message']?.toString(),
      user: user,
    );
  }
}
