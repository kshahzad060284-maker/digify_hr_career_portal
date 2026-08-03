import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/services/responsive/responsive_helper.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/core/theme/app_shadows.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_jobs_list_provider.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_header.dart';
import 'package:career_portal/shared/widgets/common/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardHeroSliver extends ConsumerWidget {
  const DashboardHeroSliver({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMobile = context.isMobileLayout;
    final height = isMobile ? 280.h : 300.h;

    return SliverToBoxAdapter(
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: const DashboardHeroBackground(),
      ),
    );
  }
}

class DashboardHeroBackground extends ConsumerWidget {
  const DashboardHeroBackground({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isMobile = context.isMobileLayout;
    final horizontalPadding = ResponsiveHelper.pagePadding(context).left;
    final jobsController = ref.read(dashboardJobsControllerProvider.notifier);

    return Stack(
      fit: StackFit.expand,
      children: [
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primaryDark,
                AppColors.primary,
                AppColors.gradientBlue,
              ],
            ),
          ),
        ),
        PositionedDirectional(
          top: -40.h,
          end: -28.w,
          child: IgnorePointer(
            child: Container(
              width: 150.w,
              height: 150.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.onPrimary.withValues(alpha: 0.08),
              ),
            ),
          ),
        ),
        PositionedDirectional(
          bottom: -50.h,
          start: -32.w,
          child: IgnorePointer(
            child: Container(
              width: 170.w,
              height: 170.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.onPrimary.withValues(alpha: 0.06),
              ),
            ),
          ),
        ),
        Column(
          children: [
            const DashboardHeader(onHero: true),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                  horizontalPadding,
                  isMobile ? 8.h : 12.h,
                  horizontalPadding,
                  isMobile ? 16.h : 24.h,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: isMobile ? 10.h : 12.h,
                  children: [
                    Container(
                      padding: EdgeInsetsDirectional.symmetric(
                        horizontal: 12.w,
                        vertical: 5.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.onPrimary.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(999.r),
                        border: Border.all(
                          color: AppColors.onPrimary.withValues(alpha: 0.22),
                        ),
                      ),
                      child: Text(
                        l10n.dashboardHeroBadge,
                        style: context.textTheme.labelLarge?.copyWith(
                          color: AppColors.onPrimary,
                          fontSize: isMobile ? 11.sp : 12.sp,
                        ),
                      ),
                    ),
                    Text(
                      l10n.dashboardJoinTeamTitle,
                      textAlign: TextAlign.center,
                      style: context.textTheme.displaySmall?.copyWith(
                        color: AppColors.onPrimary,
                        fontSize: isMobile ? 24.sp : 34.sp,
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 560.w),
                      child: Text(
                        l10n.dashboardJoinTeamSubtitle,
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: AppColors.onPrimary.withValues(alpha: 0.92),
                          fontSize: isMobile ? 12.sp : 15.sp,
                        ),
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: isMobile ? double.infinity : 520.w,
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
                          onChanged: jobsController.onSearchChanged,
                          onSubmitted: jobsController.onSearchSubmitted,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
