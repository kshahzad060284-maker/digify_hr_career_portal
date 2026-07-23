import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class DashboardJobAlreadyAppliedBanner extends StatelessWidget {
  const DashboardJobAlreadyAppliedBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = context.isDark;
    final background = isDark
        ? AppColors.successBg.withValues(alpha: 0.2)
        : AppColors.successBg;
    final foreground = isDark
        ? AppColors.successTextDark
        : AppColors.successText;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: isDark ? AppColors.successBorderDark : AppColors.successBorder,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            Icon(Icons.check_circle_rounded, size: 22.sp, color: foreground),
            Gap(10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 2.h,
                children: [
                  Text(
                    l10n.dashboardJobDetailApplied,
                    style: context.textTheme.labelMedium?.copyWith(
                      color: foreground,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    l10n.dashboardJobDetailAlreadyApplied,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: foreground,
                      fontSize: 13.sp,
                    ),
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
