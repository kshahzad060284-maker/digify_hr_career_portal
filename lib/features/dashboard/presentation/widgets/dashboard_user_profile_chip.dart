import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/router/app_routes.dart';
import 'package:career_portal/core/services/toast/toast_service.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/auth/domain/models/candidate_session.dart';
import 'package:career_portal/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:career_portal/shared/widgets/common/app_avatar.dart';
import 'package:career_portal/shared/widgets/common/app_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

enum _ProfileMenuAction { logout }

class DashboardUserProfileChip extends ConsumerWidget {
  const DashboardUserProfileChip({
    super.key,
    required this.session,
    this.compact = false,
  });

  final CandidateSession session;
  final bool compact;

  Future<void> _onLogout(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await AppConfirmationDialog.show(
      context,
      title: l10n.authLogoutConfirmTitle,
      message: l10n.authLogoutConfirmMessage,
      confirmLabel: l10n.authLogout,
      cancelLabel: l10n.commonCancel,
      type: ConfirmationType.danger,
      icon: Icons.logout_rounded,
    );
    if (confirmed != true || !context.mounted) return;

    await ref.read(authSessionProvider.notifier).clear();
    if (!context.mounted) return;

    ToastService.success(context, l10n.authLogoutSuccess);
    context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = context.isDark;
    final displayName = session.fullName.trim().isNotEmpty
        ? session.fullName.trim()
        : session.email;

    return PopupMenuButton<_ProfileMenuAction>(
      tooltip: displayName,
      offset: Offset(0, compact ? 44.h : 52.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      color: isDark ? AppColors.cardBackgroundDark : AppColors.dashboardCard,
      onSelected: (action) async {
        if (action == _ProfileMenuAction.logout) {
          await _onLogout(context, ref);
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem<_ProfileMenuAction>(
          value: _ProfileMenuAction.logout,
          child: Row(
            children: [
              Icon(Icons.logout_rounded, size: 18.sp, color: AppColors.error),
              Gap(10.w),
              Text(
                l10n.authLogout,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: AppColors.error,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 10.w : 12.w,
          vertical: compact ? 6.h : 8.h,
        ),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.cardBackgroundDark
              : AppColors.sidebarActiveBg,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isDark ? AppColors.cardBorderDark : AppColors.cardBorder,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppAvatar(
              fallbackInitial: displayName,
              size: compact ? 32 : 40,
              backgroundColor: AppColors.primary.withValues(alpha: 0.12),
              showStatusDot: true,
              statusDotColor: AppColors.success,
            ),
            Gap(compact ? 8.w : 10.w),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    displayName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.titleSmall?.copyWith(
                      color: context.themeTextPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: compact ? 13.sp : 14.sp,
                    ),
                  ),
                  if (!compact) ...[
                    Gap(2.h),
                    Text(
                      session.email,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.labelSmall?.copyWith(
                        color: context.themeTextSecondary,
                        fontSize: 12.sp,
                      ),
                    ),
                  ] else ...[
                    Gap(2.h),
                    Text(
                      l10n.authLoggedInLabel,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.labelSmall?.copyWith(
                        color: AppColors.primary,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
