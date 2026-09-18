import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/services/toast/toast_service.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/dashboard/domain/models/dashboard_job.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_job_already_applied_banner.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_job_detail_company_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class DashboardJobDetailSidebar extends StatelessWidget {
  const DashboardJobDetailSidebar({
    super.key,
    required this.job,
    required this.postingGuid,
    required this.applyButtonLabel,
    this.onApplyPressed,
    this.hasApplied = false,
    this.showApplyAction = true,
  });

  final DashboardJob job;
  final String postingGuid;
  final String applyButtonLabel;
  final VoidCallback? onApplyPressed;
  final bool hasApplied;
  final bool showApplyAction;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = context.isDark;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.themeCardBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: isDark
            ? Border.all(color: AppColors.cardBorderDark)
            : Border.all(color: AppColors.borderLight),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: AppColors.shadowColor.withValues(alpha: 0.05),
                  blurRadius: 18,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          DashboardJobDetailCompanyCard(
            postingGuid: postingGuid,
            embedded: true,
          ),
          Divider(height: 1, color: context.themeCardBorder),
          Padding(
            padding: EdgeInsets.all(22.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 14.h,
              children: [
                Text(
                  l10n.dashboardJobDetailSidebarTitle,
                  style: context.textTheme.labelMedium?.copyWith(
                    color: context.themeTextPrimary,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                _DetailRow(
                  label: l10n.dashboardJobDetailSalaryRange,
                  value: job.salaryRange,
                ),
                _DetailRow(
                  label: l10n.dashboardJobDetailOpeningsLabel,
                  value: l10n.dashboardJobDetailPositionsCount(
                    job.openingsCount,
                  ),
                ),
                _DetailRow(
                  label: l10n.dashboardJobDetailStartDate,
                  value: job.startDate,
                ),
                _DetailRow(
                  label: l10n.dashboardJobDetailLevel,
                  value: job.level,
                ),
              ],
            ),
          ),
          Divider(height: 1, color: context.themeCardBorder),
          if (showApplyAction) ...[
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 12.h,
                children: [
                  Text(
                    l10n.dashboardJobDetailReadyToApply,
                    style: context.textTheme.titleSmall?.copyWith(
                      color: context.themeTextPrimary,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    l10n.dashboardJobDetailReadyToApplyBody,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.themeTextSecondary,
                      fontSize: 13.sp,
                      height: 1.45,
                    ),
                  ),
                  if (hasApplied)
                    const DashboardJobAlreadyAppliedBanner()
                  else
                    _GradientApplyButton(
                      label: applyButtonLabel,
                      onPressed: onApplyPressed,
                    ),
                ],
              ),
            ),
            Divider(height: 1, color: context.themeCardBorder),
          ],
          _ContactSection(
            title: l10n.dashboardJobDetailQuestionsTitle,
            body: l10n.dashboardJobDetailQuestionsBody,
            email: job.contactEmail,
            copyLabel: l10n.dashboardJobDetailCopyEmail,
            copiedMessage: l10n.dashboardJobDetailEmailCopied,
          ),
        ],
      ),
    );
  }
}

class _GradientApplyButton extends StatefulWidget {
  const _GradientApplyButton({required this.label, this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  State<_GradientApplyButton> createState() => _GradientApplyButtonState();
}

class _GradientApplyButtonState extends State<_GradientApplyButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.primary, AppColors.gradientBlue],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.35),
                    blurRadius: 18,
                    offset: const Offset(0, 6),
                  ),
                ]
              : null,
        ),
        child: Material(
          color: AppColors.transparent,
          child: InkWell(
            onTap: widget.onPressed,
            borderRadius: BorderRadius.circular(10.r),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              child: Center(
                child: Text(
                  widget.label,
                  style: TextStyle(
                    color: AppColors.onPrimary,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ContactSection extends StatefulWidget {
  const _ContactSection({
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

  @override
  State<_ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<_ContactSection> {
  bool _copied = false;
  bool _hoveredCopy = false;

  Future<void> _copyEmail() async {
    await Clipboard.setData(ClipboardData(text: widget.email));
    if (!mounted) return;
    ToastService.success(context, widget.copiedMessage);
    setState(() => _copied = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _copied = false);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final hoverBackground = isDark
        ? AppColors.primary.withValues(alpha: 0.12)
        : AppColors.primary.withValues(alpha: 0.05);

    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: context.textTheme.titleSmall?.copyWith(
              color: context.themeTextPrimary,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          Gap(10.h),
          Text(
            widget.body,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.themeTextSecondary,
              fontSize: 13.sp,
              height: 1.45,
            ),
          ),
          Gap(14.h),
          MouseRegion(
            onEnter: (_) => setState(() => _hoveredCopy = true),
            onExit: (_) => setState(() => _hoveredCopy = false),
            child: Material(
              color: AppColors.transparent,
              child: InkWell(
                onTap: _copyEmail,
                borderRadius: BorderRadius.circular(10.r),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color: _hoveredCopy
                        ? hoverBackground
                        : context.themeCardBackground,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: _hoveredCopy
                          ? AppColors.primary
                          : context.themeCardBorder,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.email,
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
                        _copied ? Icons.check_rounded : Icons.copy_rounded,
                        size: 16.sp,
                        color: _copied
                            ? AppColors.success
                            : context.themeTextSecondary,
                      ),
                      Gap(4.w),
                      Text(
                        _copied ? widget.copiedMessage : widget.copyLabel,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: _copied
                              ? AppColors.success
                              : context.themeTextSecondary,
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
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.themeTextSecondary,
              fontSize: 13.sp,
            ),
          ),
        ),
        Gap(12.w),
        Expanded(
          flex: 3,
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: context.textTheme.titleSmall?.copyWith(
              color: context.themeTextPrimary,
              fontSize: 14.sp,
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }
}
