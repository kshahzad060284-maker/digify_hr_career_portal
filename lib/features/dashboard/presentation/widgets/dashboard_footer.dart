import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/services/responsive/responsive_helper.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/enterprise_context/presentation/providers/enterprise_context_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class DashboardFooter extends ConsumerWidget {
  const DashboardFooter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final companyName = ref.watch(hostEnterpriseNameProvider) ?? 'DigifyHR';
    final isMobile = context.isMobileLayout;
    final isDark = context.isDark;
    final pagePadding = ResponsiveHelper.pagePadding(context);

    final copyright = Text(
      l10n.footerCopyright,
      style: context.textTheme.bodyMedium?.copyWith(
        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
      ),
    );

    final companyInfo = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          companyName,
          style: context.textTheme.titleLarge?.copyWith(
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
          ),
        ),
        Gap(16.h),
        Text(
          'Empowering careers globally.\nFind your next dream job with us.',
          style: context.textTheme.bodyMedium?.copyWith(
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondary,
          ),
        ),
      ],
    );

    final legalLinks = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Legal',
          style: context.textTheme.titleMedium?.copyWith(
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
          ),
        ),
        Gap(16.h),
        _HoverLink(text: l10n.footerPrivacy, isDark: isDark),
        Gap(12.h),
        _HoverLink(text: l10n.footerTerms, isDark: isDark),
      ],
    );

    final supportLinks = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Support',
          style: context.textTheme.titleMedium?.copyWith(
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
          ),
        ),
        Gap(16.h),
        _HoverLink(text: l10n.footerContact, isDark: isDark),
        Gap(12.h),
        _HoverLink(text: 'Help Center', isDark: isDark),
      ],
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardBackgroundGreyDark : AppColors.grayBg,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.cardBorderDark : AppColors.borderLight,
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(
          pagePadding.left,
          64.h,
          pagePadding.right,
          48.h,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      companyInfo,
                      Gap(48.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: supportLinks),
                          Expanded(child: legalLinks),
                        ],
                      ),
                      Gap(48.h),
                      Divider(
                        color: isDark
                            ? AppColors.cardBorderDark
                            : AppColors.borderLight,
                      ),
                      Gap(24.h),
                      copyright,
                    ],
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 2, child: companyInfo),
                          Expanded(flex: 1, child: supportLinks),
                          Expanded(flex: 1, child: legalLinks),
                        ],
                      ),
                      Gap(48.h),
                      Divider(
                        color: isDark
                            ? AppColors.cardBorderDark
                            : AppColors.borderLight,
                      ),
                      Gap(24.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [copyright],
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class _HoverLink extends StatefulWidget {
  const _HoverLink({required this.text, required this.isDark});
  final String text;
  final bool isDark;

  @override
  State<_HoverLink> createState() => _HoverLinkState();
}

class _HoverLinkState extends State<_HoverLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {},
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 4.h),
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: context.textTheme.labelLarge!.copyWith(
                  color: _isHovered
                      ? AppColors.primary
                      : (widget.isDark
                            ? AppColors.textPrimaryDark
                            : AppColors.textSlate),
                ),
                child: Text(widget.text),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.centerLeft,
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.0, end: _isHovered ? 1.0 : 0.0),
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, child) {
                    return FractionallySizedBox(
                      widthFactor: value,
                      child: Container(height: 1.5, color: AppColors.primary),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
