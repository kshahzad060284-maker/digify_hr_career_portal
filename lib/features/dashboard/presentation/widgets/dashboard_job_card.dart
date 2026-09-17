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

class DashboardJobCard extends StatefulWidget {
  const DashboardJobCard({super.key, required this.job, this.onTap});

  final DashboardJob job;
  final VoidCallback? onTap;

  @override
  State<DashboardJobCard> createState() => _DashboardJobCardState();
}

class _DashboardJobCardState extends State<DashboardJobCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = context.isDark;
    final isMobile = context.isMobileLayout;

    final cardColor = isDark
        ? AppColors.cardBackgroundDark
        : AppColors.dashboardCard;
    final borderColor = isDark
        ? AppColors.cardBorderDark
        : AppColors.dashboardCardBorder;
    final titleColor = isDark
        ? AppColors.textPrimaryDark
        : AppColors.jobCardTitleLink;
    final descriptionColor = isDark
        ? AppColors.textSecondaryDark
        : AppColors.jobCardDescription;
    final radius = 10.r;
    final hoverBorderColor = isDark
        ? AppColors.primaryLight
        : AppColors.primary;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: _isHovered ? -2.0 : 0.0),
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      builder: (context, yOffset, child) =>
          Transform.translate(offset: Offset(0, yOffset), child: child),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: _isHovered ? hoverBorderColor : borderColor,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.10),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ]
              : isDark
              ? null
              : [
                  BoxShadow(
                    color: AppColors.shadowColor.withValues(alpha: 0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Material(
          color: AppColors.transparent,
          borderRadius: BorderRadius.circular(radius),
          child: InkWell(
            onTap: widget.onTap,
            onHover: (h) => setState(() => _isHovered = h),
            mouseCursor: SystemMouseCursors.click,
            borderRadius: BorderRadius.circular(radius),
            child: Padding(
              padding: EdgeInsets.all(isMobile ? 20 : 32),
              child: isMobile
                  ? _MobileLayout(
                      job: widget.job,
                      isDark: isDark,
                      l10n: l10n,
                      onTap: widget.onTap,
                      titleColor: titleColor,
                      descriptionColor: descriptionColor,
                    )
                  : _DesktopLayout(
                      job: widget.job,
                      isDark: isDark,
                      l10n: l10n,
                      onTap: widget.onTap,
                      titleColor: titleColor,
                      descriptionColor: descriptionColor,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout({
    required this.job,
    required this.isDark,
    required this.l10n,
    required this.onTap,
    required this.titleColor,
    required this.descriptionColor,
  });

  final DashboardJob job;
  final bool isDark;
  final AppLocalizations l10n;
  final VoidCallback? onTap;
  final Color titleColor;
  final Color descriptionColor;

  @override
  Widget build(BuildContext context) {
    final titleStyle = context.textTheme.titleLarge?.copyWith(
      color: titleColor,
      fontWeight: FontWeight.bold,
      fontSize: 20.sp,
      height: 1.3,
      letterSpacing: -0.5,
    );

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Text(job.title, style: titleStyle)),
                    Gap(16.w),
                    DashboardJobShareLinkButton(jobId: job.id),
                  ],
                ),
                Gap(16.h),
                Wrap(
                  spacing: 12.w,
                  runSpacing: 8.h,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    _MetaItem(
                      iconPath: Assets.icons.dashboard.department.path,
                      label: job.department,
                      isDark: isDark,
                      iconColor: AppColors.primary,
                      textColor: isDark ? null : AppColors.textDarkSlate,
                    ),
                    _DotSeparator(isDark: isDark),
                    _MetaItem(
                      iconPath: Assets.icons.dashboard.locationPin.path,
                      label: job.location,
                      isDark: isDark,
                      iconColor: AppColors.primary,
                      textColor: isDark ? null : AppColors.textDarkSlate,
                    ),
                    _DotSeparator(isDark: isDark),
                    _MetaItem(
                      iconPath: Assets.icons.dashboard.clock.path,
                      label: job.employmentType,
                      isDark: isDark,
                      iconColor: AppColors.primary,
                      textColor: isDark ? null : AppColors.textDarkSlate,
                    ),
                  ],
                ),
                if (job.description.trim().isNotEmpty) ...[
                  Gap(16.h),
                  Text(
                    job.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: descriptionColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Gap(24.w),
          // Right Column
          SizedBox(
            width: 160.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _QuietBadges(
                  job: job,
                  isDark: isDark,
                  l10n: l10n,
                  crossAxisAlignment: CrossAxisAlignment.end,
                ),
                const Spacer(),
                _HoverDetailsButton(
                  label: l10n.dashboardJobViewDetails,
                  onPressed: onTap,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MobileLayout extends StatelessWidget {
  const _MobileLayout({
    required this.job,
    required this.isDark,
    required this.l10n,
    required this.onTap,
    required this.titleColor,
    required this.descriptionColor,
  });

  final DashboardJob job;
  final bool isDark;
  final AppLocalizations l10n;
  final VoidCallback? onTap;
  final Color titleColor;
  final Color descriptionColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                job.title,
                style: context.textTheme.titleMedium?.copyWith(
                  color: titleColor,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            Gap(8.w),
            DashboardJobShareLinkButton(jobId: job.id),
          ],
        ),
        Gap(12.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            _MetaItem(
              iconPath: Assets.icons.dashboard.department.path,
              label: job.department,
              isDark: isDark,
            ),
            _DotSeparator(isDark: isDark),
            _MetaItem(
              iconPath: Assets.icons.dashboard.locationPin.path,
              label: job.location,
              isDark: isDark,
            ),
            _DotSeparator(isDark: isDark),
            _MetaItem(
              iconPath: Assets.icons.dashboard.clock.path,
              label: job.employmentType,
              isDark: isDark,
            ),
          ],
        ),
        if (job.description.trim().isNotEmpty) ...[
          Gap(16.h),
          Text(
            job.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.bodyMedium?.copyWith(
              color: descriptionColor,
              height: 1.5,
            ),
          ),
        ],
        Gap(14.h),
        AppDivider.horizontal(
          color: isDark ? AppColors.cardBorderDark : AppColors.cardBorder,
        ),
        Gap(14.h),
        Row(
          children: [
            _QuietBadges(
              job: job,
              isDark: isDark,
              l10n: l10n,
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            const Spacer(),
            AppButton.outline(
              label: l10n.dashboardJobViewDetails,
              onPressed: onTap,
            ),
          ],
        ),
      ],
    );
  }
}

class _QuietBadges extends StatelessWidget {
  const _QuietBadges({
    required this.job,
    required this.isDark,
    required this.l10n,
    this.crossAxisAlignment = CrossAxisAlignment.end,
  });

  final DashboardJob job;
  final bool isDark;
  final AppLocalizations l10n;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
          decoration: BoxDecoration(
            color: isDark ? AppColors.cardBackgroundGreyDark : AppColors.grayBg,
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Text(
            l10n.dashboardJobOpenings(job.openingsCount),
            style: context.textTheme.labelSmall?.copyWith(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondary,
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        if (job.isUrgent) ...[
          Gap(6.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.redBgDark.withValues(alpha: 0.5)
                  : AppColors.redBg,
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              l10n.dashboardJobUrgentHiring,
              style: context.textTheme.labelSmall?.copyWith(
                color: AppColors.alertCritical,
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
        if (job.hasApplied) ...[
          Gap(6.h),
          _AppliedStatusCapsule(isDark: isDark, l10n: l10n),
        ],
      ],
    );
  }
}

class _HoverDetailsButton extends StatelessWidget {
  const _HoverDetailsButton({required this.label, this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
        minimumSize: Size(0, 40.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        textStyle: context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
      ),
      child: Text(label),
    );
  }
}

class _DotSeparator extends StatelessWidget {
  const _DotSeparator({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final color = isDark
        ? AppColors.textSecondaryDark.withValues(alpha: 0.5)
        : AppColors.jobCardDot;

    return Container(
      width: 4.w,
      height: 4.w,
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _MetaItem extends StatelessWidget {
  const _MetaItem({
    required this.iconPath,
    required this.label,
    required this.isDark,
    this.iconColor,
    this.textColor,
  });

  final String iconPath;
  final String label;
  final bool isDark;
  final Color? iconColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final effectiveIconColor =
        iconColor ??
        (isDark ? AppColors.textSecondaryDark : AppColors.jobCardMetaIcon);
    final effectiveLabelColor =
        textColor ??
        (isDark ? AppColors.textSecondaryDark : AppColors.jobCardDescription);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppAsset(
          assetPath: iconPath,
          width: 14.w,
          height: 14.w,
          color: effectiveIconColor,
        ),
        Gap(6.w),
        Text(
          label,
          style: context.textTheme.bodySmall?.copyWith(
            color: effectiveLabelColor,
          ),
        ),
      ],
    );
  }
}

class _AppliedStatusCapsule extends StatelessWidget {
  const _AppliedStatusCapsule({required this.isDark, required this.l10n});

  final bool isDark;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final textColor = isDark
        ? AppColors.successTextDark
        : AppColors.successText;

    return AppCapsule(
      label: l10n.dashboardJobApplicationStatusApplied,
      backgroundColor: isDark
          ? AppColors.successBg.withValues(alpha: 0.18)
          : AppColors.successBg,
      textColor: textColor,
      borderColor: isDark
          ? AppColors.successBorder.withValues(alpha: 0.35)
          : AppColors.successBorder,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      textStyle: context.textTheme.labelSmall?.copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
    );
  }
}
