import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/core/theme/app_shadows.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AppSelectFieldWithLabel<T> extends StatelessWidget {
  const AppSelectFieldWithLabel({
    super.key,
    required this.label,
    required this.items,
    required this.itemLabelBuilder,
    this.hint,
    this.value,
    this.onChanged,
    this.bgColor,
    this.isRequired = false,
    this.fillColor,
  });

  final String label;
  final String? hint;
  final T? value;
  final List<T> items;
  final String Function(T) itemLabelBuilder;
  final ValueChanged<T?>? onChanged;
  final bool isRequired;
  final Color? bgColor;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: label,
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
                    color: AppColors.error,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
        ),
        Gap(8.h),
        _AppSelectFieldBody<T>(
          hint: hint,
          items: items,
          itemLabelBuilder: itemLabelBuilder,
          value: value,
          onChanged: onChanged,
          fillColor: fillColor ?? bgColor,
        ),
      ],
    );
  }
}

class AppSelectField<T> extends StatefulWidget {
  const AppSelectField({
    super.key,
    this.label,
    required this.items,
    required this.itemLabelBuilder,
    this.hint,
    this.value,
    this.onChanged,
    this.isRequired = false,
    this.color,
    this.fillColor,
  });

  final String? label;
  final String? hint;
  final T? value;
  final List<T> items;
  final String Function(T) itemLabelBuilder;
  final ValueChanged<T?>? onChanged;
  final bool isRequired;
  final Color? color;
  final Color? fillColor;

  @override
  State<AppSelectField<T>> createState() => _AppSelectFieldState<T>();
}

class _AppSelectFieldState<T> extends State<AppSelectField<T>> {
  @override
  Widget build(BuildContext context) {
    return _AppSelectFieldBody<T>(
      hint: widget.hint,
      items: widget.items,
      itemLabelBuilder: widget.itemLabelBuilder,
      value: widget.value,
      onChanged: widget.onChanged,
      fillColor: widget.fillColor ?? widget.color,
    );
  }
}

class _AppSelectFieldBody<T> extends StatefulWidget {
  const _AppSelectFieldBody({
    required this.items,
    required this.itemLabelBuilder,
    this.hint,
    this.value,
    this.onChanged,
    this.fillColor,
  });

  final String? hint;
  final T? value;
  final List<T> items;
  final String Function(T) itemLabelBuilder;
  final ValueChanged<T?>? onChanged;
  final Color? fillColor;

  @override
  State<_AppSelectFieldBody<T>> createState() => _AppSelectFieldBodyState<T>();
}

class _AppSelectFieldBodyState<T> extends State<_AppSelectFieldBody<T>> {
  late final ValueNotifier<T?> _valueNotifier;

  @override
  void initState() {
    super.initState();
    _valueNotifier = ValueNotifier<T?>(widget.value);
  }

  @override
  void didUpdateWidget(covariant _AppSelectFieldBody<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _valueNotifier.value = widget.value;
    }
  }

  @override
  void dispose() {
    _valueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final effectiveFillColor =
        widget.fillColor ??
        (isDark ? AppColors.inputBgDark : AppColors.transparent);
    final effectiveTextColor = isDark
        ? context.themeTextPrimary
        : AppColors.textPrimary;
    final effectiveHintColor = isDark
        ? context.themeTextMuted
        : AppColors.textPlaceholder;
    final effectiveBorderColor = isDark
        ? AppColors.inputBorderDark
        : AppColors.inputBorder;

    final safeItems =
        widget.value != null && !widget.items.contains(widget.value)
        ? [widget.value as T, ...widget.items]
        : widget.items;

    return SizedBox(
      height: 40.w,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<T>(
          isExpanded: true,
          hint: Text(
            widget.hint ?? 'Select an option',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: effectiveHintColor),
          ),
          items: safeItems
              .map(
                (item) => DropdownItem<T>(
                  value: item,
                  height: 40.w,
                  child: Text(
                    widget.itemLabelBuilder(item),
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: effectiveTextColor),
                  ),
                ),
              )
              .toList(),
          valueListenable: _valueNotifier,
          onChanged: (value) {
            _valueNotifier.value = value;
            widget.onChanged?.call(value);
          },
          buttonStyleData: ButtonStyleData(
            height: 40.w,
            padding: EdgeInsetsDirectional.only(start: 4.w, end: 12.w),
            decoration: BoxDecoration(
              color: effectiveFillColor,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: effectiveBorderColor, width: 1.0.w),
            ),
          ),
          iconStyleData: IconStyleData(
            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 24.sp,
              color: isDark
                  ? AppColors.textPlaceholderDark
                  : AppColors.textPlaceholder,
            ),
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 300.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: isDark
                  ? AppColors.cardBackgroundDark
                  : AppColors.cardBackground,
              boxShadow: AppShadows.primaryShadow,
            ),
            scrollbarTheme: ScrollbarThemeData(
              radius: Radius.circular(10.r),
              thickness: WidgetStateProperty.all(6),
              thumbVisibility: WidgetStateProperty.all(true),
            ),
          ),
          menuItemStyleData: MenuItemStyleData(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
          ),
        ),
      ),
    );
  }
}
