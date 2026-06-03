import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/services/responsive/responsive_helper.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/core/theme/app_shadows.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_job_search_controller.dart';
import 'package:career_portal/shared/widgets/common/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardContentHeader extends ConsumerWidget {
  const DashboardContentHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isMobile = context.isMobileLayout;
    final horizontalPadding = ResponsiveHelper.pagePadding(context).horizontal;
    final headerHeight = isMobile ? 240.h : 280.h;
    final searchController = ref.read(
      dashboardJobSearchControllerProvider.notifier,
    );

    return SizedBox(
      height: headerHeight,
      width: double.infinity,
      child: ColoredBox(
        color: AppColors.primary,
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: horizontalPadding,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: isMobile ? 20.h : 24.h,
            children: [
              Text(
                l10n.dashboardJoinTeamTitle,
                textAlign: TextAlign.center,
                style: context.textTheme.titleSmall?.copyWith(
                  color: AppColors.onPrimary,
                  fontSize: isMobile ? 24.sp : 48.sp,
                ),
              ),
              Text(
                l10n.dashboardJoinTeamSubtitle,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: AppColors.onPrimary,
                  fontSize: isMobile ? 12.sp : 20.sp,
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isMobile ? double.infinity : 560.w,
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: AppShadows.primaryShadow,
                  ),
                  child: AppTextField.search(
                    hintText: l10n.dashboardJobSearchPlaceholder,
                    filled: true,
                    fillColor: AppColors.cardBackground,
                    onChanged: searchController.onSearchChanged,
                    onSubmitted: searchController.onSearchSubmitted,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
