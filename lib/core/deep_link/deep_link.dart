abstract final class DeepLink {
  DeepLink._();

  static const String jobIdParam = 'id';

  static String? jobIdOf(Uri uri) {
    final value = uri.queryParameters[jobIdParam];
    if (value == null || value.isEmpty) return null;
    return value;
  }

  static Map<String, String> jobDetailQuery({required String jobId}) {
    return {jobIdParam: jobId};
  }

  static String jobDetail({required String jobId}) {
    return Uri(
      path: '/job',
      queryParameters: jobDetailQuery(jobId: jobId),
    ).toString();
  }

  static String jobDetailShareUrl({required String jobId, Uri? base}) {
    final origin = base ?? Uri.base;
    return origin
        .replace(
          path: '/job',
          queryParameters: jobDetailQuery(jobId: jobId),
          fragment: '',
        )
        .toString();
  }
}
