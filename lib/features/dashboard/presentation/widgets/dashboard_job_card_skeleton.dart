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
              // Sweep the highlight from far left (t=0) to far right (t=1)
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

// ── Card skeleton ─────────────────────────────────────────────────────────────

class DashboardJobCardSkeleton extends StatelessWidget {
  const DashboardJobCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final cardColor =
        isDark ? AppColors.cardBackgroundDark : AppColors.dashboardCard;
    final borderColor =
        isDark ? AppColors.cardBorderDark : AppColors.dashboardCardBorder;
    final dividerColor =
        isDark ? AppColors.cardBorderDark : AppColors.cardBorder;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: borderColor),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20.w, 18.h, 20.w, 18.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ShimmerBox(width: 220.w, height: 20.h),
            Gap(10.h),
            Wrap(
              spacing: 14.w,
              runSpacing: 8.h,
              children: [
                _MetaPlaceholder(width: 100.w),
                _MetaPlaceholder(width: 90.w),
                _MetaPlaceholder(width: 80.w),
              ],
            ),
            Gap(12.h),
            _ShimmerBox(width: double.infinity, height: 13.h),
            Gap(6.h),
            _ShimmerBox(width: 200.w, height: 13.h),
            Gap(14.h),
            Divider(height: 1.h, thickness: 1, color: dividerColor),
            Gap(14.h),
            Row(
              children: [
                Expanded(
                  child: Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: [
                      _ShimmerBox(
                        width: 88.w,
                        height: 26.h,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      _ShimmerBox(
                        width: 72.w,
                        height: 26.h,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ],
                  ),
                ),
                Gap(16.w),
                _ShimmerBox(
                  width: 88.w,
                  height: 36.h,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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
