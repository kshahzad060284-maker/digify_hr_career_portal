import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/shared/widgets/assets/app_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AppMetaItem extends StatelessWidget {
  const AppMetaItem({
    super.key,
    required this.label,
    this.icon,
    this.iconPath,
    this.color,
    this.iconSize,
    this.iconGap,
    this.fontSize,
    this.expanded = false,
  }) : assert(
         icon == null || iconPath == null,
         'Cannot provide both icon and iconPath',
       );

  final String label;
  final IconData? icon;
  final String? iconPath;
  final Color? color;
  final double? iconSize;
  final double? iconGap;
  final double? fontSize;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? context.themeTextSecondary;
    final size = iconSize ?? 16.sp;
    final gap = iconGap ?? 4.w;
    final text = Text(
      label,
      style: context.textTheme.bodyMedium?.copyWith(
        color: effectiveColor,
        fontSize: fontSize ?? 14.sp,
      ),
      overflow: expanded ? TextOverflow.ellipsis : TextOverflow.visible,
      maxLines: expanded ? 1 : null,
    );

    return Row(
      mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
      children: [
        if (iconPath != null)
          AppAsset(
            assetPath: iconPath!,
            width: size,
            height: size,
            color: effectiveColor,
          )
        else if (icon != null)
          Icon(icon, size: size, color: effectiveColor),
        if (icon != null || iconPath != null) Gap(gap),
        if (expanded) Expanded(child: text) else text,
      ],
    );
  }
}
