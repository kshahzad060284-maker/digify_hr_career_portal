abstract final class DeepLink {
  DeepLink._();

  static const String enterpriseIdParam = 'enterprise_id';
  static const String jobIdParam = 'id';

  static int? enterpriseIdOf(Uri uri) {
    final raw = uri.queryParameters[enterpriseIdParam];
    if (raw == null || raw.isEmpty) return null;
    final value = int.tryParse(raw);
    if (value == null || value <= 0) return null;
    return value;
  }

  static String? jobIdOf(Uri uri) {
    final value = uri.queryParameters[jobIdParam];
    if (value == null || value.isEmpty) return null;
    return value;
  }

  static Map<String, String> jobDetailQuery({
    required String jobId,
    required int enterpriseId,
  }) {
    return {jobIdParam: jobId, enterpriseIdParam: '$enterpriseId'};
  }

  static String jobDetail({required String jobId, required int enterpriseId}) {
    return Uri(
      path: '/job',
      queryParameters: jobDetailQuery(jobId: jobId, enterpriseId: enterpriseId),
    ).toString();
  }

  static String withEnterpriseId(String location, int enterpriseId) {
    final uri = Uri.parse(location);
    final params = Map<String, String>.from(uri.queryParameters);
    params[enterpriseIdParam] = '$enterpriseId';
    return uri.replace(queryParameters: params).toString();
  }
}
