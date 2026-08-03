import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/services/responsive/responsive_helper.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardFooter extends StatelessWidget {
  const DashboardFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isMobile = context.isMobileLayout;
    final isDark = context.isDark;
    final pagePadding = ResponsiveHelper.pagePadding(context);
    final muted = context.themeTextSecondary;
    final linkStyle = context.textTheme.labelMedium?.copyWith(
      color: muted,
      fontSize: 13.sp,
    );

    final copyright = Text(
      l10n.footerCopyright,
      style: context.textTheme.labelSmall?.copyWith(
        color: muted,
        fontSize: 12.sp,
      ),
    );

    final legalLinks = Wrap(
      spacing: 16.w,
      runSpacing: 8.h,
      children: [
        Text(l10n.footerPrivacy, style: linkStyle),
        Text(l10n.footerTerms, style: linkStyle),
        Text(l10n.footerContact, style: linkStyle),
      ],
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardBackgroundDark : AppColors.cardBackground,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.cardBorderDark : AppColors.cardBorder,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(
          pagePadding.left,
          isMobile ? 28.h : 32.h,
          pagePadding.right,
          isMobile ? 28.h : 32.h,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: ResponsiveHelper.maxContentWidth(context),
            ),
            child: isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 12.h,
                    children: [copyright, legalLinks],
                  )
                : Row(
                    children: [
                      Expanded(child: copyright),
                      legalLinks,
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
