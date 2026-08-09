import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class DashboardJobDetailSectionHeading extends StatelessWidget {
  const DashboardJobDetailSectionHeading({
    super.key,
    required this.title,
    this.color,
    this.accentColor = AppColors.primary,
    this.fontSize,
  });

  final String title;
  final Color? color;
  final Color accentColor;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: accentColor,
            borderRadius: BorderRadius.circular(999.r),
          ),
          child: SizedBox(width: 4.w, height: 20.h),
        ),
        Gap(10.w),
        Expanded(
          child: Text(
            title,
            style: context.textTheme.headlineMedium?.copyWith(
              color: color ?? context.themeTextPrimary,
              fontSize: fontSize ?? 18.sp,
            ),
          ),
        ),
      ],
    );
  }
}
