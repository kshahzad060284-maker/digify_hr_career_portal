import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/dashboard/domain/models/dashboard_job.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_job_share_link_button.dart';
import 'package:career_portal/shared/widgets/common/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

double _lerp(double a, double b, double t) => a + (b - a) * t;

class DashboardJobDetailHeader extends StatelessWidget {
  const DashboardJobDetailHeader({
    super.key,
    required this.job,
    required this.fallbackTitle,
    required this.onBack,
    required this.applyButtonLabel,
    required this.onApplyPressed,
    required this.hasApplied,
    required this.showApplyAction,
    this.collapseProgress = 0,
  });

  final DashboardJob? job;
  final String fallbackTitle;
  final VoidCallback onBack;
  final String applyButtonLabel;
  final VoidCallback? onApplyPressed;
  final bool hasApplied;
  final bool showApplyAction;

  /// Desktop only — 0 is the full header, 1 the slim bar. Driven straight from
  /// scroll offset so the morph tracks the wheel instead of replaying a clip.
  final double collapseProgress;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isMobile = context.isMobileLayout;
    final raw = collapseProgress.clamp(0.0, 1.0);
    final t = isMobile ? 0.0 : Curves.easeOutCubic.transform(raw);
    final hPad = isMobile ? 16.w : 30.w;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.themeCardBackground,
        border: Border(bottom: BorderSide(color: context.themeCardBorder)),
        boxShadow: t <= 0
            ? null
            : [
                BoxShadow(
                  color: AppColors.shadowColor.withValues(alpha: 0.06 * t),
                  blurRadius: 16 * t,
                  offset: Offset(0, 3 * t),
                ),
              ],
      ),
      child: ClipRect(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(
            hPad,
            _lerp(12.h, 9.h, t),
            hPad,
            _lerp(isMobile ? 18.h : 22.h, 9.h, t),
          ),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _CollapseVertical(
              t: t,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _BackLink(
                    label: l10n.dashboardJobDetailBack,
                    onPressed: onBack,
                  ),
                  Gap(12.h),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _RevealHorizontal(
                  t: t,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(end: 8.w),
                    child: _BackIconButton(
                      tooltip: l10n.dashboardJobDetailBack,
                      onPressed: onBack,
                    ),
                  ),
                ),
                Expanded(
                  child: _TitleBlock(
                    job: job,
                    title: job?.title ?? fallbackTitle,
                    l10n: l10n,
                    t: t,
                  ),
                ),
                if (!isMobile && showApplyAction && !hasApplied) ...[
                  Gap(_lerp(24.w, 16.w, t)),
                  AppButton.primary(
                    label: applyButtonLabel,
                    onPressed: onApplyPressed,
                    width: _lerp(160.w, 132.w, t),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    ),
  );
  }
}

class _TitleBlock extends StatelessWidget {
  const _TitleBlock({
    required this.job,
    required this.title,
    required this.l10n,
    required this.t,
  });

  final DashboardJob? job;
  final String title;
  final AppLocalizations l10n;
  final double t;

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobileLayout;
    final fontSize = isMobile ? 22.sp : _lerp(26.sp, 17.sp, t);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.titleSmall?.copyWith(
                  color: context.themeTextPrimary,
                  fontSize: fontSize,
                  height: 1.2,
                  letterSpacing: _lerp(-0.6, -0.3, t),
                ),
              ),
            ),
            if (job?.isUrgent ?? false) ...[
              Gap(10.w),
              _UrgentBadge(label: l10n.dashboardJobUrgentHiring),
            ],
            if (job != null)
              _RevealHorizontal(
                t: 1 - t,
                child: Padding(
                  padding: EdgeInsetsDirectional.only(start: 8.w),
                  child: DashboardJobShareLinkButton(jobId: job!.id),
                ),
              ),
          ],
        ),
        if (job != null)
          _CollapseVertical(
            t: t,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [Gap(12.h), _MetaTags(job: job!)],
            ),
          ),
      ],
    );
  }
}

/// Collapses a block upward as [t] runs 0 to 1, fading a little ahead of the
/// size change so outgoing content never ghosts over what remains.
class _CollapseVertical extends StatelessWidget {
  const _CollapseVertical({required this.t, required this.child});

  final double t;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (t <= 0) return child;
    if (t >= 1) return const SizedBox.shrink();

    return ClipRect(
      child: Align(
        alignment: AlignmentDirectional.topStart,
        heightFactor: 1 - t,
        child: Opacity(opacity: (1 - t * 1.7).clamp(0.0, 1.0), child: child),
      ),
    );
  }
}

/// Grows a block in from zero width as [t] runs 0 to 1, fading in over the
/// back half so it arrives only once there is room for it.
class _RevealHorizontal extends StatelessWidget {
  const _RevealHorizontal({required this.t, required this.child});

  final double t;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (t <= 0) return const SizedBox.shrink();
    if (t >= 1) return child;

    return ClipRect(
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        widthFactor: t,
        child: Opacity(
          opacity: ((t - 0.45) / 0.55).clamp(0.0, 1.0),
          child: child,
        ),
      ),
    );
  }
}

/// Text-only pills — metadata reads as labels, not as a row of icons.
class _MetaTags extends StatelessWidget {
  const _MetaTags({required this.job});

  final DashboardJob job;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: [
        _MetaTag(label: job.department),
        _MetaTag(label: job.location),
        _MetaTag(label: job.employmentType),
      ],
    );
  }
}

class _MetaTag extends StatefulWidget {
  const _MetaTag({required this.label});

  final String label;

  @override
  State<_MetaTag> createState() => _MetaTagState();
}

class _MetaTagState extends State<_MetaTag> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final hoverFill = context.isDark
        ? AppColors.cardBackgroundGreyDark
        : AppColors.slateBg;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: _hovered ? hoverFill : AppColors.transparent,
          border: Border.all(
            color: _hovered ? context.themeTextMuted : context.themeCardBorder,
          ),
          borderRadius: BorderRadius.circular(999.r),
        ),
        child: Text(
          widget.label,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.themeTextSecondary,
            fontSize: 12.5.sp,
            height: 1.3,
          ),
        ),
      ),
    );
  }
}

class _UrgentBadge extends StatelessWidget {
  const _UrgentBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.redBg.withValues(alpha: 0.18)
            : AppColors.redBg,
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 4.h),
        child: Text(
          label,
          style: context.textTheme.labelSmall?.copyWith(
            color: AppColors.brandRed,
            fontSize: 11.5.sp,
          ),
        ),
      ),
    );
  }
}

class _BackLink extends StatefulWidget {
  const _BackLink({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  State<_BackLink> createState() => _BackLinkState();
}

class _BackLinkState extends State<_BackLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final color = _hovered ? AppColors.primary : context.themeTextSecondary;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          onTap: widget.onPressed,
          borderRadius: BorderRadius.circular(8.r),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 2.w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedSlide(
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOut,
                  offset: _hovered ? const Offset(-0.2, 0) : Offset.zero,
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 12.sp,
                    color: color,
                  ),
                ),
                Gap(6.w),
                Text(
                  widget.label,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: color,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BackIconButton extends StatelessWidget {
  const _BackIconButton({required this.tooltip, required this.onPressed});

  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: AppColors.transparent,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: Icon(
              Icons.arrow_back_rounded,
              size: 18.sp,
              color: context.themeTextSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
