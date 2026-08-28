import 'package:career_portal/core/common/auth_enums.dart';
import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/auth/presentation/config/register_form_config.dart';
import 'package:career_portal/features/auth/presentation/providers/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class RegisterFormStepsPanel extends ConsumerWidget {
  const RegisterFormStepsPanel({super.key, this.embedded = false});

  final bool embedded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final (currentStep, steps) = _registerStepData(ref, l10n);
    final controller = ref.read(registerControllerProvider.notifier);

    final timeline = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (!embedded) ...[
          _StepCounterText(currentStep: currentStep, total: steps.length),
          Gap(20.h),
        ],
        for (var i = 0; i < steps.length; i++) ...[
          _SidebarStepItem(
            index: i + 1,
            title: steps[i].$2,
            isActive: currentStep == steps[i].$1,
            isCompleted: currentStep.index > steps[i].$1.index,
            onTap: currentStep.index >= steps[i].$1.index
                ? () => controller.goToStep(steps[i].$1)
                : null,
          ),
          if (i < steps.length - 1) Gap(12.h),
        ],
      ],
    );

    if (embedded) return timeline;

    return _RegisterStepsContainer(child: timeline);
  }
}

class RegisterFormCompactStepsBar extends ConsumerWidget {
  const RegisterFormCompactStepsBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = context.isDark;
    final (currentStep, steps) = _registerStepData(ref, l10n);
    final progress = (currentStep.index + 1) / steps.length;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: context.registerCompactStepsMaxWidth.w,
        ),
        child: _RegisterStepsContainer(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _StepCounterText(currentStep: currentStep, total: steps.length),
              Gap(12.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(4.r),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 4.h,
                  backgroundColor: isDark
                      ? AppColors.cardBorderDark
                      : AppColors.cardBorder,
                  color: AppColors.primary,
                ),
              ),
              Gap(12.h),
              Text(
                steps[currentStep.index].$2,
                textAlign: TextAlign.center,
                style: context.textTheme.titleSmall?.copyWith(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.dialogTitle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterFormStepHeader extends ConsumerWidget {
  const RegisterFormStepHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = context.isDark;
    final (currentStep, steps) = _registerStepData(ref, l10n);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _StepCounterText(currentStep: currentStep, total: steps.length),
        Gap(6.h),
        Text(
          steps[currentStep.index].$2,
          style: context.textTheme.titleMedium?.copyWith(
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.textPrimaryDark : AppColors.dialogTitle,
          ),
        ),
      ],
    );
  }
}

(RegisterStep currentStep, List<(RegisterStep, String)> steps)
_registerStepData(WidgetRef ref, AppLocalizations l10n) {
  final currentStep = ref.watch(
    registerControllerProvider.select((s) => s.step),
  );
  return (currentStep, RegisterFormConfig.steps(l10n));
}

class _RegisterStepsContainer extends StatelessWidget {
  const _RegisterStepsContainer({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.cardBackgroundDark.withValues(alpha: 0.5)
            : AppColors.cardBackground.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isDark ? AppColors.cardBorderDark : AppColors.cardBorder,
        ),
      ),
      child: Padding(padding: EdgeInsetsDirectional.all(20.w), child: child),
    );
  }
}

class _StepCounterText extends StatelessWidget {
  const _StepCounterText({required this.currentStep, required this.total});

  final RegisterStep currentStep;
  final int total;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Text(
      l10n.authForgotStepOf(currentStep.index + 1, total),
      style: context.textTheme.labelLarge?.copyWith(
        color: AppColors.primary,
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _SidebarStepItem extends StatelessWidget {
  const _SidebarStepItem({
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

  static const _badgeSize = 32.0;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final titleColor = isActive || isCompleted
        ? (isDark ? AppColors.textPrimaryDark : AppColors.dialogTitle)
        : (isDark ? AppColors.textTertiaryDark : AppColors.textTertiary);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        decoration: isActive
            ? BoxDecoration(
                color: AppColors.primary.withValues(
                  alpha: isDark ? 0.12 : 0.06,
                ),
                borderRadius: BorderRadius.circular(8.r),
              )
            : null,
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: 8.w,
          vertical: 12.h,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _RegisterStepBadge(
              index: index,
              isActive: isActive,
              isCompleted: isCompleted,
            ),
            Gap(12.w),
            Expanded(
              child: Text(
                title,
                style: context.textTheme.titleSmall?.copyWith(
                  fontSize: 13.sp,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  color: titleColor,
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RegisterStepBadge extends StatelessWidget {
  const _RegisterStepBadge({
    required this.index,
    required this.isActive,
    required this.isCompleted,
  });

  final int index;
  final bool isActive;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    const size = _SidebarStepItem._badgeSize;

    if (isCompleted) {
      return Container(
        width: size.w,
        height: size.w,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.check_rounded,
          size: 16.sp,
          color: AppColors.onPrimary,
        ),
      );
    }

    return Container(
      width: size.w,
      height: size.w,
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
          fontSize: 12.sp,
        ),
      ),
    );
  }
}
