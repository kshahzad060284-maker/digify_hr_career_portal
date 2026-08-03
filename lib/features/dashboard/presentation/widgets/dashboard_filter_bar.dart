import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/core/theme/app_shadows.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_filters_controller.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_filters_state.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_jobs_provider.dart';
import 'package:career_portal/shared/widgets/common/app_button.dart';
import 'package:career_portal/shared/widgets/common/app_capsule.dart';
import 'package:career_portal/shared/widgets/common/app_divider.dart';
import 'package:career_portal/shared/widgets/common/app_select_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class DashboardFilterBar extends ConsumerWidget {
  const DashboardFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final filters = ref.watch(dashboardFiltersControllerProvider);
    final options = ref.watch(dashboardFilterOptionsProvider);
    final controller = ref.read(dashboardFiltersControllerProvider.notifier);
    final isDark = context.isDark;
    final isMobile = context.isMobileLayout;
    final fillColor = isDark
        ? AppColors.cardBackgroundGreyDark
        : AppColors.sidebarSearchBg;

    final fields = [
      AppSelectFieldWithLabel<String>(
        label: l10n.dashboardFilterLocationLabel,
        value: filters.locationValue,
        items: options.locations,
        fillColor: fillColor,
        itemLabelBuilder: (value) =>
            value == DashboardFiltersState.allLocationsKey
            ? l10n.dashboardFilterAllLocations
            : value,
        onChanged: controller.onLocationChanged,
      ),
      AppSelectFieldWithLabel<String>(
        label: l10n.dashboardFilterDepartmentLabel,
        value: filters.departmentValue,
        items: options.departments,
        fillColor: fillColor,
        itemLabelBuilder: (value) =>
            value == DashboardFiltersState.allDepartmentsKey
            ? l10n.dashboardFilterAllDepartments
            : value,
        onChanged: controller.onDepartmentChanged,
      ),
      AppSelectFieldWithLabel<String>(
        label: l10n.dashboardFilterEmploymentTypeLabel,
        value: filters.employmentTypeValue,
        items: options.employmentTypes,
        fillColor: fillColor,
        itemLabelBuilder: (value) =>
            value == DashboardFiltersState.allEmploymentTypesKey
            ? l10n.dashboardFilterAllEmploymentTypes
            : value,
        onChanged: controller.onEmploymentTypeChanged,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: context.themeCardBackground,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: isDark
                  ? AppColors.cardBorderDark
                  : AppColors.dashboardCardBorder,
            ),
            boxShadow: AppShadows.primaryShadow,
          ),
          child: isMobile
              ? Padding(
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 14.w,
                    vertical: 12.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (var i = 0; i < fields.length; i++) ...[
                        if (i > 0)
                          AppDivider(
                            margin: EdgeInsets.symmetric(vertical: 10.h),
                          ),
                        fields[i],
                      ],
                    ],
                  ),
                )
              : IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (var i = 0; i < fields.length; i++) ...[
                        if (i > 0) const AppVerticalDivider.standard(),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.symmetric(
                              horizontal: 16.w,
                              vertical: 14.h,
                            ),
                            child: fields[i],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
        ),
        if (filters.hasActiveFilters) ...[
          Gap(12.h),
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
                        onTap: () => controller.clear(filter.type),
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
                onPressed: controller.clearAll,
                fontSize: 13.sp,
                foregroundColor: context.themeTextSecondary,
              ),
            ],
          ),
        ],
      ],
    );
  }
}
