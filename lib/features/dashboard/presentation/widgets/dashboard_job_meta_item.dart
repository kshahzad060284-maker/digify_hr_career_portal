import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/shared/widgets/assets/app_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class DashboardJobMetaItem extends StatelessWidget {
  const DashboardJobMetaItem({
    super.key,
    required this.iconPath,
    required this.label,
    required this.color,
    this.iconSize,
    this.iconGap,
  });

  final String iconPath;
  final String label;
  final Color color;
  final double? iconSize;
  final double? iconGap;

  @override
  Widget build(BuildContext context) {
    final size = iconSize ?? 16.w;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppAsset(assetPath: iconPath, width: size, height: size, color: color),
        Gap(iconGap ?? 8.w),
        Text(
          label,
          style: context.textTheme.bodyMedium?.copyWith(
            color: color,
            fontSize: 16.sp,
          ),
        ),
      ],
    );
  }
}
