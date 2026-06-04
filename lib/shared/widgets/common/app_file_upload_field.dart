import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/shared/widgets/common/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AppFileUploadField extends StatelessWidget {
  const AppFileUploadField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.chooseFileLabel,
    required this.onPick,
    this.isRequired = false,
    this.fileName,
    this.onClear,
    this.fillColor,
  });

  final String labelText;
  final String hintText;
  final String chooseFileLabel;
  final VoidCallback onPick;
  final bool isRequired;
  final String? fileName;
  final VoidCallback? onClear;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final background =
        fillColor ?? (isDark ? AppColors.inputBgDark : AppColors.authInputFill);
    final borderColor = isDark
        ? AppColors.inputBorderDark
        : AppColors.authInputBorder;
    final hasFile = fileName != null && fileName!.trim().isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.h,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: labelText,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: isDark
                      ? context.themeTextPrimary
                      : AppColors.inputLabel,
                ),
              ),
              if (isRequired)
                TextSpan(
                  text: ' *',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.deleteIconRed,
                  ),
                ),
            ],
          ),
        ),

        DecoratedBox(
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: borderColor),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12.w, 12.h, 12.w, 12.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.upload_file_rounded,
                  size: 22.sp,
                  color: AppColors.primary,
                ),
                Gap(12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4.h,
                    children: [
                      Text(
                        hasFile ? fileName! : hintText,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: hasFile
                              ? context.themeTextPrimary
                              : AppColors.textSecondary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                if (hasFile && onClear != null) ...[
                  IconButton(
                    onPressed: onClear,
                    icon: Icon(
                      Icons.close_rounded,
                      size: 20.sp,
                      color: AppColors.textSecondary,
                    ),
                    tooltip: MaterialLocalizations.of(context).closeButtonLabel,
                  ),
                  Gap(4.w),
                ],
                AppButton.outline(label: chooseFileLabel, onPressed: onPick),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
