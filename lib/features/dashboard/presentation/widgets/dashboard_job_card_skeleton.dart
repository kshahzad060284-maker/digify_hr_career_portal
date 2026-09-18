import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/dashboard/domain/config/dashboard_jobs_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

// ── Shimmer engine ────────────────────────────────────────────────────────────

class _ShimmerScope extends StatefulWidget {
  const _ShimmerScope({required this.child});
  final Widget child;

  @override
  State<_ShimmerScope> createState() => _ShimmerScopeState();
}

class _ShimmerScopeState extends State<_ShimmerScope>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      _ShimmerData(animation: _controller, child: widget.child);
}

class _ShimmerData extends InheritedWidget {
  const _ShimmerData({required this.animation, required super.child});

  final Animation<double> animation;

  static Animation<double> of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ShimmerData>()!.animation;

  @override
  bool updateShouldNotify(_ShimmerData old) => false;
}

class _ShimmerBox extends StatelessWidget {
  const _ShimmerBox({
    required this.width,
    required this.height,
    this.borderRadius,
  });

  final double width;
  final double height;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final baseColor =
        isDark ? const Color(0xFF252525) : const Color(0xFFE8E8E8);
    final highlightColor =
        isDark ? const Color(0xFF3C3C3C) : const Color(0xFFF5F5F5);
    final animation = _ShimmerData.of(context);

    return AnimatedBuilder(
      animation: animation,
      builder: (_, _) {
        final t = animation.value;
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(6.r),
            gradient: LinearGradient(
              begin: Alignment(-3 + t * 4, 0),
              end: Alignment(-1 + t * 4, 0),
              colors: [baseColor, highlightColor, baseColor],
            ),
          ),
        );
      },
    );
  }
}

// ── Shared sub-widgets ────────────────────────────────────────────────────────

/// Mirrors [_MetaItem]: 14×14 icon circle + text box.
class _MetaPlaceholder extends StatelessWidget {
  const _MetaPlaceholder({required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ShimmerBox(
          width: 14.w,
          height: 14.w,
          borderRadius: BorderRadius.circular(7.r),
        ),
        Gap(6.w),
        _ShimmerBox(
          width: width,
          height: 12.h,
          borderRadius: BorderRadius.circular(4.r),
        ),
      ],
    );
  }
}

/// Mirrors [_DotSeparator]: flat 4×4 circle, no shimmer (too small to animate).
class _DotPlaceholder extends StatelessWidget {
  const _DotPlaceholder({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4.w,
      height: 4.w,
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.textSecondaryDark.withValues(alpha: 0.3)
            : AppColors.jobCardDot,
        shape: BoxShape.circle,
      ),
    );
  }
}

// ── Desktop card skeleton ─────────────────────────────────────────────────────
//
// Mirrors [_DesktopLayout]:
//   IntrinsicHeight > Row(stretch)
//   ├─ Expanded (left): title row, meta wrap, 3 description lines
//   ├─ Gap(24.w)
//   └─ SizedBox(160.w) (right): badges stack + Spacer + button

class _DesktopCardSkeleton extends StatelessWidget {
  const _DesktopCardSkeleton({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title + share icon
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _ShimmerBox(
                        width: double.infinity,
                        height: 24.h,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                    ),
                    Gap(16.w),
                    _ShimmerBox(
                      width: 18.h,
                      height: 18.h,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ],
                ),
                Gap(16.h),
                // Meta row: dept · location · type
                Wrap(
                  spacing: 12.w,
                  runSpacing: 8.h,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    _MetaPlaceholder(width: 90.w),
                    _DotPlaceholder(isDark: isDark),
                    _MetaPlaceholder(width: 78.w),
                    _DotPlaceholder(isDark: isDark),
                    _MetaPlaceholder(width: 68.w),
                  ],
                ),
                Gap(16.h),
                // Description – 3 lines (matches maxLines: 3)
                _ShimmerBox(
                  width: double.infinity,
                  height: 14.h,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                Gap(7.h),
                _ShimmerBox(
                  width: double.infinity,
                  height: 14.h,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                Gap(7.h),
                _ShimmerBox(
                  width: 180.w,
                  height: 14.h,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ],
            ),
          ),
          Gap(24.w),
          // Right column: badges (top) + Spacer + button (bottom)
          SizedBox(
            width: 160.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Openings badge (always shown)
                _ShimmerBox(
                  width: 88.w,
                  height: 22.h,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                Gap(6.h),
                // Urgent badge placeholder
                _ShimmerBox(
                  width: 72.w,
                  height: 22.h,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                const Spacer(),
                // View Details button
                _ShimmerBox(
                  width: 130.w,
                  height: 40.h,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Mobile card skeleton ──────────────────────────────────────────────────────
//
// Mirrors [_MobileLayout]:
//   Column
//   ├─ title row + share icon
//   ├─ meta wrap
//   ├─ 2 description lines
//   ├─ divider
//   └─ Row: badges (left) + Spacer + button (right)

class _MobileCardSkeleton extends StatelessWidget {
  const _MobileCardSkeleton({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final dividerColor =
        isDark ? AppColors.cardBorderDark : AppColors.cardBorder;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title + share icon
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _ShimmerBox(
                width: double.infinity,
                height: 20.h,
                borderRadius: BorderRadius.circular(5.r),
              ),
            ),
            Gap(8.w),
            _ShimmerBox(
              width: 18.h,
              height: 18.h,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ],
        ),
        Gap(12.h),
        // Meta row: dept · location · type
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            _MetaPlaceholder(width: 90.w),
            _DotPlaceholder(isDark: isDark),
            _MetaPlaceholder(width: 78.w),
            _DotPlaceholder(isDark: isDark),
            _MetaPlaceholder(width: 68.w),
          ],
        ),
        Gap(16.h),
        // Description – 2 lines (matches maxLines: 2)
        _ShimmerBox(
          width: double.infinity,
          height: 14.h,
          borderRadius: BorderRadius.circular(4.r),
        ),
        Gap(7.h),
        _ShimmerBox(
          width: 200.w,
          height: 14.h,
          borderRadius: BorderRadius.circular(4.r),
        ),
        Gap(14.h),
        Divider(height: 1.h, thickness: 1, color: dividerColor),
        Gap(14.h),
        // Footer: openings badge (left) + button (right)
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _ShimmerBox(
              width: 80.w,
              height: 22.h,
              borderRadius: BorderRadius.circular(4.r),
            ),
            const Spacer(),
            _ShimmerBox(
              width: 110.w,
              height: 40.h,
              borderRadius: BorderRadius.circular(8.r),
            ),
          ],
        ),
      ],
    );
  }
}

// ── Card skeleton (entry point) ───────────────────────────────────────────────

class DashboardJobCardSkeleton extends StatelessWidget {
  const DashboardJobCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final isMobile = context.isMobileLayout;
    final cardColor =
        isDark ? AppColors.cardBackgroundDark : AppColors.dashboardCard;
    final borderColor =
        isDark ? AppColors.cardBorderDark : AppColors.dashboardCardBorder;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: borderColor),
      ),
      child: Padding(
        // Matches card: EdgeInsets.all(isMobile ? 20 : 32)
        padding: EdgeInsets.all(isMobile ? 20 : 32),
        child: isMobile
            ? _MobileCardSkeleton(isDark: isDark)
            : _DesktopCardSkeleton(isDark: isDark),
      ),
    );
  }
}

// ── List skeleton ─────────────────────────────────────────────────────────────

class DashboardJobListSkeleton extends StatelessWidget {
  const DashboardJobListSkeleton({
    super.key,
    this.itemCount = DashboardJobsConfig.defaultPageSize,
    this.showFilterBar = false,
  });

  final int itemCount;
  final bool showFilterBar;

  @override
  Widget build(BuildContext context) {
    return _ShimmerScope(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 20.h,
        children: [
          if (showFilterBar) const _FilterBarSkeleton(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4.h,
            children: [
              _ShimmerBox(
                width: 120.w,
                height: 20.h,
                borderRadius: BorderRadius.circular(4.r),
              ),
              _ShimmerBox(
                width: 180.w,
                height: 14.h,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ],
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: itemCount,
            separatorBuilder: (_, _) => Gap(12.h),
            itemBuilder: (_, _) => const DashboardJobCardSkeleton(),
          ),
        ],
      ),
    );
  }
}

// ── Filter-bar skeleton ───────────────────────────────────────────────────────

class _FilterBarSkeleton extends StatelessWidget {
  const _FilterBarSkeleton();

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.themeCardBackground,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: isDark ? AppColors.cardBorderDark : AppColors.cardBorder,
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: 16.w,
          vertical: 14.h,
        ),
        child: Wrap(
          spacing: 16.w,
          runSpacing: 12.h,
          children: List.generate(
            3,
            (_) => SizedBox(
              width: 250.w,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.cardBackgroundGreyDark
                      : AppColors.sidebarSearchBg,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: isDark
                        ? AppColors.inputBorderDark
                        : AppColors.borderGrey,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 16.w,
                    vertical: 14.h,
                  ),
                  child: _ShimmerBox(
                    width: 140.w,
                    height: 16.h,
                    borderRadius: BorderRadius.circular(4.r),
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
