import 'package:career_portal/core/config/app_config.dart';

class JobCompanyInfo {
  const JobCompanyInfo({
    this.name = '',
    this.nameAr,
    this.logoUrl,
    this.information,
    this.industry,
    this.about,
  });

  static const String missingValue = '---';

  factory JobCompanyInfo.fromApi({
    String name = '',
    String? nameAr,
    String? logoUrl,
    String? logoAvailable,
    String? information,
    String? industry,
    String? about,
  }) {
    return JobCompanyInfo(
      name: name.trim(),
      nameAr: _nullIfEmpty(nameAr),
      logoUrl: resolveLogoUrl(logoUrl: logoUrl, logoAvailable: logoAvailable),
      information: _nullIfEmpty(information),
      industry: _nullIfEmpty(industry),
      about: _nullIfEmpty(about),
    );
  }

  final String name;
  final String? nameAr;
  final String? logoUrl;
  final String? information;
  final String? industry;
  final String? about;

  String get displayIndustry => _displayOrMissing(industry);

  String get displayInformation => _displayOrMissing(information);

  String get displayAbout => _displayOrMissing(about);

  bool get hasName => _hasText(name) || _hasText(nameAr);

  String localizedName({required bool isArabic}) {
    if (isArabic) {
      if (_hasText(nameAr)) return nameAr!.trim();
      if (_hasText(name)) return name.trim();
      return missingValue;
    }
    if (_hasText(name)) return name.trim();
    if (_hasText(nameAr)) return nameAr!.trim();
    return missingValue;
  }

  /// Prefixed with [AppConfig.baseUrl] when the API returns a relative path.
  static String? resolveLogoUrl({String? logoUrl, String? logoAvailable}) {
    if (logoAvailable?.trim().toUpperCase() == 'N') return null;

    final trimmed = logoUrl?.trim();
    if (trimmed == null || trimmed.isEmpty) return null;
    if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
      return trimmed;
    }

    return '${AppConfig.baseUrl}$trimmed';
  }

  JobCompanyInfo copyWith({
    String? name,
    String? nameAr,
    String? logoUrl,
    String? information,
    String? industry,
    String? about,
  }) {
    return JobCompanyInfo(
      name: name ?? this.name,
      nameAr: nameAr ?? this.nameAr,
      logoUrl: logoUrl ?? this.logoUrl,
      information: information ?? this.information,
      industry: industry ?? this.industry,
      about: about ?? this.about,
    );
  }

  static String _displayOrMissing(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) return missingValue;
    return trimmed;
  }

  static String? _nullIfEmpty(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) return null;
    return trimmed;
  }

  static bool _hasText(String? value) =>
      value != null && value.trim().isNotEmpty;
}
