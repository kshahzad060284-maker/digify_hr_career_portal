import 'package:career_portal/core/network/app_exception.dart';
import 'package:career_portal/features/enterprise_context/domain/models/enterprise_context.dart';

class EnterpriseContextDto {
  const EnterpriseContextDto({
    required this.enterpriseId,
    required this.enterpriseCode,
    required this.enterpriseName,
    required this.subdomainSlug,
    required this.portalType,
    required this.mainApplicationUrl,
    required this.careerPortalUrl,
  });

  final int enterpriseId;
  final String enterpriseCode;
  final String enterpriseName;
  final String subdomainSlug;
  final String portalType;
  final String mainApplicationUrl;
  final String careerPortalUrl;

  factory EnterpriseContextDto.fromJson(Map<String, dynamic> json) {
    return EnterpriseContextDto(
      enterpriseId: _requiredPositiveInt(
        json['enterprise_id'],
        'enterprise_id',
      ),
      enterpriseCode: _requiredString(
        json['enterprise_code'],
        'enterprise_code',
      ),
      enterpriseName: _requiredString(
        json['enterprise_name'],
        'enterprise_name',
      ),
      subdomainSlug: _requiredString(json['subdomain_slug'], 'subdomain_slug'),
      portalType: _requiredString(json['portal_type'], 'portal_type'),
      mainApplicationUrl: _requiredString(
        json['main_application_url'],
        'main_application_url',
      ),
      careerPortalUrl: _requiredString(
        json['career_portal_url'],
        'career_portal_url',
      ),
    );
  }

  EnterpriseContext toDomain() {
    return EnterpriseContext(
      enterpriseId: enterpriseId,
      enterpriseCode: enterpriseCode,
      enterpriseName: enterpriseName,
      subdomainSlug: subdomainSlug,
      portalType: portalType,
      mainApplicationUrl: mainApplicationUrl,
      careerPortalUrl: careerPortalUrl,
    );
  }

  static String _requiredString(dynamic value, String fieldName) {
    if (value is! String || value.trim().isEmpty) {
      throw AppException(message: '$fieldName is required');
    }
    return value.trim();
  }

  static int _requiredPositiveInt(dynamic value, String fieldName) {
    final parsed = switch (value) {
      final int number => number,
      final String text => int.tryParse(text.trim()),
      _ => null,
    };
    if (parsed == null || parsed <= 0) {
      throw AppException(message: '$fieldName is required');
    }
    return parsed;
  }
}
