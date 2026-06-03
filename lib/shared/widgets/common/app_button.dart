import 'package:career_portal/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../assets/app_asset.dart';
import 'app_loading_indicator.dart';

enum AppButtonType { primary, secondary, outline, danger, dotted, text }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.type = AppButtonType.primary,
    this.icon,
    this.svgPath,
    this.svgAssetColor,
    this.width,
    this.iconSize,
    this.height,
    this.fontSize,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final AppButtonType type;
  final IconData? icon;
  final String? svgPath;
  final Color? svgAssetColor;
  final double? width;
  final double? iconSize;
  final double? height;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;

  factory AppButton.primary({
    required String label,
    VoidCallback? onPressed,
    bool isLoading = false,
    IconData? icon,
    String? svgPath,
    Color? svgAssetColor,
    double? width,
    double? height,
  }) {
    return AppButton(
      label: label,
      onPressed: onPressed,
      isLoading: isLoading,
      type: AppButtonType.primary,
      icon: icon,
      svgPath: svgPath,
      svgAssetColor: svgAssetColor,
      width: width,
      height: height,
    );
  }

  factory AppButton.secondary({
    required String label,
    VoidCallback? onPressed,
    bool isLoading = false,
    IconData? icon,
    String? svgPath,
    Color? svgAssetColor,
    double? width,
    double? height,
  }) {
    return AppButton(
      label: label,
      onPressed: onPressed,
      isLoading: isLoading,
      type: AppButtonType.secondary,
      icon: icon,
      svgPath: svgPath,
      svgAssetColor: svgAssetColor,
      width: width,
      height: height,
    );
  }

  factory AppButton.outline({
    required String label,
    VoidCallback? onPressed,
    bool isLoading = false,
    IconData? icon,
    String? svgPath,
    Color? svgAssetColor,
    double? width,
    double? height,
  }) {
    return AppButton(
      label: label,
      onPressed: onPressed,
      isLoading: isLoading,
      type: AppButtonType.outline,
      icon: icon,
      svgPath: svgPath,
      svgAssetColor: svgAssetColor,
      width: width,
      height: height,
    );
  }

  factory AppButton.danger({
    required String label,
    VoidCallback? onPressed,
    bool isLoading = false,
    IconData? icon,
    String? svgPath,
    Color? svgAssetColor,
    double? width,
    double? height,
  }) {
    return AppButton(
      label: label,
      onPressed: onPressed,
      isLoading: isLoading,
      type: AppButtonType.danger,
      icon: icon,
      svgPath: svgPath,
      svgAssetColor: svgAssetColor,
      width: width,
      height: height,
    );
  }

  factory AppButton.dangerOutline({
    required String label,
    VoidCallback? onPressed,
    bool isLoading = false,
    IconData? icon,
    String? svgPath,
    double? width,
    double? height,
    double? fontSize,
    double? iconSize,
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
  }) {
    return AppButton(
      label: label,
      onPressed: onPressed,
      isLoading: isLoading,
      type: AppButtonType.outline,
      icon: icon,
      svgPath: svgPath,
      svgAssetColor: AppColors.error,
      foregroundColor: AppColors.error,
      borderColor: AppColors.error,
      width: width,
      height: height,
      fontSize: fontSize,
      iconSize: iconSize,
      padding: padding,
      borderRadius: borderRadius,
    );
  }

  factory AppButton.dotted({
    required String label,
    VoidCallback? onPressed,
    bool isLoading = false,
    IconData? icon,
    String? svgPath,
    Color? svgAssetColor,
    double? width,
    double? height,
    double? fontSize,
    double? iconSize,
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
    Color? borderColor,
    Color? foregroundColor,
    Color? backgroundColor,
  }) {
    return AppButton(
      label: label,
      onPressed: onPressed,
      isLoading: isLoading,
      type: AppButtonType.dotted,
      icon: icon,
      svgPath: svgPath,
      svgAssetColor: svgAssetColor,
      width: width,
      height: height,
      fontSize: fontSize,
      padding: padding,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor ?? Colors.transparent,
      foregroundColor: foregroundColor,
      borderColor: borderColor,
      iconSize: iconSize,
    );
  }

  factory AppButton.text({
    required String label,
    VoidCallback? onPressed,
    bool isLoading = false,
    IconData? icon,
    String? svgPath,
    Color? svgAssetColor,
    double? width,
    double? height,
    double? fontSize,
    double? iconSize,
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
    Color? foregroundColor,
  }) {
    return AppButton(
      label: label,
      onPressed: onPressed,
      isLoading: isLoading,
      type: AppButtonType.text,
      icon: icon,
      svgPath: svgPath,
      svgAssetColor: svgAssetColor,
      width: width,
      height: height,
      fontSize: fontSize,
      iconSize: iconSize,
      padding: padding ?? EdgeInsets.zero,
      borderRadius: borderRadius,
      foregroundColor: foregroundColor,
    );
  }

  Color _getBaseBackgroundColor() {
    if (backgroundColor != null) return backgroundColor!;
    return switch (type) {
      AppButtonType.primary => AppColors.primary,
      AppButtonType.secondary => AppColors.cardBackgroundGrey,
      AppButtonType.outline => Colors.transparent,
      AppButtonType.danger => AppColors.error,
      AppButtonType.dotted => Colors.transparent,
      AppButtonType.text => Colors.transparent,
    };
  }

  Color _getForegroundColor() {
    if (foregroundColor != null) return foregroundColor!;
    return switch (type) {
      AppButtonType.primary => AppColors.onPrimary,
      AppButtonType.secondary => AppColors.textPrimary,
      AppButtonType.outline => AppColors.blackTextColor,
      AppButtonType.danger => AppColors.onPrimary,
      AppButtonType.dotted => AppColors.primary,
      AppButtonType.text => AppColors.primary,
    };
  }

  BorderSide? _getBorder() {
    if (type == AppButtonType.outline || type == AppButtonType.dotted) {
      return BorderSide(
        color: borderColor ?? AppColors.borderGrey,
        width: type == AppButtonType.dotted ? 1 : 1,
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final effectiveWidth = width;
    final effectiveHeight = height ?? 40.h;
    final baseBackground = _getBaseBackgroundColor();
    final isDisabled = isLoading || onPressed == null;

    final bgColor = isDisabled
        ? (type == AppButtonType.outline || type == AppButtonType.text
              ? Colors.transparent
              : baseBackground.withValues(alpha: 0.5))
        : baseBackground;

    final contentColor = isDisabled
        ? (type == AppButtonType.outline || type == AppButtonType.dotted
              ? AppColors.textMuted
              : Colors.white70)
        : _getForegroundColor();

    final border = _getBorder();

    final effectiveIconSize = iconSize ?? 18.w;
    final child = Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isLoading)
            AppLoadingIndicator(
              type: LoadingType.circle,
              color: contentColor,
              size: effectiveIconSize,
            )
          else if (icon != null)
            Icon(icon, color: contentColor, size: effectiveIconSize)
          else if (svgPath != null)
            AppAsset(
              assetPath: svgPath!,
              width: effectiveIconSize,
              height: effectiveIconSize,
              color: svgAssetColor ?? contentColor,
            ),
          if (icon != null || svgPath != null || isLoading)
            SizedBox(width: 8.w),
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize ?? 14.sp,
                fontWeight: FontWeight.w600,
                color: contentColor,
              ),
            ),
          ),
        ],
      ),
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isDisabled ? null : onPressed,
        borderRadius: borderRadius ?? BorderRadius.circular(10.r),
        child: Ink(
          width: effectiveWidth,
          height: effectiveHeight,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: borderRadius ?? BorderRadius.circular(10.r),
            border: border != null ? Border.fromBorderSide(border) : null,
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}
