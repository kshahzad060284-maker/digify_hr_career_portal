import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/shared/widgets/assets/app_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AppCapsule extends StatelessWidget {
  const AppCapsule({
    super.key,
    required this.label,
    this.iconPath,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.width,
    this.height,
    this.borderRadius,
    this.padding,
    this.textStyle,
    this.onTap,
  }) : assert(
         iconPath == null || icon == null,
         'Cannot provide both iconPath and icon',
       );

  final String label;
  final String? iconPath;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? width;
  final double? height;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final effectiveBackgroundColor =
        backgroundColor ??
        (isDark ? AppColors.cardBackgroundGreyDark : AppColors.grayBg);
    final effectiveTextColor =
        textColor ??
        (isDark ? context.themeTextPrimary : AppColors.textPrimary);
    final effectiveBorderColor =
        borderColor ??
        (isDark ? AppColors.cardBorderDark : AppColors.cardBorder);

    final content = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (iconPath != null || icon != null) ...[
          iconPath != null
              ? AppAsset(
                  assetPath: iconPath!,
                  width: 14,
                  height: 14,
                  color: effectiveTextColor,
                )
              : Icon(icon, size: 14.sp, color: effectiveTextColor),
          Gap(4.w),
        ],
        Flexible(
          child: Text(
            label,
            style:
                textStyle ??
                context.textTheme.labelSmall?.copyWith(
                  fontSize: 12.sp,
                  color: effectiveTextColor,
                ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );

    final container = Container(
      width: width,
      height: height,
      constraints: height == null ? BoxConstraints(minHeight: 24.h) : null,
      padding: padding ?? EdgeInsets.symmetric(horizontal: 11.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        border: borderColor != null
            ? Border.all(color: effectiveBorderColor, width: 1)
            : null,
        borderRadius: BorderRadius.circular(borderRadius ?? 20.r),
      ),
      child: width != null ? Center(child: content) : content,
    );

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius ?? 20.r),
          child: container,
        ),
      );
    }

    return container;
  }
}
