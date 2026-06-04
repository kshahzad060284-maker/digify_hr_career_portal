import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_loading_indicator.dart';

class AppPageLoading extends StatelessWidget {
  const AppPageLoading({
    super.key,
    required this.message,
    this.subtitle,
    this.indicatorType = LoadingType.fadingCircle,
    this.indicatorColor,
    this.indicatorSize,
    this.maxWidth = 360,
  });

  final String message;
  final String? subtitle;
  final LoadingType indicatorType;
  final Color? indicatorColor;
  final double? indicatorSize;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final messageStyle = context.textTheme.bodyLarge?.copyWith(
      color: context.themeTextSecondary,
      fontSize: 16.sp,
      height: 1.4,
    );

    final subtitleStyle = context.textTheme.bodyMedium?.copyWith(
      color: context.themeTextMuted,
      fontSize: 14.sp,
      height: 1.5,
    );

    return Center(
      child: Semantics(
        label: subtitle == null ? message : '$message. $subtitle',
        liveRegion: true,
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 16.h,
              children: [
                AppLoadingIndicator(
                  type: indicatorType,
                  color: indicatorColor,
                  size: indicatorSize ?? 44.r,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 6.h,
                  children: [
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: messageStyle,
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        textAlign: TextAlign.center,
                        style: subtitleStyle,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
