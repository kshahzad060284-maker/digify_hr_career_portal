import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/shared/widgets/common/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Industry pill shared by the compact company card and its detail dialog.
class CompanyIndustryCapsule extends StatelessWidget {
  const CompanyIndustryCapsule({super.key, required this.industry});

  final String industry;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return AppCapsule(
      label: industry,
      backgroundColor: isDark
          ? AppColors.purpleBgDark.withValues(alpha: 0.35)
          : AppColors.purpleBg,
      textColor: isDark ? AppColors.purpleTextDark : AppColors.purpleText,
      borderColor: isDark
          ? AppColors.purpleBorderDark.withValues(alpha: 0.45)
          : AppColors.purpleBorder,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      textStyle: context.textTheme.labelLarge?.copyWith(
        fontSize: 11.sp,
        color: isDark ? AppColors.purpleTextDark : AppColors.purpleText,
      ),
    );
  }
}
