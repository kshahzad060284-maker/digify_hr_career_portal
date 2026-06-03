import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/services/responsive/responsive_helper.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/gen/assets.gen.dart';
import 'package:career_portal/shared/widgets/assets/app_asset.dart';
import 'package:career_portal/shared/widgets/common/app_button.dart';
import 'package:career_portal/core/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:gap/gap.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isMobile = context.isMobileLayout;

    return Container(
      width: double.infinity,
      color: AppColors.dashboardCard,
      child: Padding(
        padding: ResponsiveHelper.pagePadding(context),
        child: isMobile
            ? _buildMobileHeader(context, l10n)
            : _buildDesktopHeader(context, l10n),
      ),
    );
  }

  Widget _buildDesktopHeader(BuildContext context, AppLocalizations l10n) {
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
    );
  }

  Widget _buildMobileHeader(BuildContext context, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppAsset(
              assetPath: Assets.icons.dashboard.department.path,
              color: AppColors.primary,
              width: 24.w,
              height: 24.w,
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
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gap(3.h),
                  Text(
                    l10n.appTagline,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: context.themeTextSecondary,
                      fontSize: 11.sp,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Gap(16.h),
        Row(
          children: [
            Expanded(
              child: AppButton.text(
                label: l10n.signIn,
                onPressed: () => context.go(AppRoutes.authLogin),
              ),
            ),
            Gap(10.w),
            Expanded(
              child: AppButton(
                label: l10n.register,
                type: AppButtonType.primary,
                onPressed: () => context.go(AppRoutes.authSignUp),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
