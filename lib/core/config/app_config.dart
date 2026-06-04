import 'package:flutter/widgets.dart';

abstract final class AppConfig {
  AppConfig._();

  // App identity
  static const String appName = 'Career Portal';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';
  static const bool showDebugBanner = false;

  // Localization
  static const Locale defaultLocale = Locale('en');

  // UI configuration (ScreenUtil design size is set per breakpoint in ResponsiveHelper)
  static const bool minTextAdapt = true;
  static const bool splitScreenMode = true;

  // Network configuration
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://digift-hr-system-backend-48wi.onrender.com',
  );
  static const Duration connectTimeout = Duration(seconds: 20);
  static const Duration receiveTimeout = Duration(seconds: 20);
  static const Duration sendTimeout = Duration(seconds: 20);
  static const Map<String, dynamic> defaultHeaders = <String, dynamic>{};

  // Tenant / API defaults
  static const int defaultEnterpriseId = 1;
  static const String defaultRegistrationSource = 'CAREER_PORTAL';
  static const String defaultSalaryCurrency = 'KWD';

  // Secrets and keys
  // Keep these in --dart-define values or a secure runtime source.
  static const String apiKey = String.fromEnvironment('API_KEY');
  static const String apiSecret = String.fromEnvironment('API_SECRET');
  static const String appSecret = String.fromEnvironment('APP_SECRET');
}
