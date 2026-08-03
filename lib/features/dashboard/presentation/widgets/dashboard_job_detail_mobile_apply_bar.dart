import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_job_already_applied_banner.dart';
import 'package:career_portal/shared/widgets/common/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardJobDetailMobileApplyBar extends StatelessWidget {
  const DashboardJobDetailMobileApplyBar({
    super.key,
    required this.applyButtonLabel,
    required this.hasApplied,
    this.onApplyPressed,
  });

  final String applyButtonLabel;
  final VoidCallback? onApplyPressed;
  final bool hasApplied;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.themeCardBackground,
        border: Border(top: BorderSide(color: context.themeCardBorder)),
        boxShadow: context.isDark
            ? null
            : [
                BoxShadow(
                  color: AppColors.shadowColor.withValues(alpha: 0.08),
                  blurRadius: 16,
                  offset: const Offset(0, -4),
                ),
              ],
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(
          16.w,
          12.h,
          16.w,
          12.h + bottomInset,
        ),
        child: hasApplied
            ? const DashboardJobAlreadyAppliedBanner()
            : SizedBox(
                width: double.infinity,
                child: AppButton.primary(
                  label: applyButtonLabel,
                  onPressed: onApplyPressed,
                ),
              ),
      ),
    );
  }
}
