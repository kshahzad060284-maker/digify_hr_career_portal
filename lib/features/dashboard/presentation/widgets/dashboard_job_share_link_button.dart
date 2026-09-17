import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/services/toast/toast_service.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/enterprise_context/domain/helpers/career_portal_url_builder.dart';
import 'package:career_portal/features/enterprise_context/presentation/providers/enterprise_context_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardJobShareLinkButton extends ConsumerStatefulWidget {
  const DashboardJobShareLinkButton({super.key, required this.jobId});

  final String jobId;

  @override
  ConsumerState<DashboardJobShareLinkButton> createState() =>
      _DashboardJobShareLinkButtonState();
}

class _DashboardJobShareLinkButtonState
    extends ConsumerState<DashboardJobShareLinkButton> {
  bool _isHovered = false;

  Future<void> _copyLink(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final careerPortalUrl = ref.read(hostCareerPortalUrlProvider);
    if (careerPortalUrl == null || careerPortalUrl.isEmpty) return;
    final url = CareerPortalUrlBuilder.jobUrl(
      careerPortalUrl: careerPortalUrl,
      jobId: widget.jobId,
    );
    await Clipboard.setData(ClipboardData(text: url));
    if (!context.mounted) return;
    ToastService.success(context, l10n.dashboardJobLinkCopied);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = context.isDark;
    final baseColor =
        isDark ? AppColors.textTertiaryDark : AppColors.textTertiary;

    return Tooltip(
      message: l10n.dashboardJobCopyLink,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: () => _copyLink(context),
          child: TweenAnimationBuilder<Color?>(
            tween: ColorTween(
              begin: baseColor,
              end: _isHovered ? AppColors.primary : baseColor,
            ),
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOut,
            builder: (context, color, _) => Icon(
              Icons.link_rounded,
              size: 18.sp,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
