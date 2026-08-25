import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class RegisterFormSectionPanel extends StatelessWidget {
  const RegisterFormSectionPanel({
    super.key,
    required this.step,
    required this.title,
    required this.child,
    this.trailing,
    this.icon,
    this.isRequired = false,
  });

  final int step;
  final String title;
  final Widget child;
  final Widget? trailing;
  final Widget? icon;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final titleStyle = context.textTheme.titleMedium?.copyWith(
      color: isDark ? AppColors.textPrimaryDark : AppColors.dialogTitle,
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: isDark ? AppColors.cardBorderDark : AppColors.cardBorder,
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16.w, 16.h, 16.w, 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                _StepBadge(step: step),
                Gap(10.w),
                if (icon != null) ...[icon!, Gap(8.w)],
                Expanded(
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      children: [
                        TextSpan(text: title, style: titleStyle),
                        if (isRequired)
                          TextSpan(
                            text: ' *',
                            style: titleStyle?.copyWith(color: AppColors.error),
                          ),
                      ],
                    ),
                  ),
                ),
                if (trailing != null) ...[Gap(8.w), trailing!],
              ],
            ),
            Gap(16.h),
            child,
          ],
        ),
      ),
    );
  }
}

class _StepBadge extends StatelessWidget {
  const _StepBadge({required this.step});

  final int step;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return Container(
      width: 28.w,
      height: 28.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.primary.withValues(alpha: 0.22)
            : AppColors.authIconCircleBg,
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primary.withValues(alpha: isDark ? 0.5 : 0.35),
        ),
      ),
      child: Text(
        '$step',
        style: context.textTheme.labelLarge?.copyWith(color: AppColors.primary),
      ),
    );
  }
}
