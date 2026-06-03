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

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.dashboardCard,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.dashboardCardBorder),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Skeletonizer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 8.h,
                      children: [
                        Bone.text(words: 3, style: TextStyle(fontSize: 20.sp)),
                        Wrap(
                          spacing: 16.w,
                          runSpacing: 8.h,
                          children: [
                            _MetaValuePlaceholder(width: 140.w),
                            _MetaValuePlaceholder(width: 120.w),
                            _MetaValuePlaceholder(width: 160.w),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  size: 24.sp,
                  color: isDark
                      ? AppColors.textPlaceholderDark
                      : AppColors.textPlaceholder,
                ),
              ],
            ),
            Skeletonizer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12.h,
                children: [
                  Bone.multiText(lines: 2, style: TextStyle(fontSize: 16.sp)),
                  Wrap(
                    spacing: 12.w,
                    runSpacing: 8.h,
                    children: [
                      Bone(
                        width: 96.w,
                        height: 28.h,
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      Bone(
                        width: 112.w,
                        height: 28.h,
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                    ],
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
        Bone.circle(size: 18.w),
        Gap(4.w),
        Bone(
          width: width,
          height: 14.h,
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
    final isDark = context.isDark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 24.h,
      children: [
        if (showFilterBar) _FilterFieldShell(isDark: isDark),
        Skeletonizer(
          child: Bone(
            width: 200.w,
            height: 16.h,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: itemCount,
          separatorBuilder: (_, _) => Gap(16.h),
          itemBuilder: (_, _) => const DashboardJobCardSkeleton(),
        ),
      ],
    );
  }
}

class _FilterFieldShell extends StatelessWidget {
  const _FilterFieldShell({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: SizedBox(
        width: 260.w,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.themeCardBackground,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: isDark ? AppColors.inputBorderDark : AppColors.borderGrey,
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
    );
  }
}
