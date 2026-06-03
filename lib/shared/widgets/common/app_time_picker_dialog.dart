import 'dart:ui';

import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/shared/widgets/common/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTimePickerDialog extends StatefulWidget {
  const AppTimePickerDialog({
    super.key,
    required this.initialTime,
    required this.isDark,
  });

  final TimeOfDay initialTime;
  final bool isDark;

  static Future<TimeOfDay?> show(
    BuildContext context, {
    required TimeOfDay initialTime,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return showDialog<TimeOfDay>(
      context: context,
      barrierDismissible: true,
      builder: (context) =>
          AppTimePickerDialog(initialTime: initialTime, isDark: isDark),
    );
  }

  @override
  State<AppTimePickerDialog> createState() => _AppTimePickerDialogState();
}

class _AppTimePickerDialogState extends State<AppTimePickerDialog> {
  late int _selectedHour;
  late int _selectedMinute;
  late bool _isAM;

  final TextEditingController _hourTextController = TextEditingController();
  final TextEditingController _minuteTextController = TextEditingController();

  bool _isEditingHour = false;
  bool _isEditingMinute = false;

  final double _boxHeight = 140.h;

  @override
  void initState() {
    super.initState();
    final hour = widget.initialTime.hour;
    _selectedMinute = widget.initialTime.minute;
    _isAM = hour < 12;
    _selectedHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
  }

  @override
  void dispose() {
    _hourTextController.dispose();
    _minuteTextController.dispose();
    super.dispose();
  }

  void _updateHour(int hour) {
    if (hour < 1) hour = 12;
    if (hour > 12) hour = 1;
    setState(() => _selectedHour = hour);
  }

  void _updateMinute(int minute) {
    if (minute < 0) minute = 59;
    if (minute > 59) minute = 0;
    setState(() => _selectedMinute = minute);
  }

  void _toggleAmPm(bool isAm) {
    if (_isAM != isAm) {
      setState(() => _isAM = isAm);
    }
  }

  TimeOfDay _getSelectedTime() {
    var hour = _selectedHour;
    if (!_isAM && hour != 12) {
      hour += 12;
    } else if (_isAM && hour == 12) {
      hour = 0;
    }
    return TimeOfDay(hour: hour, minute: _selectedMinute);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final backgroundColor = widget.isDark
        ? AppColors.cardBackgroundDark
        : AppColors.cardBackground;
    final textColor = widget.isDark
        ? context.themeTextPrimary
        : AppColors.textPrimary;
    final mutedTextColor = widget.isDark
        ? context.themeTextMuted
        : AppColors.textSecondary;
    final dividerColor = widget.isDark
        ? AppColors.onPrimary.withValues(alpha: 0.1)
        : AppColors.blackTextColor.withValues(alpha: 0.12);
    final borderColor = widget.isDark
        ? AppColors.onPrimary.withValues(alpha: 0.1)
        : AppColors.blackTextColor.withValues(alpha: 0.05);

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        backgroundColor: AppColors.transparent,
        elevation: 0,
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24.w, 24.h, 24.w, 16.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.timePickerTitle,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: textColor,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          l10n.timePickerSubtitle,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: mutedTextColor,
                          ),
                        ),
                      ],
                    ),
                    _buildTimeDisplay(l10n),
                  ],
                ),
              ),
              Divider(height: 1, color: dividerColor),
              Padding(
                padding: EdgeInsets.all(24.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildPickerColumn(
                      label: l10n.timePickerHourLabel,
                      value: _selectedHour,
                      min: 1,
                      max: 12,
                      isEditing: _isEditingHour,
                      controller: _hourTextController,
                      textColor: textColor,
                      onToggleEdit: (edit) {
                        setState(() {
                          _isEditingHour = edit;
                          if (edit) {
                            _hourTextController.text = _selectedHour.toString();
                          }
                        });
                      },
                      onChanged: _updateHour,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: 12.w,
                        end: 12.w,
                        top: 22.h,
                      ),
                      child: Text(
                        ':',
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w200,
                          color: textColor.withValues(alpha: 0.3),
                        ),
                      ),
                    ),
                    _buildPickerColumn(
                      label: l10n.timePickerMinuteLabel,
                      value: _selectedMinute,
                      min: 0,
                      max: 59,
                      isEditing: _isEditingMinute,
                      controller: _minuteTextController,
                      textColor: textColor,
                      onToggleEdit: (edit) {
                        setState(() {
                          _isEditingMinute = edit;
                          if (edit) {
                            _minuteTextController.text = _selectedMinute
                                .toString()
                                .padLeft(2, '0');
                          }
                        });
                      },
                      onChanged: _updateMinute,
                    ),
                    SizedBox(width: 32.w),
                    _buildPeriodSelector(l10n, textColor),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24.w, 0, 24.w, 24.h),
                child: Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        label: l10n.timePickerCancel,
                        type: AppButtonType.outline,
                        onPressed: () => Navigator.pop(context),
                        height: 44.h,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: AppButton(
                        label: l10n.timePickerUpdate,
                        onPressed: () =>
                            Navigator.pop(context, _getSelectedTime()),
                        backgroundColor: AppColors.primary,
                        height: 44.h,
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

  Widget _buildTimeDisplay(AppLocalizations l10n) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        '${_selectedHour.toString().padLeft(2, '0')}:${_selectedMinute.toString().padLeft(2, '0')} ${_isAM ? l10n.timePickerAm : l10n.timePickerPm}',
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildPickerColumn({
    required String label,
    required int value,
    required int min,
    required int max,
    required bool isEditing,
    required TextEditingController controller,
    required Color textColor,
    required ValueChanged<bool> onToggleEdit,
    required ValueChanged<int> onChanged,
  }) {
    final columnBorderColor = widget.isDark
        ? AppColors.onPrimary.withValues(alpha: 0.1)
        : AppColors.blackTextColor.withValues(alpha: 0.05);

    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
            color: textColor.withValues(alpha: 0.4),
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          width: 80.w,
          height: _boxHeight,
          decoration: BoxDecoration(
            color: widget.isDark ? AppColors.inputBgDark : AppColors.inputBg,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: columnBorderColor),
          ),
          child: Column(
            children: [
              _buildArrowButton(
                icon: Icons.keyboard_arrow_up_rounded,
                onTap: () => onChanged(value + 1),
                top: true,
                textColor: textColor,
              ),
              Expanded(
                child: Center(
                  child: isEditing
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: TextField(
                            controller: controller,
                            autofocus: true,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w700,
                              color: textColor,
                              letterSpacing: -1,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                            onSubmitted: (val) {
                              final newVal = int.tryParse(val);
                              if (newVal != null &&
                                  newVal >= min &&
                                  newVal <= max) {
                                onChanged(newVal);
                              }
                              onToggleEdit(false);
                            },
                            onTapOutside: (_) => onToggleEdit(false),
                          ),
                        )
                      : InkWell(
                          onTap: () => onToggleEdit(true),
                          child: Text(
                            value.toString().padLeft(2, '0'),
                            style: TextStyle(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w700,
                              color: textColor,
                              letterSpacing: -1,
                            ),
                          ),
                        ),
                ),
              ),
              _buildArrowButton(
                icon: Icons.keyboard_arrow_down_rounded,
                onTap: () => onChanged(value - 1),
                top: false,
                textColor: textColor,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildArrowButton({
    required IconData icon,
    required VoidCallback onTap,
    required bool top,
    required Color textColor,
  }) {
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.vertical(
          top: top ? Radius.circular(16.r) : Radius.zero,
          bottom: !top ? Radius.circular(16.r) : Radius.zero,
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Icon(
            icon,
            size: 20.sp,
            color: textColor.withValues(alpha: 0.3),
          ),
        ),
      ),
    );
  }

  Widget _buildPeriodSelector(AppLocalizations l10n, Color textColor) {
    final periodBorderColor = widget.isDark
        ? AppColors.onPrimary.withValues(alpha: 0.1)
        : AppColors.blackTextColor.withValues(alpha: 0.05);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          l10n.timePickerPeriodLabel,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
            color: textColor.withValues(alpha: 0.4),
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          width: 55.w,
          height: 100.h,
          padding: EdgeInsets.all(4.r),
          decoration: BoxDecoration(
            color: widget.isDark ? AppColors.inputBgDark : AppColors.inputBg,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: periodBorderColor),
          ),
          child: Column(
            children: [
              Expanded(
                child: _buildPeriodOption(
                  l10n.timePickerAm,
                  _isAM,
                  () => _toggleAmPm(true),
                  textColor,
                ),
              ),
              SizedBox(height: 4.h),
              Expanded(
                child: _buildPeriodOption(
                  l10n.timePickerPm,
                  !_isAM,
                  () => _toggleAmPm(false),
                  textColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPeriodOption(
    String label,
    bool isSelected,
    VoidCallback onTap,
    Color textColor,
  ) {
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.r),
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.transparent,
            borderRadius: BorderRadius.circular(8.r),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
              color: isSelected
                  ? AppColors.onPrimary
                  : (widget.isDark
                        ? context.themeTextMuted
                        : AppColors.textSecondary),
            ),
          ),
        ),
      ),
    );
  }
}
