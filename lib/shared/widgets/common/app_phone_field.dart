import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/core/utils/field_formatters.dart';
import 'package:career_portal/core/utils/phone_number_utils.dart';
import 'package:career_portal/shared/widgets/common/app_text_field.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AppPhoneField extends StatelessWidget {
  const AppPhoneField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.onDialCodeChanged,
    required this.onNumberChanged,
    this.isRequired = false,
    this.initialDialCode,
    this.initialNumber,
    this.prefixIcon,
    this.inputFormatters,
    this.fillColor,
  });

  final String labelText;
  final String hintText;
  final bool isRequired;
  final String? initialDialCode;
  final String? initialNumber;
  final ValueChanged<String> onDialCodeChanged;
  final ValueChanged<String> onNumberChanged;
  final Widget? prefixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = context.isDark;
    final borderColor = isDark
        ? AppColors.inputBorderDark
        : AppColors.inputBorder;
    final textColor = isDark ? context.themeTextPrimary : AppColors.textPrimary;
    final selection = PhoneNumberUtils.initialSelectionForPicker(
      initialDialCode,
    );
    final effectiveFillColor =
        fillColor ?? (isDark ? AppColors.inputBgDark : AppColors.authInputFill);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
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
        Gap(8.h),
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: borderColor, width: 1.w),
            color: effectiveFillColor,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CountryCodePicker(
                onChanged: (country) => onDialCodeChanged(
                  country.dialCode ?? PhoneNumberUtils.defaultDialCode,
                ),
                initialSelection: selection,
                favorite: PhoneNumberUtils.gccFavoriteDialCodes,
                showCountryOnly: false,
                showOnlyCountryWhenClosed: false,
                alignLeft: false,
                showDropDownButton: false,
                showFlag: false,
                showFlagDialog: true,
                padding: EdgeInsetsDirectional.only(start: 8.w, end: 2.w),
                textStyle: TextStyle(
                  fontSize: 15.sp,
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
                dialogTextStyle: TextStyle(fontSize: 15.sp, color: textColor),
                searchStyle: TextStyle(fontSize: 15.sp, color: textColor),
                dialogBackgroundColor: isDark
                    ? AppColors.cardBackgroundDark
                    : AppColors.cardBackground,
                boxDecoration: BoxDecoration(
                  color: isDark
                      ? AppColors.cardBackgroundDark
                      : AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                searchDecoration: InputDecoration(
                  hintText: l10n.phoneCountrySearchHint,
                  hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondary,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 20.sp,
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondary,
                  ),
                  filled: true,
                  fillColor: isDark
                      ? AppColors.inputBgDark
                      : AppColors.sidebarSearchBg,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                      color: isDark
                          ? AppColors.inputBorderDark
                          : AppColors.inputBorder,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                      color: isDark
                          ? AppColors.inputBorderDark
                          : AppColors.inputBorder,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                      color: AppColors.primary,
                      width: 1.5.w,
                    ),
                  ),
                ),
                barrierColor: Colors.black54,
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 16.sp,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondary,
              ),
              Gap(4.w),
              Container(width: 1.w, height: 28.h, color: borderColor),
              Expanded(
                child: AppTextField(
                  hintText: hintText,
                  keyboardType: TextInputType.phone,
                  prefixIcon: prefixIcon,
                  initialValue: initialNumber,
                  onChanged: onNumberChanged,
                  inputFormatters:
                      inputFormatters ?? FieldFormat.phoneFormatters,
                  filled: true,
                  fillColor: AppColors.transparent,
                  showBorder: false,
                  borderColor: AppColors.transparent,
                  focusedBorderColor: AppColors.transparent,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
