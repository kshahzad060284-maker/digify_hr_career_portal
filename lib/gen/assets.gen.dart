import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Assets {
  Assets._();

  static const $AssetsFaviconGen favicon = $AssetsFaviconGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsLogoGen logo = $AssetsLogoGen();
  static const $AssetsLogosGen logos = $AssetsLogosGen();
}

class $AssetsFaviconGen {
  const $AssetsFaviconGen();

  AssetGenImage get androidChrome192X192 =>
      const AssetGenImage('assets/favicon/android-chrome-192x192.png');
  AssetGenImage get androidChrome512X512 =>
      const AssetGenImage('assets/favicon/android-chrome-512x512.png');
  AssetGenImage get appleTouchIcon =>
      const AssetGenImage('assets/favicon/apple-touch-icon.png');
  AssetGenImage get favicon16X16 =>
      const AssetGenImage('assets/favicon/favicon-16x16.png');
  AssetGenImage get favicon32X32 =>
      const AssetGenImage('assets/favicon/favicon-32x32.png');
  String get faviconIco => 'assets/favicon/favicon.ico';
  String get siteWebmanifest => 'assets/favicon/site.webmanifest';
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  $AssetsIconsAuthGen get auth => const $AssetsIconsAuthGen();
  $AssetsIconsDashboardGen get dashboard => const $AssetsIconsDashboardGen();
  $AssetsIconsJobDetailGen get jobDetail => const $AssetsIconsJobDetailGen();
}

class $AssetsIconsAuthGen {
  const $AssetsIconsAuthGen();

  SvgGenImage get education =>
      const SvgGenImage('assets/icons/auth/education.svg');
  SvgGenImage get login => const SvgGenImage('assets/icons/auth/login.svg');
  SvgGenImage get signUp => const SvgGenImage('assets/icons/auth/sign-up.svg');
}

class $AssetsIconsDashboardGen {
  const $AssetsIconsDashboardGen();

  SvgGenImage get clock =>
      const SvgGenImage('assets/icons/dashboard/clock.svg');
  SvgGenImage get department =>
      const SvgGenImage('assets/icons/dashboard/department.svg');
  SvgGenImage get jobApplication =>
      const SvgGenImage('assets/icons/dashboard/job-application.svg');
  SvgGenImage get jobOffers =>
      const SvgGenImage('assets/icons/dashboard/job-offers.svg');
  SvgGenImage get locationPin =>
      const SvgGenImage('assets/icons/dashboard/location-pin.svg');
  SvgGenImage get magnifierSearch =>
      const SvgGenImage('assets/icons/dashboard/magnifier-search.svg');
}

class $AssetsIconsJobDetailGen {
  const $AssetsIconsJobDetailGen();

  SvgGenImage get calendar =>
      const SvgGenImage('assets/icons/job_detail/calendar.svg');
  SvgGenImage get dollar =>
      const SvgGenImage('assets/icons/job_detail/dollar.svg');
  SvgGenImage get employees =>
      const SvgGenImage('assets/icons/job_detail/employees.svg');
  SvgGenImage get leftArrow =>
      const SvgGenImage('assets/icons/job_detail/left-arrow.svg');
}

class $AssetsLogoGen {
  const $AssetsLogoGen();

  AssetGenImage get digifyFavicon =>
      const AssetGenImage('assets/logo/digify-favicon.png');
  SvgGenImage get digifyLogo =>
      const SvgGenImage('assets/logo/digify-logo.svg');
  SvgGenImage get digifyLogoDark =>
      const SvgGenImage('assets/logo/digify-logo-dark.svg');
  SvgGenImage get partLogo => const SvgGenImage('assets/logo/part-logo.svg');
  SvgGenImage get partLogoDark =>
      const SvgGenImage('assets/logo/part-logo-dark.svg');
}

class $AssetsLogosGen {
  const $AssetsLogosGen();

  SvgGenImage get careerPortalLogo =>
      const SvgGenImage('assets/logos/career_portal_logo.svg');
}

class SvgGenImage {
  const SvgGenImage(this.assetName);

  final String assetName;

  String get path => assetName;

  SvgPicture svg({
    Key? key,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    ColorFilter? colorFilter,
    AlignmentGeometry alignment = Alignment.center,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    Clip clipBehavior = Clip.hardEdge,
  }) {
    return SvgPicture.asset(
      assetName,
      key: key,
      width: width,
      height: height,
      fit: fit,
      colorFilter: colorFilter,
      alignment: alignment,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      clipBehavior: clipBehavior,
    );
  }

  @override
  String toString() => assetName;
}

class AssetGenImage {
  const AssetGenImage(this.assetName);

  final String assetName;

  String get path => assetName;

  Image image({
    Key? key,
    double? width,
    double? height,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    String? semanticLabel,
  }) {
    return Image.asset(
      assetName,
      key: key,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      semanticLabel: semanticLabel,
    );
  }

  @override
  String toString() => assetName;
}
