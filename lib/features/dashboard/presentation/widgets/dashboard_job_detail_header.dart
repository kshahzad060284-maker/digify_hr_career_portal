import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/dashboard/domain/models/dashboard_job.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_job_share_link_button.dart';
import 'package:career_portal/gen/assets.gen.dart';
import 'package:career_portal/shared/widgets/assets/app_asset.dart';
import 'package:career_portal/shared/widgets/common/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class DashboardJobDetailHeader extends StatelessWidget {
  const DashboardJobDetailHeader({
    super.key,
    required this.job,
    required this.fallbackTitle,
    required this.onBack,
    required this.applyButtonLabel,
    this.onApplyPressed,
    this.hasApplied = false,
    this.showApplyAction = true,
  });

  final DashboardJob? job;
  final String fallbackTitle;
  final VoidCallback onBack;
  final String applyButtonLabel;
  final VoidCallback? onApplyPressed;
  final bool hasApplied;
  final bool showApplyAction;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isMobile = context.isMobileLayout;
    final isDark = context.isDark;
    final horizontalInset = 30.w;
    final maxWidth = MediaQuery.sizeOf(context).width;
    final titleColor = context.themeTextPrimary;
    final metaColor = context.themeTextSecondary;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  AppColors.cardBackgroundDark,
                  AppColors.infoBgDark.withValues(alpha: 0.35),
                ]
              : [
                  AppColors.cardBackground,
                  AppColors.infoBg.withValues(alpha: 0.65),
                ],
        ),
        border: Border(
          bottom: BorderSide(color: context.themeCardBorder, width: 1),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
              horizontalInset,
              isMobile ? 20.h : 28.h,
              horizontalInset,
              isMobile ? 24.h : 32.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: isMobile ? 16.h : 20.h,
              children: [
                _BackLink(
                  label: l10n.dashboardJobDetailBack,
                  onPressed: onBack,
                ),
                if (isMobile)
                  _buildMobileBody(context, titleColor, metaColor)
                else
                  _buildDesktopBody(context, titleColor, metaColor),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildApplyAction() {
    if (!showApplyAction || hasApplied) return const SizedBox.shrink();
    return AppButton.primary(
      label: applyButtonLabel,
      onPressed: onApplyPressed,
      width: 220.w,
    );
  }

  Widget _buildDesktopBody(
    BuildContext context,
    Color titleColor,
    Color metaColor,
  ) {
    final showHeaderApply = showApplyAction && !hasApplied;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildTitleAndMeta(context, titleColor, metaColor)),
        if (showHeaderApply) ...[Gap(24.w), _buildApplyAction()],
      ],
    );
  }

  Widget _buildMobileBody(
    BuildContext context,
    Color titleColor,
    Color metaColor,
  ) {
    return _buildTitleAndMeta(context, titleColor, metaColor);
  }

  Widget _buildTitleAndMeta(
    BuildContext context,
    Color titleColor,
    Color metaColor,
  ) {
    final isMobile = context.isMobileLayout;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 14.h,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                job?.title ?? fallbackTitle,
                style: context.textTheme.titleSmall?.copyWith(
                  color: titleColor,
                  fontSize: isMobile ? 26.sp : 34.sp,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),
            ),
            if (job != null) ...[
              Gap(12.w),
              DashboardJobShareLinkButton(jobId: job!.id),
            ],
          ],
        ),
        if (job != null)
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              _MetaChip(
                iconPath: Assets.icons.dashboard.department.path,
                label: job!.department,
                color: metaColor,
              ),
              _MetaChip(
                iconPath: Assets.icons.dashboard.locationPin.path,
                label: job!.location,
                color: metaColor,
              ),
              _MetaChip(
                iconPath: Assets.icons.dashboard.clock.path,
                label: job!.employmentType,
                color: metaColor,
              ),
            ],
          ),
      ],
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({
    required this.iconPath,
    required this.label,
    required this.color,
  });

  final String iconPath;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.cardBackgroundGreyDark.withValues(alpha: 0.6)
            : AppColors.cardBackground.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(999.r),
        border: Border.all(color: context.themeCardBorder),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppAsset(
              assetPath: iconPath,
              width: 14.w,
              height: 14.w,
              color: color,
            ),
            Gap(6.w),
            Text(
              label,
              style: context.textTheme.bodyMedium?.copyWith(
                color: color,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackLink extends StatelessWidget {
  const _BackLink({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8.r),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 2.w),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppAsset(
                assetPath: Assets.icons.jobDetail.leftArrow.path,
                width: 18.w,
                height: 18.w,
                color: AppColors.primary,
              ),
              Gap(8.w),
              Text(
                label,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: AppColors.primary,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
