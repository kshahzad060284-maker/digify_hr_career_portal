import 'package:career_portal/core/config/app_config.dart';
import 'package:career_portal/core/network/api_endpoints.dart';

class CandidateOfferPdfUrlBuilder {
  const CandidateOfferPdfUrlBuilder._();

  static String build({required String offerGuid, required int enterpriseId}) {
    return Uri.parse(
          '${AppConfig.baseUrl}${RecEndpoints.jobOfferPdf(offerGuid)}',
        )
        .replace(
          queryParameters: <String, String>{'enterprise_id': '$enterpriseId'},
        )
        .toString();
  }
}
