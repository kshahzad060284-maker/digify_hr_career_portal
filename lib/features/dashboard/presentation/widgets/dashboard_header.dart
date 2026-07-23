import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/router/app_routes.dart';
import 'package:career_portal/core/services/responsive/responsive_helper.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_applications_nav_button.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_offers_nav_button.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_user_profile_chip.dart';
import 'package:career_portal/gen/assets.gen.dart';
import 'package:career_portal/shared/widgets/assets/app_asset.dart';
import 'package:career_portal/shared/widgets/common/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class DashboardHeader extends ConsumerWidget {
  const DashboardHeader({
    super.key,
    this.showOffersNavButton = true,
    this.showApplicationsNavButton = true,
  });

  final bool showOffersNavButton;
  final bool showApplicationsNavButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      color: context.isMobileLayout
          ? Colors.transparent
          : AppColors.dashboardCard,
      child: Padding(
        padding: ResponsiveHelper.pagePadding(context),
        child: context.isMobileLayout
            ? DashboardMobileHeader(
                showOffersNavButton: showOffersNavButton,
                showApplicationsNavButton: showApplicationsNavButton,
              )
            : DashboardDesktopHeader(
                showOffersNavButton: showOffersNavButton,
                showApplicationsNavButton: showApplicationsNavButton,
              ),
      ),
    );
  }
}

class DashboardDesktopHeader extends ConsumerWidget {
  const DashboardDesktopHeader({
    super.key,
    this.showOffersNavButton = true,
    this.showApplicationsNavButton = true,
  });

  final bool showOffersNavButton;
  final bool showApplicationsNavButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final authSession = ref.watch(authSessionProvider);
    final session = authSession.session;
    final isLoggedIn = authSession.isLoggedIn;

    return Row(
      children: [
        AppAsset(
          assetPath: Assets.icons.dashboard.department.path,
          color: AppColors.primary,
          width: 28.w,
          height: 28.h,
        ),
        Gap(12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.appTitle,
                style: context.textTheme.titleLarge?.copyWith(
                  color: context.themeTextPrimary,
                  fontSize: 24.sp,
                ),
              ),
              Gap(2.h),
              Text(
                l10n.appTagline,
                style: context.textTheme.labelSmall?.copyWith(
                  color: context.themeTextSecondary,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
        if (isLoggedIn && session != null) ...[
          if (showApplicationsNavButton) ...[
            Gap(12.w),
            const DashboardApplicationsNavButton(),
          ],
          if (showOffersNavButton) ...[
            Gap(12.w),
            const DashboardOffersNavButton(),
          ],
          Gap(12.w),
          DashboardUserProfileChip(session: session),
        ] else ...[
          Gap(12.w),
          AppButton.text(
            label: l10n.signIn,
            onPressed: () => context.go(AppRoutes.authLogin),
          ),
          Gap(12.w),
          AppButton(
            label: l10n.register,
            type: AppButtonType.primary,
            onPressed: () => context.go(AppRoutes.authSignUp),
          ),
        ],
      ],
    );
  }
}

class DashboardMobileHeader extends ConsumerWidget {
  const DashboardMobileHeader({
    super.key,
    this.showOffersNavButton = true,
    this.showApplicationsNavButton = true,
  });

  final bool showOffersNavButton;
  final bool showApplicationsNavButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final authSession = ref.watch(authSessionProvider);
    final session = authSession.session;
    final isLoggedIn = authSession.isLoggedIn;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.themeCardBackground,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: context.themeCardBorder),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: AppColors.sidebarActiveBg,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(
                child: AppAsset(
                  assetPath: Assets.icons.dashboard.department.path,
                  color: AppColors.primary,
                  width: 20.w,
                  height: 20.w,
                ),
              ),
            ),
            Gap(12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.appTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.titleMedium?.copyWith(
                      color: context.themeTextPrimary,
                      fontSize: 19.sp,
                    ),
                  ),
                  Gap(4.h),
                  Text(
                    l10n.appTagline,
                    maxLines: isLoggedIn ? 1 : 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: context.themeTextSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (isLoggedIn && session != null) ...[
              if (showApplicationsNavButton) ...[
                Gap(8.w),
                const DashboardApplicationsNavButton(compact: true),
              ],
              if (showOffersNavButton) ...[
                Gap(8.w),
                const DashboardOffersNavButton(compact: true),
              ],
              Gap(8.w),
              DashboardUserProfileChip(session: session, compact: true),
            ] else ...[
              Gap(8.w),
              AppButton.text(
                label: l10n.signIn,
                onPressed: () => context.go(AppRoutes.authLogin),
                svgPath: Assets.icons.auth.login.path,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
