import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/router/app_routes.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class DashboardOffersNavButton extends StatelessWidget {
  const DashboardOffersNavButton({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return IconButton(
      tooltip: l10n.dashboardHeaderMyOffers,
      visualDensity: compact ? VisualDensity.compact : VisualDensity.standard,
      icon: Icon(
        Icons.description_outlined,
        size: compact ? 22.sp : 24.sp,
        color: AppColors.primary,
      ),
      onPressed: () => context.goNamed(AppRouteNames.candidateOffers),
    );
  }
}
