import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JobListingErrorView extends StatelessWidget {
  const JobListingErrorView({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.themeCardBackground,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: context.themeCardBorder),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16.h,
          children: [
            Text(
              message,
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.themeTextSecondary,
              ),
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: FilledButton(
                onPressed: onRetry,
                child: Text(AppLocalizations.of(context)!.commonRetry),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
