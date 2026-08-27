import 'package:career_portal/core/common/auth_enums.dart';
import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/auth/presentation/providers/forgot_password_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ForgotPasswordStepsPanel extends ConsumerWidget {
  const ForgotPasswordStepsPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = context.isDark;
    final currentStep = ref.watch(
      forgotPasswordControllerProvider.select((s) => s.step),
    );
    final controller = ref.read(forgotPasswordControllerProvider.notifier);

    final steps = [
      (ForgotPasswordStep.verifyEmail, l10n.authForgotStepVerifyEmail),
      (ForgotPasswordStep.checkOtp, l10n.authForgotStepCheckOtp),
      (ForgotPasswordStep.resetPassword, l10n.authForgotStepResetPassword),
    ];

    return DecoratedBox(
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.cardBackgroundGreyDark.withValues(alpha: 0.45)
            : AppColors.sidebarSearchBg,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: isDark ? AppColors.cardBorderDark : AppColors.cardBorder,
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16.w, 20.h, 16.w, 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.authForgotStepOf(currentStep.index + 1, steps.length),
              style: context.textTheme.labelLarge?.copyWith(
                color: AppColors.primary,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(16.h),
            for (var i = 0; i < steps.length; i++) ...[
              if (i > 0) _StepConnector(isCompleted: currentStep.index >= i),
              _StepItem(
                index: i + 1,
                title: steps[i].$2,
                isActive: currentStep == steps[i].$1,
                isCompleted: currentStep.index > steps[i].$1.index,
                onTap: currentStep.index >= steps[i].$1.index
                    ? () => controller.goToStep(steps[i].$1)
                    : null,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class ForgotPasswordMobileStepsBar extends ConsumerWidget {
  const ForgotPasswordMobileStepsBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = context.isDark;
    final currentStep = ref.watch(
      forgotPasswordControllerProvider.select((s) => s.step),
    );

    final labels = [
      l10n.authForgotStepVerifyEmail,
      l10n.authForgotStepCheckOtp,
      l10n.authForgotStepResetPassword,
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.authForgotStepOf(currentStep.index + 1, labels.length),
          textAlign: TextAlign.center,
          style: context.textTheme.labelLarge?.copyWith(
            color: AppColors.primary,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        Gap(12.h),
        Row(
          children: [
            for (var i = 0; i < labels.length; i++) ...[
              if (i > 0)
                Expanded(
                  child: Container(
                    height: 2.h,
                    margin: EdgeInsets.symmetric(horizontal: 6.w),
                    color: currentStep.index >= i
                        ? AppColors.primary
                        : (isDark
                              ? AppColors.cardBorderDark
                              : AppColors.cardBorder),
                  ),
                ),
              _StepBadge(
                index: i + 1,
                size: 28.w,
                isActive: currentStep.index == i,
                isCompleted: currentStep.index > i,
              ),
            ],
          ],
        ),
        Gap(10.h),
        Text(
          labels[currentStep.index],
          textAlign: TextAlign.center,
          style: context.textTheme.titleSmall?.copyWith(
            fontSize: 14.sp,
            color: isDark ? AppColors.textPrimaryDark : AppColors.dialogTitle,
          ),
        ),
      ],
    );
  }
}

class _StepItem extends StatelessWidget {
  const _StepItem({
    required this.index,
    required this.title,
    required this.isActive,
    required this.isCompleted,
    this.onTap,
  });

  final int index;
  final String title;
  final bool isActive;
  final bool isCompleted;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final titleColor = isActive || isCompleted
        ? (isDark ? AppColors.textPrimaryDark : AppColors.dialogTitle)
        : (isDark ? AppColors.textTertiaryDark : AppColors.textTertiary);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h),
        child: Row(
          children: [
            _StepBadge(
              index: index,
              size: 32.w,
              isActive: isActive,
              isCompleted: isCompleted,
            ),
            Gap(12.w),
            Expanded(
              child: Text(
                title,
                style: context.textTheme.titleSmall?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  color: titleColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepBadge extends StatelessWidget {
  const _StepBadge({
    required this.index,
    required this.size,
    required this.isActive,
    required this.isCompleted,
  });

  final int index;
  final double size;
  final bool isActive;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    if (isCompleted) {
      return Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.check_rounded,
          size: size * 0.5,
          color: AppColors.onPrimary,
        ),
      );
    }

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.primary
            : (isDark
                  ? AppColors.primary.withValues(alpha: 0.14)
                  : AppColors.authIconCircleBg),
        shape: BoxShape.circle,
        border: isActive
            ? null
            : Border.all(
                color: AppColors.primary.withValues(alpha: isDark ? 0.4 : 0.3),
              ),
      ),
      child: Text(
        '$index',
        style: context.textTheme.labelLarge?.copyWith(
          color: isActive ? AppColors.onPrimary : AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _StepConnector extends StatelessWidget {
  const _StepConnector({required this.isCompleted});

  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return Padding(
      padding: EdgeInsetsDirectional.only(start: 15.w),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          width: 2.w,
          height: 16.h,
          color: isCompleted
              ? AppColors.primary
              : (isDark ? AppColors.cardBorderDark : AppColors.cardBorder),
        ),
      ),
    );
  }
}
