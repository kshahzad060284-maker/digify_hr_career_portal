import 'package:career_portal/shared/widgets/common/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardHeaderNavButton extends StatelessWidget {
  const DashboardHeaderNavButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.compact = false,
    this.foregroundColor,
  });

  final String label;
  final VoidCallback onPressed;
  final bool compact;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return AppButton.text(
      label: label,
      onPressed: onPressed,
      foregroundColor: foregroundColor,
      fontSize: compact ? 13.sp : 14.sp,
      padding: EdgeInsets.symmetric(horizontal: compact ? 4.w : 8.w),
    );
  }
}
