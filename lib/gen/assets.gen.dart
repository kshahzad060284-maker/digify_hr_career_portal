import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  $AssetsIconsDashboardGen get dashboard => const $AssetsIconsDashboardGen();
  $AssetsIconsJobDetailGen get jobDetail => const $AssetsIconsJobDetailGen();
}

class $AssetsIconsDashboardGen {
  const $AssetsIconsDashboardGen();

  SvgGenImage get clock =>
      const SvgGenImage('assets/icons/dashboard/clock.svg');
  SvgGenImage get department =>
      const SvgGenImage('assets/icons/dashboard/department.svg');
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
