import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/router/app_routes.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/gen/assets.gen.dart';
import 'package:career_portal/shared/widgets/assets/app_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({
    super.key,
    required this.child,
    this.maxCardWidth,
    this.contentPadding,
    this.onBack,
  });

  final Widget child;
  final double? maxCardWidth;
  final EdgeInsetsDirectional? contentPadding;
  final VoidCallback? onBack;

  void _handleBack(BuildContext context) {
    if (onBack != null) {
      onBack!();
      return;
    }
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.home);
    }
  }

  EdgeInsetsDirectional _resolveContentPadding(BuildContext context) {
    final horizontal = context.responsiveFine<double>(
      mobile: 16,
      tabletSmall: 20,
      tabletMedium: 24,
      tabletLarge: 24,
      desktop: 24,
    );
    final extra = contentPadding ?? EdgeInsetsDirectional.zero;
    return EdgeInsetsDirectional.only(
      start: horizontal.w + extra.start,
      end: horizontal.w + extra.end,
      top: extra.top,
      bottom: extra.bottom,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = context.isDark;
    final resolvedMaxCardWidth =
        maxCardWidth ??
        context.responsiveFine<double>(
          mobile: double.infinity,
          tabletSmall: 440,
          tabletMedium: 460,
          tabletLarge: 480,
          desktop: 500,
        );

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [AppColors.cardBackgroundDark, AppColors.backgroundDark]
                : [AppColors.authBgStart, AppColors.authBgEnd],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.w, 8.h, 16.w, 0),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: _AuthBackButton(
                    label: l10n.authBack,
                    onPressed: () => _handleBack(context),
                  ),
                ),
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: _resolveContentPadding(context),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: resolvedMaxCardWidth.w,
                              ),
                              child: child,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AuthBackButton extends StatelessWidget {
  const _AuthBackButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(4.r),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 4.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppAsset(
                assetPath: Assets.icons.jobDetail.leftArrow.path,
                width: 20.w,
                height: 20.w,
                color: AppColors.primary,
              ),
              Gap(8.w),
              Text(
                label,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: AppColors.primary,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
