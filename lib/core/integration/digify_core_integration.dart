import 'package:career_portal/core/config/app_config.dart';
import 'package:career_portal/core/network/tenant_host.dart';
import 'package:career_portal/features/enterprise_context/presentation/providers/enterprise_context_provider.dart';
import 'package:digify_core/network/api_client.dart';
import 'package:digify_core/network/api_config.dart' as digify_core;
import 'package:digify_core/network/network_providers.dart' as digify_core;
import 'package:digify_core/providers/current_user_provider.dart'
    as digify_core;
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<Override> buildDigifyCoreHostOverrides() {
  return [
    digify_core.activeEnterpriseIdProvider.overrideWith(
      (ref) => ref.watch(hostEnterpriseIdProvider),
    ),
    digify_core.apiBaseUrlProvider.overrideWith((ref) => AppConfig.baseUrl),
    digify_core.apiClientProvider.overrideWith((ref) {
      final dio = Dio(
        BaseOptions(
          baseUrl: AppConfig.baseUrl,
          connectTimeout: AppConfig.connectTimeout,
          receiveTimeout: AppConfig.receiveTimeout,
          sendTimeout: AppConfig.sendTimeout,
          headers: const {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      )..interceptors.add(TenantHostInterceptor());
      return ApiClient(baseUrl: AppConfig.baseUrl, dio: dio);
    }),
  ];
}
