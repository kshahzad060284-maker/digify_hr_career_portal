import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/shared/widgets/assets/app_asset.dart';
import 'package:career_portal/shared/widgets/common/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AuthIconCircle extends StatelessWidget {
  const AuthIconCircle({super.key, required this.assetPath});

  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64.w,
      height: 64.w,
      decoration: const BoxDecoration(
        color: AppColors.authIconCircleBg,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: AppAsset(
        assetPath: assetPath,
        width: 32.w,
        height: 32.w,
        color: AppColors.primary,
      ),
    );
  }
}

class AuthFormField extends StatelessWidget {
  const AuthFormField({
    super.key,
    required this.label,
    required this.initialValue,
    required this.isDark,
    required this.onChanged,
    this.hintText,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onSubmitted,
    this.isRequired = false,
    this.inputFormatters,
  });

  final String label;
  final String initialValue;
  final bool isDark;
  final ValueChanged<String> onChanged;
  final String? hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final bool isRequired;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      initialValue: initialValue,
      labelText: label,
      hintText: hintText,
      isRequired: isRequired,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      filled: true,
      fillColor: isDark ? AppColors.inputBgDark : AppColors.authInputFill,
      borderColor: isDark
          ? AppColors.inputBorderDark
          : AppColors.authInputBorder,
      focusedBorderColor: AppColors.primary,
    );
  }
}

class AuthResponsiveRow extends StatelessWidget {
  const AuthResponsiveRow({
    super.key,
    required this.children,
    this.spacing = 16,
  });

  final List<Widget> children;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    if (context.isMobileLayout || children.length == 1) {
      return Column(
        children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0) Gap(spacing.h),
            children[i],
          ],
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < children.length; i++) ...[
          if (i > 0) Gap(spacing.w),
          Expanded(child: children[i]),
        ],
      ],
    );
  }
}
