import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/dashboard/domain/config/dashboard_jobs_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DashboardJobCardSkeleton extends StatelessWidget {
  const DashboardJobCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final cardColor = isDark
        ? AppColors.cardBackgroundDark
        : AppColors.dashboardCard;
    final borderColor = isDark
        ? AppColors.cardBorderDark
        : AppColors.dashboardCardBorder;
    final dividerColor = isDark
        ? AppColors.cardBorderDark
        : AppColors.cardBorder;
    final radius = 12.r;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: borderColor),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20.w, 18.h, 20.w, 18.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Skeletonizer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Bone.text(words: 3, style: TextStyle(fontSize: 18.sp)),
                  Gap(10.h),
                  Wrap(
                    spacing: 14.w,
                    runSpacing: 8.h,
                    children: [
                      _MetaValuePlaceholder(width: 100.w),
                      _MetaValuePlaceholder(width: 90.w),
                      _MetaValuePlaceholder(width: 80.w),
                    ],
                  ),
                  Gap(12.h),
                  Bone.multiText(lines: 2, style: TextStyle(fontSize: 13.sp)),
                ],
              ),
            ),
            Gap(14.h),
            Divider(height: 1.h, thickness: 1, color: dividerColor),
            Gap(14.h),
            Skeletonizer(
              child: Row(
                children: [
                  Expanded(
                    child: Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: [
                        Bone(
                          width: 88.w,
                          height: 26.h,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        Bone(
                          width: 72.w,
                          height: 26.h,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ],
                    ),
                  ),
                  Gap(16.w),
                  Bone(
                    width: 88.w,
                    height: 36.h,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetaValuePlaceholder extends StatelessWidget {
  const _MetaValuePlaceholder({required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Bone.circle(size: 14.w),
        Gap(6.w),
        Bone(
          width: width,
          height: 12.h,
          borderRadius: BorderRadius.circular(4.r),
        ),
      ],
    );
  }
}

/// Skeleton job list matching [JobListingContent] layout.
class DashboardJobListSkeleton extends StatelessWidget {
  const DashboardJobListSkeleton({
    super.key,
    this.itemCount = DashboardJobsConfig.defaultPageSize,
    this.showFilterBar = true,
  });

  final int itemCount;
  final bool showFilterBar;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 20.h,
      children: [
        if (showFilterBar) const _FilterBarSkeleton(),
        Skeletonizer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4.h,
            children: [
              Bone(
                width: 120.w,
                height: 20.h,
                borderRadius: BorderRadius.circular(4.r),
              ),
              Bone(
                width: 180.w,
                height: 14.h,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ],
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: itemCount,
          separatorBuilder: (_, _) => Gap(12.h),
          itemBuilder: (_, _) => const DashboardJobCardSkeleton(),
        ),
      ],
    );
  }
}

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
                  child: Skeletonizer(
                    child: Bone(
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
      ),
    );
  }
}
