import 'package:career_portal/core/config/app_config.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/router/app_router.dart';
import 'package:career_portal/core/services/responsive/breakpoints.dart';
import 'package:career_portal/core/services/responsive/responsive_helper.dart';
import 'package:career_portal/core/theme/app_mobile_theme.dart';
import 'package:career_portal/core/theme/app_theme.dart';
import 'package:career_portal/features/auth/presentation/providers/auth_bootstrap_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CareerPortalApp extends ConsumerWidget {
  const CareerPortalApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(authBootstrapProvider);
    final router = ref.watch(appRouterProvider);

    return LayoutBuilder(
      builder: (context, _) {
        return ScreenUtilInit(
          designSize: ResponsiveHelper.screenUtilDesignSize(context),
          minTextAdapt: AppConfig.minTextAdapt,
          splitScreenMode: AppConfig.splitScreenMode,
          builder: (context, _) {
            final isMobile =
                AppBreakpoints.fromContext(context) == ScreenLayout.mobile;

            return MaterialApp.router(
              debugShowCheckedModeBanner: AppConfig.showDebugBanner,
              title: AppConfig.appName,
              theme: isMobile ? AppMobileTheme.lightTheme : AppTheme.lightTheme,
              darkTheme: isMobile
                  ? AppMobileTheme.darkTheme
                  : AppTheme.darkTheme,
              themeMode: ThemeMode.light,
              routerConfig: router,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: AppConfig.defaultLocale,
            );
          },
        );
      },
    );
  }
}
