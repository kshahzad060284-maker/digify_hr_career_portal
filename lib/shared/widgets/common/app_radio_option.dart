import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AppRadioOption extends StatelessWidget {
  const AppRadioOption({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.enabled = true,
    this.activeColor,
    this.inactiveBorderColor,
    this.labelColor,
    this.size,
    this.innerDotSize,
    this.selectedBorderWidth,
    this.unselectedBorderWidth,
    this.labelFontSize,
    this.labelFontWeight,
    this.spacing,
    this.padding,
    this.borderRadius,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final bool enabled;
  final Color? activeColor;
  final Color? inactiveBorderColor;
  final Color? labelColor;
  final double? size;
  final double? innerDotSize;
  final double? selectedBorderWidth;
  final double? unselectedBorderWidth;
  final double? labelFontSize;
  final FontWeight? labelFontWeight;
  final double? spacing;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final effectiveActiveColor = activeColor ?? AppColors.primary;
    final effectiveInactiveBorderColor =
        inactiveBorderColor ?? AppColors.textMuted;
    final effectiveSize = size ?? 13.w;
    final effectiveInnerDotSize = innerDotSize ?? 7.8.w;
    final effectiveSelectedBorderWidth = selectedBorderWidth ?? 2.6;
    final effectiveUnselectedBorderWidth = unselectedBorderWidth ?? 1;
    final effectiveSpacing = spacing ?? 8.w;
    final effectiveBorderRadius = borderRadius ?? 8.r;
    final effectiveLabelColor =
        labelColor ??
        (context.isDark ? AppColors.textPrimaryDark : AppColors.inputLabel);

    return Semantics(
      checked: selected,
      enabled: enabled,
      label: label,
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(effectiveBorderRadius),
        child: Padding(
          padding: padding ?? EdgeInsets.symmetric(vertical: 4.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: effectiveSize,
                height: effectiveSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selected
                        ? effectiveActiveColor
                        : effectiveInactiveBorderColor,
                    width: selected
                        ? effectiveSelectedBorderWidth
                        : effectiveUnselectedBorderWidth,
                  ),
                ),
                child: selected
                    ? Center(
                        child: Container(
                          width: effectiveInnerDotSize,
                          height: effectiveInnerDotSize,
                          decoration: BoxDecoration(
                            color: effectiveActiveColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                    : null,
              ),
              Gap(effectiveSpacing),
              Text(
                label,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontSize: labelFontSize ?? 14.sp,
                  fontWeight: labelFontWeight ?? FontWeight.w500,
                  color: enabled
                      ? effectiveLabelColor
                      : (context.isDark
                            ? AppColors.textTertiaryDark
                            : AppColors.textTertiary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
