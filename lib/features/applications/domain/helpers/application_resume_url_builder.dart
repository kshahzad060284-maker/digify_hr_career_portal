import 'package:career_portal/core/config/app_config.dart';
import 'package:career_portal/core/network/api_endpoints.dart';

class ApplicationResumeUrlBuilder {
  const ApplicationResumeUrlBuilder._();

  static String build({
    required String applicationGuid,
    required int enterpriseId,
  }) {
    return Uri.parse(
          '${AppConfig.baseUrl}${RecruitmentEndpoints.applicationResume(applicationGuid)}',
        )
        .replace(
          queryParameters: <String, String>{'enterprise_id': '$enterpriseId'},
        )
        .toString();
  }
}
