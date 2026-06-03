import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSquareCapsule extends StatelessWidget {
  const AppSquareCapsule({
    super.key,
    required this.label,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderRadius,
    this.width,
    this.height,
    this.onTap,
  });

  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final double? width;
  final double? height;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final effectiveBackgroundColor = backgroundColor ?? (isDark ? AppColors.cardBackgroundGreyDark : AppColors.grayBg);
    final effectiveTextColor = textColor ?? (isDark ? AppColors.textSecondaryDark : AppColors.textSecondary);
    final effectiveBorderColor = borderColor ?? (isDark ? AppColors.cardBorderDark : AppColors.cardBorder);

    Widget container = Container(
      height: height,
      constraints: height == null ? BoxConstraints(minHeight: 24.h) : null,
      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 3.5.h),
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        border: borderColor != null ? Border.all(color: effectiveBorderColor, width: 1) : null,
        borderRadius: borderRadius ?? BorderRadius.circular(4.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              label,
              style: context.textTheme.labelMedium?.copyWith(color: effectiveTextColor),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );

    if (width != null) {
      container = SizedBox(width: width, child: container);
    }

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(onTap: onTap, child: container),
      );
    }

    return container;
  }
}
