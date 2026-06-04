import 'dart:ui';

import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/shared/widgets/common/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AppDatePickerDialog extends StatefulWidget {
  const AppDatePickerDialog({
    super.key,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    required this.isDark,
  });

  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final bool isDark;

  static Future<DateTime?> show(
    BuildContext context, {
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return showDialog<DateTime>(
      context: context,
      barrierDismissible: true,
      builder: (context) => AppDatePickerDialog(
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate,
        isDark: isDark,
      ),
    );
  }

  @override
  State<AppDatePickerDialog> createState() => _AppDatePickerDialogState();
}

class _AppDatePickerDialogState extends State<AppDatePickerDialog> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();
    final backgroundColor = widget.isDark
        ? AppColors.cardBackgroundDark
        : AppColors.cardBackground;
    final textColor = widget.isDark
        ? context.themeTextPrimary
        : AppColors.textPrimary;
    final mutedTextColor = widget.isDark
        ? context.themeTextMuted
        : AppColors.textSecondary;
    final borderColor = widget.isDark
        ? AppColors.inputBorderDark
        : AppColors.borderGrey;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Container(
          width: 380.w,
          constraints: BoxConstraints(maxWidth: 400.w),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(color: borderColor),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowColor,
                blurRadius: 40,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(24.w, 32.h, 24.w, 24.h),
                decoration: BoxDecoration(
                  color: widget.isDark
                      ? AppColors.inputBgDark
                      : AppColors.primary.withValues(alpha: 0.05),
                  border: Border(
                    bottom: BorderSide(
                      color: widget.isDark
                          ? AppColors.inputBorderDark
                          : AppColors.inputBorder,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _selectedDate != null
                          ? DateFormat.y(locale).format(_selectedDate!)
                          : l10n.datePickerSelectYear,
                      style: context.textTheme.labelLarge?.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: mutedTextColor,
                      ),
                    ),
                    Gap(6.h),
                    Text(
                      _selectedDate != null
                          ? DateFormat.MMMEd(locale).format(_selectedDate!)
                          : l10n.datePickerSelectDate,
                      style: context.textTheme.headlineMedium?.copyWith(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w800,
                        color: widget.isDark
                            ? AppColors.textPrimaryDark
                            : AppColors.primary,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 4.h),
                child: SizedBox(
                  height: 310.h,
                  child: SfDateRangePicker(
                    initialSelectedDate: widget.initialDate ?? _selectedDate,
                    minDate: widget.firstDate,
                    maxDate: widget.lastDate,
                    selectionMode: DateRangePickerSelectionMode.single,
                    showNavigationArrow: true,
                    selectionShape: DateRangePickerSelectionShape.circle,
                    headerHeight: 50.h,
                    onSelectionChanged:
                        (DateRangePickerSelectionChangedArgs args) {
                          setState(() {
                            _selectedDate = args.value as DateTime?;
                          });
                        },
                    headerStyle: DateRangePickerHeaderStyle(
                      textAlign: TextAlign.center,
                      textStyle: context.textTheme.titleMedium?.copyWith(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: textColor,
                      ),
                      backgroundColor: AppColors.transparent,
                    ),
                    monthViewSettings: DateRangePickerMonthViewSettings(
                      dayFormat: 'EEE',
                      viewHeaderHeight: 40.h,
                      viewHeaderStyle: DateRangePickerViewHeaderStyle(
                        textStyle: context.textTheme.labelMedium?.copyWith(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: mutedTextColor,
                        ),
                      ),
                    ),
                    monthCellStyle: DateRangePickerMonthCellStyle(
                      textStyle: context.textTheme.bodyMedium?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                      disabledDatesTextStyle: context.textTheme.bodyMedium
                          ?.copyWith(
                            fontSize: 14.sp,
                            color: mutedTextColor.withValues(alpha: 0.4),
                          ),
                      todayTextStyle: context.textTheme.bodyMedium?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                      todayCellDecoration: BoxDecoration(
                        color: AppColors.transparent,
                        border: Border.all(
                          color: AppColors.primary,
                          width: 1.5,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                    selectionColor: AppColors.primary,
                    todayHighlightColor: AppColors.primary,
                    selectionTextStyle: context.textTheme.bodyMedium?.copyWith(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.cardBackground,
                    ),
                    backgroundColor: AppColors.transparent,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 24.h),
                child: Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        label: l10n.commonCancel,
                        type: AppButtonType.outline,
                        onPressed: () => Navigator.pop(context),
                        height: 48.h,
                      ),
                    ),
                    Gap(12.w),
                    Expanded(
                      child: AppButton(
                        label: l10n.commonConfirm,
                        onPressed: () {
                          Navigator.pop(
                            context,
                            _selectedDate ??
                                widget.initialDate ??
                                DateTime.now(),
                          );
                        },
                        backgroundColor: AppColors.primary,
                        height: 48.h,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
