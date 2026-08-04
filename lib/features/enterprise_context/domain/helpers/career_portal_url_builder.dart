class CareerPortalUrlBuilder {
  const CareerPortalUrlBuilder._();

  static String jobUrl({
    required String careerPortalUrl,
    required String jobId,
  }) {
    final rawBase = careerPortalUrl.trim();
    final base = rawBase.endsWith('/')
        ? rawBase.substring(0, rawBase.length - 1)
        : rawBase;
    return '$base/job?id=$jobId';
  }
}
