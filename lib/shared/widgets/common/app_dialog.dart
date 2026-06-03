import 'dart:ui';

import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/core/theme/app_shadows.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    required this.title,
    this.subtitle,
    required this.content,
    this.actions,
    this.icon,
    this.width,
    this.onClose,
  });

  final String title;
  final String? subtitle;
  final Widget content;
  final List<Widget>? actions;
  final Widget? icon;
  final double? width;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isSmall = screenWidth < 480;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: isSmall
            ? const EdgeInsets.symmetric(horizontal: 12, vertical: 12)
            : EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: isSmall ? double.infinity : (width ?? 500.w),
            maxHeight: MediaQuery.sizeOf(context).height * 0.9,
          ),
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.cardBackgroundDark
                : AppColors.cardBackground,
            borderRadius: BorderRadius.circular(isSmall ? 12 : 16.r),
            boxShadow: AppShadows.primaryShadow,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: isSmall
                    ? const EdgeInsets.symmetric(horizontal: 12, vertical: 10)
                    : EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: [AppColors.primary, AppColors.primaryLight],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(isSmall ? 12 : 16.r),
                    topRight: Radius.circular(isSmall ? 12 : 16.r),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: subtitle != null
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
                  children: [
                    if (icon != null) ...[icon!, Gap(12.w)],
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            title,
                            style: context.textTheme.titleMedium?.copyWith(
                              color: AppColors.buttonTextLight,
                              fontSize: isSmall ? 15 : 18.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          if (subtitle != null) ...[
                            Gap(2.h),
                            Text(
                              subtitle!,
                              style: context.textTheme.bodySmall?.copyWith(
                                color: AppColors.jobRoleBg,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: onClose ?? () => context.pop(),
                        borderRadius: BorderRadius.circular(100.r),
                        child: Padding(
                          padding: EdgeInsets.all(6.w),
                          child: Icon(
                            Icons.close_rounded,
                            size: 24.sp,
                            color: AppColors.buttonTextLight,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  padding: isSmall
                      ? const EdgeInsets.symmetric(horizontal: 14, vertical: 14)
                      : EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: content,
                ),
              ),
              if (actions != null)
                Container(
                  padding: isSmall
                      ? const EdgeInsets.symmetric(horizontal: 14, vertical: 10)
                      : EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: isDark
                            ? AppColors.cardBorderDark
                            : AppColors.cardBorder,
                      ),
                    ),
                  ),
                  child: isSmall
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: actions!
                              .map(
                                (action) => Padding(
                                  padding: EdgeInsets.only(top: 8.h),
                                  child: action,
                                ),
                              )
                              .toList(),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: actions!,
                        ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
