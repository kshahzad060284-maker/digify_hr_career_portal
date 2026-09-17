import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/core/theme/app_shadows.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_filters_controller.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_filters_state.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_jobs_provider.dart';
import 'package:career_portal/shared/widgets/common/app_button.dart';
import 'package:career_portal/shared/widgets/common/app_capsule.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class DashboardFilterDropdowns extends ConsumerWidget {
  const DashboardFilterDropdowns({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final filters = ref.watch(dashboardFiltersControllerProvider);
    final options = ref.watch(dashboardFilterOptionsProvider);
    final ctrl = ref.read(dashboardFiltersControllerProvider.notifier);

    final pills = [
      _FilterPill<String>(
        label: l10n.dashboardFilterLocationLabel,
        value: filters.locationValue,
        allKey: DashboardFiltersState.allLocationsKey,
        items: options.locations,
        itemLabelBuilder: (v) => v == DashboardFiltersState.allLocationsKey
            ? l10n.dashboardFilterAllLocations
            : v,
        onChanged: ctrl.onLocationChanged,
      ),
      _FilterPill<String>(
        label: l10n.dashboardFilterDepartmentLabel,
        value: filters.departmentValue,
        allKey: DashboardFiltersState.allDepartmentsKey,
        items: options.departments,
        itemLabelBuilder: (v) => v == DashboardFiltersState.allDepartmentsKey
            ? l10n.dashboardFilterAllDepartments
            : v,
        onChanged: ctrl.onDepartmentChanged,
      ),
      _FilterPill<String>(
        label: l10n.dashboardFilterEmploymentTypeLabel,
        value: filters.employmentTypeValue,
        allKey: DashboardFiltersState.allEmploymentTypesKey,
        items: options.employmentTypes,
        itemLabelBuilder: (v) =>
            v == DashboardFiltersState.allEmploymentTypesKey
            ? l10n.dashboardFilterAllEmploymentTypes
            : v,
        onChanged: ctrl.onEmploymentTypeChanged,
      ),
    ];

    if (context.isMobileLayout) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (var i = 0; i < pills.length; i++) ...[
              if (i > 0) const SizedBox(width: 10),
              pills[i],
            ],
          ],
        ),
      );
    }

    return Wrap(spacing: 12, runSpacing: 10, children: pills);
  }
}

class DashboardActiveFilters extends ConsumerWidget {
  const DashboardActiveFilters({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(dashboardFiltersControllerProvider);
    if (!filters.hasActiveFilters) return const SizedBox.shrink();

    final ctrl = ref.read(dashboardFiltersControllerProvider.notifier);
    final l10n = AppLocalizations.of(context)!;
    final isDark = context.isDark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: [
                  for (final filter in filters.activeFilters)
                    AppCapsule(
                      label: filter.label,
                      icon: Icons.close_rounded,
                      onTap: () => ctrl.clear(filter.type),
                      backgroundColor: isDark
                          ? AppColors.primary.withValues(alpha: 0.16)
                          : AppColors.sidebarActiveBg,
                      textColor: isDark
                          ? AppColors.primaryLight
                          : AppColors.sidebarActiveText,
                      borderColor: AppColors.primary.withValues(
                        alpha: isDark ? 0.35 : 0.2,
                      ),
                      textStyle: context.textTheme.bodySmall?.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? AppColors.primaryLight
                            : AppColors.sidebarActiveText,
                      ),
                    ),
                ],
              ),
            ),
            Gap(8.w),
            AppButton.text(
              label: l10n.dashboardFilterClearAll,
              onPressed: ctrl.clearAll,
              fontSize: 13.sp,
              foregroundColor: context.themeTextSecondary,
            ),
          ],
        ),
        Gap(12.h),
      ],
    );
  }
}

class _FilterPill<T> extends StatefulWidget {
  const _FilterPill({
    required this.label,
    required this.value,
    required this.allKey,
    required this.items,
    required this.itemLabelBuilder,
    this.onChanged,
  });

  final String label;
  final T? value;
  final T allKey;
  final List<T> items;
  final String Function(T) itemLabelBuilder;
  final ValueChanged<T?>? onChanged;

  @override
  State<_FilterPill<T>> createState() => _FilterPillState<T>();
}

class _FilterPillState<T> extends State<_FilterPill<T>> {
  late final ValueNotifier<T?> _notifier;

  T? get _displayValue => widget.value != null && widget.value != widget.allKey
      ? widget.value
      : null;

  @override
  void initState() {
    super.initState();
    _notifier = ValueNotifier<T?>(_displayValue);
  }

  @override
  void didUpdateWidget(covariant _FilterPill<T> old) {
    super.didUpdateWidget(old);
    if (old.value != widget.value) _notifier.value = _displayValue;
  }

  @override
  void dispose() {
    _notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final isActive = widget.value != null && widget.value != widget.allKey;

    final bgColor = isActive
        ? (isDark
              ? AppColors.primary.withValues(alpha: 0.14)
              : AppColors.sidebarActiveBg)
        : (isDark ? AppColors.cardBackgroundDark : AppColors.cardBackground);
    final textColor = isActive
        ? (isDark ? AppColors.primaryLight : AppColors.sidebarActiveText)
        : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimary);
    final iconColor = isActive
        ? AppColors.primary
        : (isDark ? AppColors.textPlaceholderDark : AppColors.textPlaceholder);
    final borderColor = isActive
        ? AppColors.primary.withValues(alpha: isDark ? 0.4 : 0.3)
        : (isDark ? AppColors.cardBorderDark : AppColors.cardBorder);

    final safeItems =
        widget.value != null && !widget.items.contains(widget.value)
        ? [widget.value as T, ...widget.items]
        : widget.items;

    return Container(
      constraints: const BoxConstraints(minWidth: 120, maxWidth: 240),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowSubtle,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<T>(
          isExpanded: true,
          valueListenable: _notifier,
          hint: Text(
            widget.label,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
          items: safeItems
              .map(
                (item) => DropdownItem<T>(
                  value: item,
                  height: 40,
                  child: Text(
                    widget.itemLabelBuilder(item),
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimary,
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: (v) {
            _notifier.value = v == widget.allKey ? null : v;
            widget.onChanged?.call(v);
          },
          buttonStyleData: ButtonStyleData(
            height: 40,
            padding: EdgeInsetsDirectional.symmetric(horizontal: 12.w),
            decoration: const BoxDecoration(color: AppColors.transparent),
          ),
          iconStyleData: IconStyleData(
            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: iconColor,
              size: 20,
            ),
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
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
