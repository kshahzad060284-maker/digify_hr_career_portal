import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/router/app_routes.dart';
import 'package:career_portal/core/services/responsive/responsive_helper.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_header_brand.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_header_nav_button.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_user_profile_chip.dart';
import 'package:career_portal/gen/assets.gen.dart';
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
    this.onHero = false,
  });

  final bool showOffersNavButton;
  final bool showApplicationsNavButton;

  final bool onHero;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMobile = context.isMobileLayout;
    final isDark = context.isDark;

    if (onHero) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.pagePadding(context).left,
          vertical: isMobile ? 8.h : 10.h,
        ),
        child: isMobile
            ? DashboardMobileHeader(
                showOffersNavButton: showOffersNavButton,
                showApplicationsNavButton: showApplicationsNavButton,
                onHero: true,
              )
            : DashboardDesktopHeader(
                showOffersNavButton: showOffersNavButton,
                showApplicationsNavButton: showApplicationsNavButton,
                onHero: true,
              ),
      );
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isMobile
            ? Colors.transparent
            : (isDark ? AppColors.cardBackgroundDark : AppColors.dashboardCard),
        border: isMobile
            ? null
            : Border(
                bottom: BorderSide(
                  color: isDark
                      ? AppColors.cardBorderDark
                      : AppColors.cardBorder,
                ),
              ),
      ),
      child: Padding(
        padding: ResponsiveHelper.pagePadding(context),
        child: isMobile
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
    this.onHero = false,
  });

  final bool showOffersNavButton;
  final bool showApplicationsNavButton;
  final bool onHero;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final authSession = ref.watch(authSessionProvider);
    final session = authSession.session;
    final isLoggedIn = authSession.isLoggedIn;
    final titleColor = onHero ? AppColors.onPrimary : context.themeTextPrimary;
    final taglineColor = onHero
        ? AppColors.onPrimary.withValues(alpha: 0.85)
        : context.themeTextSecondary;
    final iconColor = onHero ? AppColors.onPrimary : AppColors.primary;

    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => context.go(AppRoutes.home),
            borderRadius: BorderRadius.circular(8.r),
            child: DashboardHeaderBrand(
              titleColor: titleColor,
              taglineColor: taglineColor,
              logoSize: 36,
              titleFontSize: 24.sp,
            ),
          ),
        ),
        if (isLoggedIn && session != null) ...[
          if (showApplicationsNavButton) ...[
            Gap(12.w),
            DashboardHeaderNavButton(
              label: l10n.dashboardHeaderMyApplications,
              onPressed: () =>
                  context.goNamed(AppRouteNames.candidateApplications),
              foregroundColor: iconColor,
            ),
          ],
          if (showOffersNavButton) ...[
            Gap(12.w),
            DashboardHeaderNavButton(
              label: l10n.dashboardHeaderMyOffers,
              onPressed: () => context.goNamed(AppRouteNames.candidateOffers),
              foregroundColor: iconColor,
            ),
          ],
          Gap(12.w),
          DashboardUserProfileChip(session: session, onHero: onHero),
        ] else ...[
          Gap(12.w),
          AppButton.text(
            label: l10n.signIn,
            onPressed: () => context.go(AppRoutes.authLogin),
            foregroundColor: onHero ? AppColors.onPrimary : null,
          ),
          Gap(12.w),
          if (onHero)
            AppButton(
              label: l10n.register,
              onPressed: () => context.go(AppRoutes.authSignUp),
              backgroundColor: AppColors.onPrimary,
              foregroundColor: AppColors.primary,
            )
          else
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
    this.onHero = false,
  });

  final bool showOffersNavButton;
  final bool showApplicationsNavButton;
  final bool onHero;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final authSession = ref.watch(authSessionProvider);
    final session = authSession.session;
    final isLoggedIn = authSession.isLoggedIn;
    final titleColor = onHero ? AppColors.onPrimary : context.themeTextPrimary;
    final taglineColor = onHero
        ? AppColors.onPrimary.withValues(alpha: 0.85)
        : context.themeTextSecondary;
    final iconColor = onHero ? AppColors.onPrimary : AppColors.primary;

    final row = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: InkWell(
            onTap: () => context.go(AppRoutes.home),
            borderRadius: BorderRadius.circular(10.r),
            child: DashboardHeaderBrand(
              titleColor: titleColor,
              taglineColor: taglineColor,
              logoSize: 40,
              titleFontSize: 19.sp,
              titleMaxLines: 1,
              taglineMaxLines: isLoggedIn ? 1 : 2,
            ),
          ),
        ),
        if (isLoggedIn && session != null) ...[
          if (showApplicationsNavButton) ...[
            Gap(8.w),
            DashboardHeaderNavButton(
              label: l10n.dashboardHeaderMyApplications,
              onPressed: () =>
                  context.goNamed(AppRouteNames.candidateApplications),
              compact: true,
              foregroundColor: iconColor,
            ),
          ],
          if (showOffersNavButton) ...[
            Gap(8.w),
            DashboardHeaderNavButton(
              label: l10n.dashboardHeaderMyOffers,
              onPressed: () => context.goNamed(AppRouteNames.candidateOffers),
              compact: true,
              foregroundColor: iconColor,
            ),
          ],
          Gap(8.w),
          DashboardUserProfileChip(
            session: session,
            compact: true,
            onHero: onHero,
          ),
        ] else ...[
          Gap(8.w),
          AppButton.text(
            label: l10n.signIn,
            onPressed: () => context.go(AppRoutes.authLogin),
            svgPath: Assets.icons.auth.login.path,
            foregroundColor: onHero ? AppColors.onPrimary : null,
            svgAssetColor: onHero ? AppColors.onPrimary : null,
          ),
        ],
      ],
    );

    if (onHero) return row;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.themeCardBackground,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: context.themeCardBorder),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        child: row,
      ),
    );
  }
}
