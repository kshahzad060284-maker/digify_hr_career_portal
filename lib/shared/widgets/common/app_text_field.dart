import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/gen/assets.gen.dart';
import 'package:career_portal/shared/widgets/assets/app_asset.dart';
import 'package:career_portal/shared/widgets/common/app_time_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart' show DateFormat;

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.isRequired = false,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.validator,
    this.maxLines = 1,
    this.minLines,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.filled = false,
    this.textInputAction,
    this.showBorder = true,
    this.onChanged,
    this.onSubmitted,
    this.readOnly = false,
    this.onTap,
    this.enabled = true,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.inputFormatters,
    this.autovalidateMode,
    this.focusNode,
    this.initialValue,
    this.fontSize,
    this.contentPadding,
  });

  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final bool isRequired;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final int? maxLines;
  final int? minLines;
  final Color? fillColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final bool filled;
  final TextInputAction? textInputAction;
  final bool showBorder;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool readOnly;
  final VoidCallback? onTap;
  final bool enabled;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final List<TextInputFormatter>? inputFormatters;
  final AutovalidateMode? autovalidateMode;
  final FocusNode? focusNode;
  final String? initialValue;
  final double? fontSize;
  final EdgeInsetsGeometry? contentPadding;

  factory AppTextField.search({
    TextEditingController? controller,
    String? hintText,
    String? labelText,
    bool filled = false,
    Color? fillColor,
    Color? borderColor,
    bool showBorder = true,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    EdgeInsetsGeometry? contentPadding,
    double? fontSize,
  }) {
    return AppTextField(
      controller: controller,
      hintText: hintText,
      labelText: labelText,
      filled: filled,
      fillColor: fillColor ?? AppColors.transparent,
      borderColor: borderColor,
      showBorder: showBorder,
      contentPadding: contentPadding,
      fontSize: fontSize,
      prefixIcon: Padding(
        padding: EdgeInsetsDirectional.only(start: 12.w, end: 8.w),
        child: AppAsset(
          assetPath: Assets.icons.dashboard.magnifierSearch.path,
          width: 20,
          height: 20,
          color: AppColors.textMuted,
        ),
      ),
      textInputAction: TextInputAction.search,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );
  }

  factory AppTextField.normal({
    TextEditingController? controller,
    String? hintText,
    String? labelText,
    bool isRequired = false,
    bool enabled = true,
    ValueChanged<String>? onChanged,
    String? Function(String?)? validator,
    int? maxLines = 1,
    bool readOnly = false,
    TextDirection? textDirection,
    TextAlign textAlign = TextAlign.start,
    FocusNode? focusNode,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return AppTextField(
      controller: controller,
      hintText: hintText,
      labelText: labelText,
      isRequired: isRequired,
      enabled: enabled,
      onChanged: onChanged,
      validator: validator,
      maxLines: maxLines,
      readOnly: readOnly,
      textDirection: textDirection,
      textAlign: textAlign,
      focusNode: focusNode,
      inputFormatters: inputFormatters,
      filled: true,
      fillColor: AppColors.transparent,
    );
  }

  factory AppTextField.number({
    required TextEditingController controller,
    required String labelText,
    String? hintText,
    bool isRequired = false,
    bool enabled = true,
    bool readOnly = false,
    ValueChanged<String>? onChanged,
    String? Function(String?)? validator,
    List<TextInputFormatter>? inputFormatters,
    FocusNode? focusNode,
    bool? filled,
    Color? fillColor,
  }) {
    return AppTextField(
      controller: controller,
      labelText: labelText,
      hintText: hintText,
      isRequired: isRequired,
      enabled: enabled,
      readOnly: readOnly,
      onChanged: onChanged,
      validator: validator,
      keyboardType: TextInputType.number,
      inputFormatters:
          inputFormatters ?? [FilteringTextInputFormatter.digitsOnly],
      focusNode: focusNode,
      filled: filled ?? true,
      fillColor: fillColor ?? AppColors.transparent,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.8.w),
    );
  }

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscureText;
  late TextEditingController _effectiveController;
  bool _ownsController = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _bindController(initial: true);
  }

  @override
  void didUpdateWidget(covariant AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      if (_ownsController) {
        _effectiveController.dispose();
      }
      _bindController(initial: true);
      return;
    }
    if (widget.controller == null &&
        oldWidget.initialValue != widget.initialValue) {
      final nextValue = widget.initialValue ?? '';
      if (_effectiveController.text != nextValue) {
        _effectiveController.value = TextEditingValue(
          text: nextValue,
          selection: TextSelection.collapsed(offset: nextValue.length),
        );
      }
    }
  }

  void _bindController({required bool initial}) {
    if (widget.controller != null) {
      _effectiveController = widget.controller!;
      _ownsController = false;
      if (initial &&
          (widget.initialValue ?? '').isNotEmpty &&
          _effectiveController.text.isEmpty) {
        final value = widget.initialValue!;
        _effectiveController.value = TextEditingValue(
          text: value,
          selection: TextSelection.collapsed(offset: value.length),
        );
      }
      return;
    }
    _effectiveController = TextEditingController(text: widget.initialValue);
    _ownsController = true;
  }

  @override
  void dispose() {
    if (_ownsController) {
      _effectiveController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final isMobile = context.isMobileLayout;
    final effectiveFillColor =
        widget.fillColor ??
        (isDark ? AppColors.inputBgDark : AppColors.transparent);
    final effectiveBorderColor =
        widget.borderColor ??
        (isDark ? AppColors.inputBorderDark : AppColors.inputBorder);
    final effectiveFocusedColor =
        widget.focusedBorderColor ?? AppColors.primary;
    final obscureIconSize = context.responsiveFine<double>(
      mobile: 16,
      tabletSmall: 16.5,
      tabletMedium: 17,
      tabletLarge: 17.5,
      desktop: 18,
    );
    final obscureIconPadding = context.responsiveFine<double>(
      mobile: 2,
      tabletSmall: 2,
      tabletMedium: 2.5,
      tabletLarge: 3,
      desktop: 3,
    );
    final obscureIconConstraints = BoxConstraints.tightFor(
      width: context.responsiveFine<double>(
        mobile: 28,
        tabletSmall: 30,
        tabletMedium: 32,
        tabletLarge: 32,
        desktop: 34,
      ),
      height: context.responsiveFine<double>(
        mobile: 28,
        tabletSmall: 30,
        tabletMedium: 32,
        tabletLarge: 32,
        desktop: 34,
      ),
    );
    final fieldMinHeight = context.responsiveFine<double>(
      mobile: 40,
      tabletSmall: 44,
      tabletMedium: 46,
      tabletLarge: 40,
      desktop: 50,
    );
    final fieldVerticalPadding = context.responsiveFine<double>(
      mobile: 13.8,
      tabletSmall: 14.5,
      tabletMedium: 15,
      tabletLarge: 15.5,
      desktop: 16,
    );

    final field = TextFormField(
      controller: _effectiveController,
      obscureText: widget.obscureText ? _obscureText : false,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      maxLines: widget.obscureText ? 1 : widget.maxLines,
      minLines: widget.minLines,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      readOnly: widget.readOnly,
      enabled: widget.enabled,
      onTap: widget.onTap,
      textInputAction: widget.textInputAction,
      inputFormatters: widget.inputFormatters,
      textAlign: widget.textAlign,
      textDirection: widget.textDirection,
      autovalidateMode: widget.autovalidateMode,
      focusNode: widget.focusNode,
      style: TextStyle(
        fontSize: widget.fontSize ?? 15.sp,
        color: isDark ? context.themeTextPrimary : AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        isCollapsed: false,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        suffixIcon: widget.obscureText && widget.suffixIcon == null
            ? IconButton(
                iconSize: obscureIconSize.w,
                padding: EdgeInsets.all(obscureIconPadding.w),
                constraints: obscureIconConstraints,
                visualDensity: isMobile
                    ? VisualDensity.compact
                    : VisualDensity.standard,
                splashRadius: obscureIconSize.r,
                icon: Icon(
                  _obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: obscureIconSize.sp,
                  color: AppColors.textPlaceholder,
                ),
                onPressed: () => setState(() => _obscureText = !_obscureText),
              )
            : widget.suffixIcon,
        filled: widget.filled,
        fillColor: effectiveFillColor,
        isDense: true,
        constraints: widget.maxLines == 1
            ? BoxConstraints(
                minHeight: fieldMinHeight.w,
                maxHeight: fieldMinHeight.w,
              )
            : null,
        contentPadding:
            widget.contentPadding ??
            EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: fieldVerticalPadding.w,
            ),
        hintStyle: TextStyle(
          fontSize: widget.fontSize ?? 15.sp,
          height: 1.0,
          color: isDark ? context.themeTextMuted : AppColors.textPlaceholder,
        ),
        errorStyle: TextStyle(
          fontSize: 12.sp,
          color: AppColors.error,
          height: 1.2,
        ),
        border: _buildBorder(10.r, effectiveBorderColor),
        enabledBorder: _buildBorder(10.r, effectiveBorderColor),
        disabledBorder: _buildBorder(10.r, effectiveBorderColor),
        focusedBorder: _buildBorder(10.r, effectiveFocusedColor, width: 1.5),
        errorBorder: _buildBorder(10.r, AppColors.error),
        focusedErrorBorder: _buildBorder(10.r, AppColors.error, width: 1.5),
      ),
    );

    if (widget.labelText != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: widget.labelText,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark
                        ? context.themeTextPrimary
                        : AppColors.inputLabel,
                  ),
                ),
                if (widget.isRequired)
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
          SizedBox(height: 40.w, child: field),
        ],
      );
    }

    return SizedBox(height: 40.w, child: field);
  }

  InputBorder _buildBorder(double radius, Color color, {double width = 1.0}) {
    // Use OutlineInputBorder (not InputBorder.none) so isOutline stays true.
    // InputBorder.none triggers InputDecorator to read labelStyle.fontSize! and
    // crashes on web when there is no label.
    if (!widget.showBorder) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide.none,
      );
    }
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: color, width: width.w),
    );
  }
}

class AppTextArea extends StatefulWidget {
  const AppTextArea({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.isRequired = false,
    this.maxLines = 3,
    this.minLines,
    this.validator,
    this.onChanged,
    this.readOnly = false,
    this.enabled = true,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.inputFormatters,
    this.showCharacterCount = false,
    this.maxLength,
    this.characterCountFormatter,
    this.initialValue,
    this.fillColor,
  });

  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final bool isRequired;
  final int maxLines;
  final int? minLines;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final bool readOnly;
  final bool enabled;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final List<TextInputFormatter>? inputFormatters;
  final bool showCharacterCount;
  final int? maxLength;
  final String Function(int)? characterCountFormatter;
  final String? initialValue;
  final Color? fillColor;

  @override
  State<AppTextArea> createState() => _AppTextAreaState();
}

class _AppTextAreaState extends State<AppTextArea> {
  late TextEditingController _internalController;
  bool _isInternalController = false;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _internalController = TextEditingController(text: widget.initialValue);
      _isInternalController = true;
    } else {
      _internalController = widget.controller!;
    }
    if (widget.showCharacterCount) {
      _internalController.addListener(_onTextChanged);
    }
  }

  @override
  void dispose() {
    if (widget.showCharacterCount) {
      _internalController.removeListener(_onTextChanged);
    }
    if (_isInternalController) {
      _internalController.dispose();
    }
    super.dispose();
  }

  void _onTextChanged() {
    if (widget.showCharacterCount) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final effectiveMinLines = widget.minLines ?? widget.maxLines;
    final currentLength = _internalController.text.length;
    final maxLength = widget.maxLength;
    final isOverLimit = maxLength != null && currentLength > maxLength;
    final fieldVerticalPadding = context.responsiveFine<double>(
      mobile: 13.8,
      tabletSmall: 14.5,
      tabletMedium: 15,
      tabletLarge: 15.5,
      desktop: 16,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null)
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: widget.labelText,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark
                        ? context.themeTextPrimary
                        : AppColors.inputLabel,
                  ),
                ),
                if (widget.isRequired)
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
        if (widget.labelText != null) SizedBox(height: 8.w),
        TextFormField(
          controller: _internalController,
          maxLines: widget.maxLines,
          minLines: effectiveMinLines,
          readOnly: widget.readOnly,
          enabled: widget.enabled,
          maxLength: widget.maxLength,
          onChanged: (value) {
            if (widget.showCharacterCount) {
              setState(() {});
            }
            widget.onChanged?.call(value);
          },
          textAlign: widget.textDirection == TextDirection.rtl
              ? TextAlign.right
              : widget.textAlign,
          textDirection: widget.textDirection,
          inputFormatters: widget.inputFormatters,
          style: TextStyle(
            fontSize: 15.sp,
            color: isDark ? context.themeTextPrimary : AppColors.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            filled: true,
            fillColor:
                widget.fillColor ??
                (isDark ? AppColors.inputBgDark : AppColors.transparent),
            isDense: false,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: fieldVerticalPadding.w,
            ),
            hintStyle: TextStyle(
              fontSize: 15.sp,
              height: 1.0,
              color: isDark
                  ? context.themeTextMuted
                  : AppColors.textPlaceholder,
            ),
            border: _buildBorder(isDark, AppColors.inputBorder),
            enabledBorder: _buildBorder(
              isDark,
              isDark ? AppColors.inputBorderDark : AppColors.inputBorder,
            ),
            focusedBorder: _buildBorder(isDark, AppColors.primary, width: 1.5),
            errorBorder: _buildBorder(isDark, AppColors.error),
            focusedErrorBorder: _buildBorder(
              isDark,
              AppColors.error,
              width: 1.5,
            ),
            counterText: widget.showCharacterCount ? '' : null,
          ),
          validator: widget.validator,
        ),
        if (widget.showCharacterCount) ...[
          SizedBox(height: 2.h),
          Text(
            widget.characterCountFormatter != null
                ? widget.characterCountFormatter!(currentLength)
                : maxLength != null
                ? '$currentLength / $maxLength'
                : '$currentLength',
            style: context.textTheme.bodySmall?.copyWith(
              color: isOverLimit ? AppColors.error : AppColors.textSecondary,
              fontSize: 11.8.sp,
            ),
          ),
        ],
      ],
    );
  }

  OutlineInputBorder _buildBorder(
    bool isDark,
    Color color, {
    double width = 1.0,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(
        color: isDark && color == AppColors.inputBorder
            ? AppColors.inputBorderDark
            : color,
        width: width.w,
      ),
    );
  }
}

class AppDateField extends StatefulWidget {
  const AppDateField({
    super.key,
    required this.label,
    this.hintText,
    this.isRequired = true,
    this.calendarIconPath,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.onDateSelected,
    this.fillColor,
    this.readOnly = false,
    this.suffixIcon,
    this.displayTextOverride,
  });

  final String label;
  final String? hintText;
  final bool isRequired;
  final String? calendarIconPath;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final ValueChanged<DateTime>? onDateSelected;
  final Color? fillColor;
  final bool readOnly;
  final Widget? suffixIcon;
  final String? displayTextOverride;

  @override
  State<AppDateField> createState() => _AppDateFieldState();
}

class _AppDateFieldState extends State<AppDateField> {
  final TextEditingController _controller = TextEditingController();
  DateTime? _date;

  bool get _pickerSuppressed {
    final override = widget.displayTextOverride?.trim();
    return override != null && override.isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    _syncFromWidget();
  }

  @override
  void didUpdateWidget(covariant AppDateField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialDate != oldWidget.initialDate ||
        widget.displayTextOverride != oldWidget.displayTextOverride) {
      _syncFromWidget();
    }
  }

  void _syncFromWidget() {
    final override = widget.displayTextOverride?.trim();
    if (override != null && override.isNotEmpty) {
      _controller.text = override;
      return;
    }
    if (widget.initialDate != null) {
      _date = widget.initialDate;
      _controller.text = DateFormat('dd/MM/yyyy').format(widget.initialDate!);
    } else {
      _date = null;
      _controller.text = '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _openDatePicker() async {
    final firstDate = widget.firstDate ?? DateTime(1900);
    final lastDate = widget.lastDate ?? DateTime.now();
    var initialDate = _date ?? DateTime.now();

    if (initialDate.isBefore(firstDate)) {
      initialDate = firstDate;
    } else if (initialDate.isAfter(lastDate)) {
      initialDate = lastDate;
    }

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (picked != null && mounted) {
      setState(() {
        _date = picked;
        _controller.text = DateFormat('dd/MM/yyyy').format(picked);
      });
      widget.onDateSelected?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final iconPath =
        widget.calendarIconPath ?? Assets.icons.jobDetail.calendar.path;

    return AppTextField(
      labelText: widget.label,
      isRequired: widget.isRequired,
      controller: _controller,
      hintText: widget.hintText,
      readOnly: true,
      onTap: widget.readOnly || _pickerSuppressed ? null : _openDatePicker,
      filled: widget.fillColor != null,
      fillColor: widget.fillColor,
      suffixIcon: widget.suffixIcon,
      prefixIcon: Padding(
        padding: EdgeInsetsDirectional.only(start: 12.w, end: 8.w),
        child: AppAsset(
          assetPath: iconPath,
          width: 20.w,
          height: 20.h,
          color: isDark ? AppColors.textSecondaryDark : AppColors.textMuted,
        ),
      ),
    );
  }
}

class AppTimePickerField extends StatefulWidget {
  const AppTimePickerField({
    super.key,
    required this.label,
    this.hintText,
    this.isRequired = true,
    this.value,
    this.initialTime = const TimeOfDay(hour: 8, minute: 0),
    this.onTimeSelected,
    this.fillColor,
    this.readOnly = false,
  });

  final String label;
  final String? hintText;
  final bool isRequired;
  final TimeOfDay? value;
  final TimeOfDay initialTime;
  final ValueChanged<TimeOfDay>? onTimeSelected;
  final Color? fillColor;
  final bool readOnly;

  static String formatTimeOfDay(TimeOfDay time) {
    final hour = time.hour == 0
        ? 12
        : (time.hour > 12 ? time.hour - 12 : time.hour);
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour < 12 ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  @override
  State<AppTimePickerField> createState() => _AppTimePickerFieldState();
}

class _AppTimePickerFieldState extends State<AppTimePickerField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _syncController();
  }

  @override
  void didUpdateWidget(covariant AppTimePickerField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _syncController();
    }
  }

  void _syncController() {
    if (widget.value != null) {
      _controller.text = AppTimePickerField.formatTimeOfDay(widget.value!);
    } else {
      _controller.text = '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _openTimePicker() async {
    final picked = await AppTimePickerDialog.show(
      context,
      initialTime: widget.value ?? widget.initialTime,
    );
    if (picked != null && mounted) {
      setState(() {
        _controller.text = AppTimePickerField.formatTimeOfDay(picked);
      });
      widget.onTimeSelected?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final l10n = AppLocalizations.of(context)!;

    return AppTextField(
      labelText: widget.label,
      isRequired: widget.isRequired,
      controller: _controller,
      hintText: widget.hintText ?? l10n.timePickerSelectHint,
      readOnly: true,
      onTap: widget.readOnly ? null : _openTimePicker,
      filled: widget.fillColor != null,
      fillColor: widget.fillColor,
      prefixIcon: Padding(
        padding: EdgeInsetsDirectional.only(start: 12.w, end: 8.w),
        child: AppAsset(
          assetPath: Assets.icons.dashboard.clock.path,
          width: 20.w,
          height: 20.h,
          color: isDark ? AppColors.textSecondaryDark : AppColors.textMuted,
        ),
      ),
    );
  }
}
