import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/dashboard/domain/models/dashboard_job.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_job_meta_item.dart';
import 'package:career_portal/gen/assets.gen.dart';
import 'package:career_portal/shared/widgets/assets/app_asset.dart';
import 'package:career_portal/shared/widgets/common/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class DashboardJobDetailHeader extends StatelessWidget {
  const DashboardJobDetailHeader({
    super.key,
    required this.job,
    required this.fallbackTitle,
    required this.onBack,
    this.onSignInToApply,
  });

  final DashboardJob? job;
  final String fallbackTitle;
  final VoidCallback onBack;
  final VoidCallback? onSignInToApply;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isMobile = context.isMobileLayout;
    final metaColor = AppColors.textSecondary;
    final titleColor = context.isDark
        ? AppColors.textPrimary
        : AppColors.dialogTitle;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.themeCardBackground,
        border: Border(
          top: BorderSide(color: context.themeCardBorder, width: 1),
          bottom: BorderSide(color: context.themeCardBorder, width: 1),
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(32.w, 32.h, 32.w, 32.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16.h,
          children: [
            _BackLink(label: l10n.dashboardJobDetailBack, onPressed: onBack),
            if (isMobile)
              _buildMobileBody(context, l10n, titleColor, metaColor)
            else
              _buildDesktopBody(context, l10n, titleColor, metaColor),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopBody(
    BuildContext context,
    AppLocalizations l10n,
    Color titleColor,
    Color metaColor,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildTitleAndMeta(context, titleColor, metaColor)),
        Gap(24.w),
        AppButton.primary(
          label: l10n.dashboardJobDetailSignInToApply,
          onPressed: onSignInToApply,
        ),
      ],
    );
  }

  Widget _buildMobileBody(
    BuildContext context,
    AppLocalizations l10n,
    Color titleColor,
    Color metaColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 16.h,
      children: [
        _buildTitleAndMeta(context, titleColor, metaColor),
        AppButton.primary(
          label: l10n.dashboardJobDetailSignInToApply,
          onPressed: onSignInToApply,
        ),
      ],
    );
  }

  Widget _buildTitleAndMeta(
    BuildContext context,
    Color titleColor,
    Color metaColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16.h,
      children: [
        Text(
          job?.title ?? fallbackTitle,
          style: context.textTheme.titleSmall?.copyWith(
            color: titleColor,
            fontSize: 36.sp,
          ),
        ),
        if (job != null)
          Wrap(
            spacing: 16.w,
            runSpacing: 8.h,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              DashboardJobMetaItem(
                iconPath: Assets.icons.dashboard.department.path,
                label: job!.department,
                color: metaColor,
                iconSize: 18.w,
              ),
              DashboardJobMetaItem(
                iconPath: Assets.icons.dashboard.locationPin.path,
                label: job!.location,
                color: metaColor,
                iconSize: 18.w,
              ),
              DashboardJobMetaItem(
                iconPath: Assets.icons.dashboard.clock.path,
                label: job!.employmentType,
                color: metaColor,
                iconSize: 18.w,
              ),
            ],
          ),
      ],
    );
  }
}

class _BackLink extends StatelessWidget {
  const _BackLink({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(4.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppAsset(
              assetPath: Assets.icons.jobDetail.leftArrow.path,
              width: 20.w,
              height: 20.w,
              color: AppColors.primary,
            ),
            Gap(8.w),
            Text(
              label,
              style: context.textTheme.bodyLarge?.copyWith(
                color: AppColors.primary,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
