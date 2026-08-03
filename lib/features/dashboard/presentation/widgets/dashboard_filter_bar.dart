import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_filters_controller.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_filters_state.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_jobs_provider.dart';
import 'package:career_portal/gen/assets.gen.dart';
import 'package:career_portal/shared/widgets/assets/app_asset.dart';
import 'package:career_portal/shared/widgets/common/app_select_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardFilterBar extends ConsumerWidget {
  const DashboardFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final filters = ref.watch(dashboardFiltersControllerProvider);
    final filtersController = ref.read(
      dashboardFiltersControllerProvider.notifier,
    );
    final locations = ref.watch(dashboardJobLocationsProvider);
    final departments = ref.watch(dashboardJobDepartmentsProvider);
    final employmentTypes = ref.watch(dashboardJobEmploymentTypesProvider);
    final isDark = context.isDark;
    final isMobile = context.isMobileLayout;
    final iconColor = isDark
        ? context.themeTextSecondary
        : AppColors.textSecondary;

    final locationItems = [DashboardFiltersState.allLocationsKey, ...locations];
    final departmentItems = [
      DashboardFiltersState.allDepartmentsKey,
      ...departments,
    ];
    final employmentTypeItems = [
      DashboardFiltersState.allEmploymentTypesKey,
      ...employmentTypes,
    ];

    final fields = [
      _DashboardFilterField(
        icon: AppAsset(
          assetPath: Assets.icons.dashboard.locationPin.path,
          width: 18.w,
          height: 18.w,
          color: iconColor,
        ),
        value:
            filters.selectedLocation ?? DashboardFiltersState.allLocationsKey,
        items: locationItems,
        itemLabelBuilder: (value) =>
            value == DashboardFiltersState.allLocationsKey
            ? l10n.dashboardFilterAllLocations
            : value,
        onChanged: filtersController.onLocationChanged,
        expand: isMobile,
      ),
      _DashboardFilterField(
        icon: AppAsset(
          assetPath: Assets.icons.dashboard.department.path,
          width: 18.w,
          height: 18.w,
          color: iconColor,
        ),
        value:
            filters.selectedDepartment ??
            DashboardFiltersState.allDepartmentsKey,
        items: departmentItems,
        itemLabelBuilder: (value) =>
            value == DashboardFiltersState.allDepartmentsKey
            ? l10n.dashboardFilterAllDepartments
            : value,
        onChanged: filtersController.onDepartmentChanged,
        expand: isMobile,
      ),
      _DashboardFilterField(
        icon: AppAsset(
          assetPath: Assets.icons.dashboard.clock.path,
          width: 18.w,
          height: 18.w,
          color: iconColor,
        ),
        value:
            filters.selectedEmploymentType ??
            DashboardFiltersState.allEmploymentTypesKey,
        items: employmentTypeItems,
        itemLabelBuilder: (value) =>
            value == DashboardFiltersState.allEmploymentTypesKey
            ? l10n.dashboardFilterAllEmploymentTypes
            : value,
        onChanged: filtersController.onEmploymentTypeChanged,
        expand: isMobile,
      ),
    ];

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.themeCardBackground,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: context.themeCardBorder),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: 16.w,
          vertical: 14.h,
        ),
        child: isMobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 12.h,
                children: fields,
              )
            : Wrap(
                spacing: 16.w,
                runSpacing: 12.h,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: fields,
              ),
      ),
    );
  }
}

class _DashboardFilterField extends StatelessWidget {
  const _DashboardFilterField({
    required this.icon,
    required this.value,
    required this.items,
    required this.itemLabelBuilder,
    required this.onChanged,
    this.expand = false,
  });

  final Widget icon;
  final String value;
  final List<String> items;
  final String Function(String) itemLabelBuilder;
  final ValueChanged<String?> onChanged;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final fieldWidth = context.responsiveFine(
      mobile: 220.w,
      tabletSmall: 220.w,
      tabletMedium: 240.w,
      tabletLarge: 250.w,
      desktop: 250.w,
    );

    final field = Row(
      children: [
        icon,
        SizedBox(width: 8.w),
        Expanded(
          child: AppSelectField<String>(
            value: value,
            items: items,
            itemLabelBuilder: itemLabelBuilder,
            onChanged: onChanged,
            fillColor: isDark
                ? AppColors.cardBackgroundGreyDark
                : AppColors.sidebarSearchBg,
            color: isDark ? AppColors.inputBorderDark : AppColors.borderGrey,
          ),
        ),
      ],
    );

    if (expand) return field;

    return SizedBox(width: fieldWidth, child: field);
  }
}
