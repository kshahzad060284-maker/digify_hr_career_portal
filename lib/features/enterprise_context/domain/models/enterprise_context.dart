class EnterpriseContext {
  const EnterpriseContext({
    required this.enterpriseId,
    required this.enterpriseCode,
    required this.enterpriseName,
    required this.subdomainSlug,
    required this.portalType,
    required this.mainApplicationUrl,
    required this.careerPortalUrl,
  });

  final int enterpriseId;
  final String enterpriseCode;
  final String enterpriseName;
  final String subdomainSlug;
  final String portalType;
  final String mainApplicationUrl;
  final String careerPortalUrl;
}
