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
    final isDark = context.isDark;
    final iconColor = isDark
        ? context.themeTextSecondary
        : AppColors.textSecondary;

    final locationItems = [DashboardFiltersState.allLocationsKey, ...locations];

    return _DashboardFilterField(
      icon: AppAsset(
        assetPath: Assets.icons.dashboard.locationPin.path,
        width: 18.w,
        height: 18.w,
        color: iconColor,
      ),
      value: filters.selectedLocation ?? DashboardFiltersState.allLocationsKey,
      items: locationItems,
      itemLabelBuilder: (value) =>
          value == DashboardFiltersState.allLocationsKey
          ? l10n.dashboardFilterAllLocations
          : value,
      onChanged: filtersController.onLocationChanged,
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
  });

  final Widget icon;
  final String value;
  final List<String> items;
  final String Function(String) itemLabelBuilder;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final fieldWidth = context.responsiveFine(
      mobile: 200.w,
      tabletSmall: 220.w,
      tabletMedium: 240.w,
      tabletLarge: 260.w,
      desktop: 260.w,
    );

    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: SizedBox(
        width: fieldWidth,
        child: Row(
          children: [
            icon,
            SizedBox(width: 8.w),
            Expanded(
              child: AppSelectField<String>(
                value: value,
                items: items,
                itemLabelBuilder: itemLabelBuilder,
                onChanged: onChanged,
                fillColor: context.themeCardBackground,
                color: isDark ? AppColors.inputBorderDark : AppColors.borderGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
