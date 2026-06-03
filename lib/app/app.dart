import 'package:career_portal/core/config/app_config.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/router/app_router.dart';
import 'package:career_portal/core/services/responsive/responsive_helper.dart';
import 'package:career_portal/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CareerPortalApp extends StatelessWidget {
  const CareerPortalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, _) {
        return ScreenUtilInit(
          designSize: ResponsiveHelper.screenUtilDesignSize(context),
          minTextAdapt: AppConfig.minTextAdapt,
          splitScreenMode: AppConfig.splitScreenMode,
          builder: (context, _) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: AppConfig.showDebugBanner,
              title: AppConfig.appName,
              theme: AppTheme.light(),
              darkTheme: AppTheme.dark(),
              themeMode: ThemeMode.light,
              routerConfig: AppRouter.router,
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
