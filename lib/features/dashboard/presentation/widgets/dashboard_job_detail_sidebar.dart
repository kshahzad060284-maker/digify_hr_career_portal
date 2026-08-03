import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/services/toast/toast_service.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/dashboard/domain/models/dashboard_job.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_job_already_applied_banner.dart';
import 'package:career_portal/gen/assets.gen.dart';
import 'package:career_portal/shared/widgets/assets/app_asset.dart';
import 'package:career_portal/shared/widgets/common/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class DashboardJobDetailSidebar extends StatelessWidget {
  const DashboardJobDetailSidebar({
    super.key,
    required this.job,
    required this.applyButtonLabel,
    this.onApplyPressed,
    this.hasApplied = false,
    this.showApplyAction = true,
  });

  final DashboardJob job;
  final String applyButtonLabel;
  final VoidCallback? onApplyPressed;
  final bool hasApplied;
  final bool showApplyAction;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = context.isDark;
    final sectionTitleColor = context.themeTextPrimary;
    final valueColor = context.themeTextPrimary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 16.h,
      children: [
        _SidebarCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 18.h,
            children: [
              Text(
                l10n.dashboardJobDetailSidebarTitle,
                style: context.textTheme.labelMedium?.copyWith(
                  color: sectionTitleColor,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              _DetailField(
                iconPath: Assets.icons.jobDetail.dollar.path,
                label: l10n.dashboardJobDetailSalaryRange,
                value: job.salaryRange,
                valueColor: valueColor,
                iconTint: AppColors.success,
                iconBg: isDark
                    ? AppColors.successBg.withValues(alpha: 0.2)
                    : AppColors.greenBg,
              ),
              _DetailField(
                iconPath: Assets.icons.jobDetail.employees.path,
                label: l10n.dashboardJobDetailOpeningsLabel,
                value: l10n.dashboardJobDetailPositionsCount(job.openingsCount),
                valueColor: valueColor,
                iconTint: AppColors.primary,
                iconBg: isDark
                    ? AppColors.infoBg.withValues(alpha: 0.2)
                    : AppColors.infoBg,
              ),
              _DetailField(
                iconPath: Assets.icons.jobDetail.calendar.path,
                label: l10n.dashboardJobDetailStartDate,
                value: job.startDate,
                valueColor: valueColor,
                iconTint: AppColors.orange,
                iconBg: isDark
                    ? AppColors.orangeBg.withValues(alpha: 0.2)
                    : AppColors.orangeBg,
              ),
              _DetailField(
                iconPath: Assets.icons.dashboard.department.path,
                label: l10n.dashboardJobDetailLevel,
                value: job.level,
                valueColor: valueColor,
                iconTint: AppColors.purple,
                iconBg: isDark
                    ? AppColors.purpleBg.withValues(alpha: 0.2)
                    : AppColors.purpleBg,
              ),
            ],
          ),
        ),
        if (showApplyAction)
          _ApplyCard(
            title: l10n.dashboardJobDetailReadyToApply,
            body: l10n.dashboardJobDetailReadyToApplyBody,
            applyButtonLabel: applyButtonLabel,
            onApplyPressed: onApplyPressed,
            hasApplied: hasApplied,
          ),
        _QuestionsCard(
          title: l10n.dashboardJobDetailQuestionsTitle,
          body: l10n.dashboardJobDetailQuestionsBody,
          email: job.contactEmail,
          copyLabel: l10n.dashboardJobDetailCopyEmail,
          copiedMessage: l10n.dashboardJobDetailEmailCopied,
        ),
      ],
    );
  }
}

class _SidebarCard extends StatelessWidget {
  const _SidebarCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.themeCardBackground,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: context.themeCardBorder),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: AppColors.shadowColor.withValues(alpha: 0.05),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Padding(padding: EdgeInsets.all(22.w), child: child),
    );
  }
}

class _DetailField extends StatelessWidget {
  const _DetailField({
    required this.iconPath,
    required this.label,
    required this.value,
    required this.valueColor,
    required this.iconTint,
    required this.iconBg,
  });

  final String iconPath;
  final String label;
  final String value;
  final Color valueColor;
  final Color iconTint;
  final Color iconBg;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: iconBg,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(9.w),
            child: AppAsset(
              assetPath: iconPath,
              width: 16.w,
              height: 16.w,
              color: iconTint,
            ),
          ),
        ),
        Gap(12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 3.h,
            children: [
              Text(
                label,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.themeTextSecondary,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: valueColor,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ApplyCard extends StatelessWidget {
  const _ApplyCard({
    required this.title,
    required this.body,
    required this.applyButtonLabel,
    required this.hasApplied,
    this.onApplyPressed,
  });

  final String title;
  final String body;
  final String applyButtonLabel;
  final VoidCallback? onApplyPressed;
  final bool hasApplied;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  AppColors.infoBgDark.withValues(alpha: 0.45),
                  AppColors.cardBackgroundDark,
                ]
              : [AppColors.infoBg, AppColors.cardBackground],
        ),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: isDark
              ? AppColors.infoBorderDark.withValues(alpha: 0.5)
              : AppColors.infoBorder,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 12.h,
          children: [
            Text(
              title,
              style: context.textTheme.titleSmall?.copyWith(
                color: context.themeTextPrimary,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              body,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.themeTextSecondary,
                fontSize: 13.sp,
                height: 1.45,
              ),
            ),
            if (hasApplied)
              const DashboardJobAlreadyAppliedBanner()
            else
              AppButton.primary(
                label: applyButtonLabel,
                onPressed: onApplyPressed,
              ),
          ],
        ),
      ),
    );
  }
}

class _QuestionsCard extends StatelessWidget {
  const _QuestionsCard({
    required this.title,
    required this.body,
    required this.email,
    required this.copyLabel,
    required this.copiedMessage,
  });

  final String title;
  final String body;
  final String email;
  final String copyLabel;
  final String copiedMessage;

  Future<void> _copyEmail(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: email));
    if (!context.mounted) return;
    ToastService.success(context, copiedMessage);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.infoBgDark.withValues(alpha: 0.35)
            : AppColors.infoBg,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: isDark
              ? AppColors.infoBorderDark.withValues(alpha: 0.45)
              : AppColors.infoBorder,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.primary.withValues(alpha: 0.2)
                        : AppColors.authIconCircleBg,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Icon(
                      Icons.mail_outline_rounded,
                      size: 18.sp,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                Gap(10.w),
                Expanded(
                  child: Text(
                    title,
                    style: context.textTheme.titleSmall?.copyWith(
                      color: context.themeTextPrimary,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            Gap(10.h),
            Text(
              body,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.themeTextSecondary,
                fontSize: 13.sp,
                height: 1.45,
              ),
            ),
            Gap(14.h),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => _copyEmail(context),
                borderRadius: BorderRadius.circular(10.r),
                child: Ink(
                  decoration: BoxDecoration(
                    color: context.themeCardBackground,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: context.themeCardBorder),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 10.h,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            email,
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: AppColors.primary,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Gap(8.w),
                        Icon(
                          Icons.copy_rounded,
                          size: 16.sp,
                          color: context.themeTextSecondary,
                        ),
                        Gap(4.w),
                        Text(
                          copyLabel,
                          style: context.textTheme.labelSmall?.copyWith(
                            color: context.themeTextSecondary,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
