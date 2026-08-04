import 'package:career_portal/core/config/app_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

String? resolveTenantHost() {
  final host = Uri.base.host;
  if (_isTenantHost(host)) return host;

  if (kDebugMode) {
    final override = AppConfig.debugTenantHost.trim();
    if (override.isNotEmpty) return override;
  }

  return null;
}

bool _isTenantHost(String host) {
  if (host.isEmpty) return false;
  if (host == 'localhost' || host == '127.0.0.1') return false;
  return host.endsWith('.digifyhr.com');
}

class TenantHostInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final host = resolveTenantHost();
    if (host != null) {
      options.headers['X-Forwarded-Host'] = host;
    }
    handler.next(options);
  }
}
