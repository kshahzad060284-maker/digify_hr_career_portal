import 'dart:ui';

import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/services/toast/toast_service.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/shared/widgets/assets/app_asset.dart';
import 'package:career_portal/shared/widgets/common/app_button.dart';
import 'package:career_portal/shared/widgets/common/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ConfirmationType { info, warning, danger, success }

class AppConfirmationDialog extends StatelessWidget {
  const AppConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    this.itemName,
    required this.confirmLabel,
    this.cancelLabel = 'Cancel',
    required this.onConfirm,
    this.onCancel,
    this.type = ConfirmationType.danger,
    this.isLoading = false,
    this.icon,
    this.svgPath,
    this.hasTextField = false,
    this.textFieldLabel,
    this.textController,
  });

  final String title;
  final String message;
  final String? itemName;
  final String confirmLabel;
  final String cancelLabel;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final ConfirmationType type;
  final bool isLoading;
  final IconData? icon;
  final String? svgPath;
  final bool hasTextField;
  final String? textFieldLabel;
  final TextEditingController? textController;

  factory AppConfirmationDialog.delete({
    Key? key,
    required String title,
    required String message,
    String? itemName,
    String confirmLabel = 'Delete',
    String cancelLabel = 'Cancel',
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
    bool isLoading = false,
  }) {
    return AppConfirmationDialog(
      key: key,
      title: title,
      message: message,
      itemName: itemName,
      confirmLabel: confirmLabel,
      cancelLabel: cancelLabel,
      onConfirm: onConfirm,
      onCancel: onCancel,
      type: ConfirmationType.danger,
      isLoading: isLoading,
      icon: Icons.delete_outline_rounded,
    );
  }

  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String message,
    String? itemName,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    ConfirmationType type = ConfirmationType.danger,
    IconData? icon,
    String? svgPath,
  }) {
    return showDialog<bool>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.45),
      builder: (context) => AppConfirmationDialog(
        title: title,
        message: message,
        itemName: itemName,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        onConfirm: () => Navigator.of(context).pop(true),
        onCancel: () => Navigator.of(context).pop(false),
        type: type,
        icon: icon,
        svgPath: svgPath,
      ),
    );
  }

  static Future<String?> showWithInput(
    BuildContext context, {
    required String title,
    required String message,
    String? itemName,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    ConfirmationType type = ConfirmationType.danger,
    IconData? icon,
    String? svgPath,
    required String textFieldLabel,
    String? initialValue,
    String? Function(String?)? validator,
  }) {
    final controller = TextEditingController(text: initialValue);

    return showDialog<String>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.45),
      builder: (dialogContext) => AppConfirmationDialog(
        title: title,
        message: message,
        itemName: itemName,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        onConfirm: () {
          final text = controller.text;
          final error = validator?.call(text);
          if (error != null && error.isNotEmpty) {
            ToastService.error(dialogContext, error);
            return;
          }
          Navigator.of(dialogContext).pop(text);
        },
        onCancel: () => Navigator.of(dialogContext).pop(),
        type: type,
        icon: icon,
        svgPath: svgPath,
        hasTextField: true,
        textFieldLabel: textFieldLabel,
        textController: controller,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final color = _typeColor();
    final bgColor = _typeBgColor(isDark);

    final isMobile = context.isMobileLayout;
    final maxWidth = context.responsiveFine<double>(
      mobile: 360,
      tabletSmall: 440,
      tabletMedium: 440,
      tabletLarge: 480,
      desktop: 480,
    );
    final horizontalPadding = context.responsiveFine<double>(
      mobile: 20,
      tabletSmall: 28,
      tabletMedium: 28,
      tabletLarge: 32,
      desktop: 32,
    );
    final iconSize = context.responsiveFine<double>(
      mobile: 56,
      tabletSmall: 64,
      tabletMedium: 64,
      tabletLarge: 64,
      desktop: 64,
    );
    final iconInnerSize = context.responsiveFine<double>(
      mobile: 28,
      tabletSmall: 32,
      tabletMedium: 32,
      tabletLarge: 32,
      desktop: 32,
    );
    final titleFontSize = context.responsiveFine<double>(
      mobile: 18,
      tabletSmall: 20,
      tabletMedium: 20,
      tabletLarge: 20,
      desktop: 20,
    );
    final bodyFontSize = context.responsiveFine<double>(
      mobile: 13.5,
      tabletSmall: 14.5,
      tabletMedium: 14.5,
      tabletLarge: 14.5,
      desktop: 14.5,
    );
    final buttonHeight = context.responsiveFine<double>(
      mobile: 42,
      tabletSmall: 46,
      tabletMedium: 46,
      tabletLarge: 46,
      desktop: 46,
    );
    final topPadding = context.responsiveFine<double>(
      mobile: 28,
      tabletSmall: 32,
      tabletMedium: 32,
      tabletLarge: 36,
      desktop: 36,
    );
    final bottomPadding = context.responsiveFine<double>(
      mobile: 24,
      tabletSmall: 28,
      tabletMedium: 28,
      tabletLarge: 28,
      desktop: 28,
    );
    final horizontalMargin = context.responsiveFine<double>(
      mobile: 20,
      tabletSmall: 40,
      tabletMedium: 40,
      tabletLarge: 0,
      desktop: 0,
    );

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: isMobile ? 0.9 * MediaQuery.sizeOf(context).width : maxWidth,
            constraints: BoxConstraints(maxWidth: maxWidth),
            margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
            decoration: BoxDecoration(
              color: isDark ? AppColors.cardBackgroundDark : Colors.white,
              borderRadius: BorderRadius.circular(isMobile ? 20.r : 16.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: topPadding.h),
                Container(
                  width: iconSize.w,
                  height: iconSize.w,
                  decoration: BoxDecoration(
                    color: bgColor,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: svgPath != null
                      ? AppAsset(
                          assetPath: svgPath!,
                          width: iconInnerSize.w,
                          height: iconInnerSize.w,
                          color: color,
                        )
                      : Icon(
                          icon ?? _defaultIcon(),
                          color: color,
                          size: iconInnerSize.sp,
                        ),
                ),
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding.w,
                  ),
                  child: Column(
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: titleFontSize.sp,
                          fontWeight: FontWeight.w700,
                          color: isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimary,
                          letterSpacing: -0.5,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: bodyFontSize.sp,
                          fontWeight: FontWeight.w400,
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondary,
                          height: 1.4,
                        ),
                      ),
                      if (itemName != null) ...[
                        SizedBox(height: 16.h),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 10.h,
                          ),
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.white.withValues(alpha: 0.05)
                                : AppColors.grayBg,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: isDark
                                  ? Colors.white.withValues(alpha: 0.08)
                                  : AppColors.grayBorder.withValues(alpha: 0.5),
                            ),
                          ),
                          child: Text(
                            itemName!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: bodyFontSize.sp,
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                      if (hasTextField && textController != null) ...[
                        SizedBox(height: 16.h),
                        AppTextArea(
                          controller: textController!,
                          labelText: textFieldLabel ?? '',
                          maxLines: 5,
                          minLines: 3,
                          fillColor: isDark
                              ? AppColors.inputBgDark
                              : AppColors.authInputFill,
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding.w,
                    0,
                    horizontalPadding.w,
                    bottomPadding.h,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          label: cancelLabel,
                          type: AppButtonType.outline,
                          height: buttonHeight.h,
                          onPressed: isLoading
                              ? null
                              : (onCancel ?? () => Navigator.of(context).pop()),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: AppButton(
                          label: confirmLabel,
                          type: type == ConfirmationType.danger
                              ? AppButtonType.danger
                              : AppButtonType.primary,
                          height: buttonHeight.h,
                          isLoading: isLoading,
                          onPressed: isLoading ? null : onConfirm,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _typeColor() {
    return switch (type) {
      ConfirmationType.danger => AppColors.error,
      ConfirmationType.warning => AppColors.warning,
      ConfirmationType.success => AppColors.success,
      ConfirmationType.info => AppColors.info,
    };
  }

  Color _typeBgColor(bool isDark) {
    if (isDark) {
      return switch (type) {
        ConfirmationType.danger => AppColors.error.withValues(alpha: 0.15),
        ConfirmationType.warning => AppColors.warning.withValues(alpha: 0.15),
        ConfirmationType.success => AppColors.success.withValues(alpha: 0.15),
        ConfirmationType.info => AppColors.info.withValues(alpha: 0.15),
      };
    }
    return switch (type) {
      ConfirmationType.danger => AppColors.errorBg,
      ConfirmationType.warning => AppColors.warningBg,
      ConfirmationType.success => AppColors.successBg,
      ConfirmationType.info => AppColors.infoBg,
    };
  }

  IconData _defaultIcon() {
    return switch (type) {
      ConfirmationType.danger => Icons.delete_outline_rounded,
      ConfirmationType.warning => Icons.warning_amber_rounded,
      ConfirmationType.success => Icons.check_circle_outline_rounded,
      ConfirmationType.info => Icons.info_outline_rounded,
    };
  }
}
