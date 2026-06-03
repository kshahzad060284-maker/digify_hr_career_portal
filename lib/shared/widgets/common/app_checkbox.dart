import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AppCheckbox extends StatelessWidget {
  const AppCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    this.label,
    this.labelWidget,
    this.activeColor,
    this.checkColor,
    this.uncheckedBorderColor,
    this.uncheckedBorderWidth,
    this.checkedBorderWidth,
    this.size,
    this.borderRadius,
    this.checkIconSize,
    this.boxShadow,
    this.enabled = true,
    this.padding,
    this.alignment = MainAxisAlignment.start,
  }) : assert(label == null || labelWidget == null, 'Cannot provide both label and labelWidget');

  final bool value;
  final ValueChanged<bool?>? onChanged;
  final String? label;
  final Widget? labelWidget;
  final Color? activeColor;
  final Color? checkColor;
  final Color? uncheckedBorderColor;
  final double? uncheckedBorderWidth;
  final double? checkedBorderWidth;
  final double? size;
  final double? borderRadius;
  final double? checkIconSize;
  final List<BoxShadow>? boxShadow;
  final bool enabled;
  final EdgeInsetsGeometry? padding;
  final MainAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final effectiveActiveColor = activeColor ?? AppColors.primary;
    final effectiveCheckColor = checkColor ?? Colors.white;

    final effectiveSize = size ?? 15.w;
    final effectiveBorderRadius = borderRadius ?? 4.r;
    final effectiveUncheckedBorderWidth = uncheckedBorderWidth ?? 1.5;
    final effectiveCheckedBorderWidth = checkedBorderWidth ?? 0;
    final effectiveCheckIconSize = checkIconSize ?? 14.sp;

    final borderColor = enabled
        ? (value
            ? effectiveActiveColor
            : (uncheckedBorderColor ?? (isDark ? AppColors.borderGreyDark : AppColors.borderGrey)))
        : (isDark ? AppColors.cardBorderDark : AppColors.cardBorder);

    final backgroundColor = value ? effectiveActiveColor : (isDark ? AppColors.cardBackgroundDark : Colors.white);

    final checkbox = InkWell(
      onTap: enabled && onChanged != null ? () => onChanged!(!value) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: effectiveSize,
        height: effectiveSize,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(effectiveBorderRadius),
          border: Border.all(
            color: borderColor,
            width: value ? effectiveCheckedBorderWidth : effectiveUncheckedBorderWidth,
          ),
          boxShadow: boxShadow,
        ),
        child: value ? Icon(Icons.check_rounded, size: effectiveCheckIconSize, color: effectiveCheckColor) : null,
      ),
    );

    if (label == null && labelWidget == null) {
      return checkbox;
    }

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: alignment,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          checkbox,
          if (label != null || labelWidget != null) ...[
            Gap(8.w),
            Flexible(
              child: labelWidget ??
                  Text(
                    label!,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: enabled
                          ? (isDark ? AppColors.textPrimaryDark : AppColors.textPrimary)
                          : (isDark ? AppColors.textTertiaryDark : AppColors.textTertiary),
                    ),
                  ),
            ),
          ],
        ],
      ),
    );
  }
}
