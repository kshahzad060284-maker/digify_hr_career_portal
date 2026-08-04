import 'package:flutter/widgets.dart';

abstract final class AppConfig {
  AppConfig._();

  // App identity
  static const String appName = 'Digify Careers';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';
  static const bool showDebugBanner = false;

  // Localization
  static const Locale defaultLocale = Locale('en');

  // UI configuration (ScreenUtil design size is set per breakpoint in ResponsiveHelper)
  static const bool minTextAdapt = true;
  static const bool splitScreenMode = true;

  // Network configuration
  static const String baseUrl = 'https://api.digifyhr.com';
  static const Duration connectTimeout = Duration(seconds: 20);
  static const Duration receiveTimeout = Duration(seconds: 20);
  static const Duration sendTimeout = Duration(seconds: 20);
  static const Map<String, dynamic> defaultHeaders = <String, dynamic>{};

  /// Debug-only host for `X-Forwarded-Host` when running on localhost.
  /// Set to `''` to disable. Ignored in release builds.
  // static const String debugTenantHost = 'abc-trading.careers.digifyhr.com';
  static const String debugTenantHost = 'ent001.careers.digifyhr.com';
  // static const String debugTenantHost = 'ent002.careers.digifyhr.com';
  // static const String debugTenantHost = 'albabtain-hr.careers.digifyhr.com';

  // API defaults (non-tenant)
  static const String defaultRegistrationSource = 'CAREER_PORTAL';
  static const String defaultJobApplySourceCode = 'CAREER_SITE';
  static const String defaultJobApplyCreatedBy = 'CANDIDATE';
  static const String defaultSalaryCurrency = 'KWD';
}
