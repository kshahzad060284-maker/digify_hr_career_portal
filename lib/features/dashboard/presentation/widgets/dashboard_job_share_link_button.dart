import 'package:career_portal/core/deep_link/deep_link.dart';
import 'package:career_portal/core/enterprise/enterprise_id_provider.dart';
import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/services/toast/toast_service.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardJobShareLinkButton extends ConsumerWidget {
  const DashboardJobShareLinkButton({super.key, required this.jobId});

  final String jobId;

  Future<void> _copyLink(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final url = DeepLink.jobDetailShareUrl(
      jobId: jobId,
      enterpriseId: ref.read(enterpriseIdProvider),
    );
    await Clipboard.setData(ClipboardData(text: url));
    if (!context.mounted) return;
    ToastService.success(context, l10n.dashboardJobLinkCopied);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = context.isDark;
    final iconColor = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondary;
    final borderColor = isDark
        ? AppColors.cardBorderDark
        : AppColors.dashboardCardBorder;
    final bgColor = isDark
        ? AppColors.cardBackgroundGreyDark
        : AppColors.sidebarSearchBg;

    return Tooltip(
      message: l10n.dashboardJobCopyLink,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _copyLink(context, ref),
          borderRadius: BorderRadius.circular(8.r),
          child: Ink(
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: borderColor),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: Icon(Icons.link_rounded, size: 18.sp, color: iconColor),
            ),
          ),
        ),
      ),
    );
  }
}
