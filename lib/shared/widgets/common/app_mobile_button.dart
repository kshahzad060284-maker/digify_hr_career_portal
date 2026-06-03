import 'package:career_portal/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../assets/app_asset.dart';
import 'app_button.dart';
import 'app_loading_indicator.dart';

class AppMobileButton extends StatelessWidget {
  const AppMobileButton({
    super.key,
    this.onPressed,
    this.isLoading = false,
    this.type = AppButtonType.primary,
    this.icon,
    this.svgPath,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
  }) : assert(
          icon != null || svgPath != null,
          'Must provide either icon or svgPath',
        );

  final VoidCallback? onPressed;
  final bool isLoading;
  final AppButtonType type;
  final IconData? icon;
  final String? svgPath;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;

  factory AppMobileButton.primary({
    VoidCallback? onPressed,
    bool isLoading = false,
    IconData? icon,
    String? svgPath,
  }) {
    return AppMobileButton(
      onPressed: onPressed,
      isLoading: isLoading,
      type: AppButtonType.primary,
      icon: icon,
      svgPath: svgPath,
    );
  }

  factory AppMobileButton.secondary({
    VoidCallback? onPressed,
    bool isLoading = false,
    IconData? icon,
    String? svgPath,
  }) {
    return AppMobileButton(
      onPressed: onPressed,
      isLoading: isLoading,
      type: AppButtonType.secondary,
      icon: icon,
      svgPath: svgPath,
    );
  }

  factory AppMobileButton.outline({
    VoidCallback? onPressed,
    bool isLoading = false,
    IconData? icon,
    String? svgPath,
  }) {
    return AppMobileButton(
      onPressed: onPressed,
      isLoading: isLoading,
      type: AppButtonType.outline,
      icon: icon,
      svgPath: svgPath,
    );
  }

  factory AppMobileButton.danger({
    VoidCallback? onPressed,
    bool isLoading = false,
    IconData? icon,
    String? svgPath,
  }) {
    return AppMobileButton(
      onPressed: onPressed,
      isLoading: isLoading,
      type: AppButtonType.danger,
      icon: icon,
      svgPath: svgPath,
    );
  }

  factory AppMobileButton.text({
    VoidCallback? onPressed,
    bool isLoading = false,
    IconData? icon,
    String? svgPath,
    Color? foregroundColor,
  }) {
    return AppMobileButton(
      onPressed: onPressed,
      isLoading: isLoading,
      type: AppButtonType.text,
      icon: icon,
      svgPath: svgPath,
      foregroundColor: foregroundColor,
    );
  }

  Color _getBaseBackgroundColor() {
    if (backgroundColor != null) return backgroundColor!;
    return switch (type) {
      AppButtonType.primary => AppColors.primary,
      AppButtonType.secondary => AppColors.cardBackgroundGrey,
      AppButtonType.outline => Colors.transparent,
      AppButtonType.text => Colors.transparent,
      AppButtonType.dotted => Colors.transparent,
      AppButtonType.danger => AppColors.error,
    };
  }

  Color _getTextColor() {
    if (foregroundColor != null) return foregroundColor!;
    return switch (type) {
      AppButtonType.primary => Colors.white,
      AppButtonType.secondary => Colors.white,
      AppButtonType.outline => AppColors.blackTextColor,
      AppButtonType.text => AppColors.primary,
      AppButtonType.dotted => AppColors.primary,
      AppButtonType.danger => Colors.white,
    };
  }

  BorderSide? _getBorder() {
    if (type == AppButtonType.outline) {
      return BorderSide(color: borderColor ?? AppColors.borderGrey, width: 1);
    }
    return null;
  }

  Widget _buildIcon(Color contentColor) {
    final iconSize = 20.w;

    if (isLoading) {
      return AppLoadingIndicator(
        type: LoadingType.circle,
        color: contentColor,
        size: iconSize,
      );
    }

    if (icon != null) {
      return Icon(icon, color: contentColor, size: iconSize);
    }

    return AppAsset(
      assetPath: svgPath!,
      width: iconSize,
      height: iconSize,
      color: foregroundColor ?? contentColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = isLoading || onPressed == null;
    final bgColor = isDisabled
        ? (type == AppButtonType.outline || type == AppButtonType.text
            ? Colors.transparent
            : _getBaseBackgroundColor().withValues(alpha: 0.5))
        : _getBaseBackgroundColor();

    final contentColor = isDisabled
        ? (type == AppButtonType.outline || type == AppButtonType.dotted
            ? AppColors.textMuted
            : Colors.white70)
        : _getTextColor();

    final borderProp = _getBorder();
    final buttonSize = 40.w;

    return Material(
      color: Colors.transparent,
      child: Ink(
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10.r),
          border: borderProp != null ? Border.fromBorderSide(borderProp) : null,
        ),
        child: InkWell(
          onTap: isDisabled ? null : onPressed,
          borderRadius: BorderRadius.circular(10.r),
          child: Center(
            child: _buildIcon(contentColor),
          ),
        ),
      ),
    );
  }
}
