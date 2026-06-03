import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/services/responsive/responsive_helper.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginLayout extends StatelessWidget {
  const LoginLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final maxCardWidth = context.responsiveFine<double>(
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
          child: Center(
            child: SingleChildScrollView(
              padding: ResponsiveHelper.pagePadding(context),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxCardWidth.w),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
