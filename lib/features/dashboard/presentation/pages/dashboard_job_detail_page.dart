import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/router/app_routes.dart';
import 'package:career_portal/core/network/app_exception.dart';
import 'package:career_portal/core/services/responsive/responsive_helper.dart';
import 'package:career_portal/core/services/toast/toast_service.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:career_portal/features/dashboard/domain/models/dashboard_job.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_job_detail_provider.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_apply_job_dialog.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_job_detail_body.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_job_detail_header.dart';
import 'package:career_portal/shared/widgets/common/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class DashboardJobDetailPage extends ConsumerStatefulWidget {
  const DashboardJobDetailPage({super.key, required this.jobId});

  final String jobId;

  @override
  ConsumerState<DashboardJobDetailPage> createState() =>
      _DashboardJobDetailPageState();
}

class _DashboardJobDetailPageState
    extends ConsumerState<DashboardJobDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchJobDetail());
  }

  void _fetchJobDetail() {
    if (!mounted) return;
    ref.invalidate(dashboardJobDetailControllerProvider(widget.jobId));
  }

  void _onSignInToApply() => context.go(AppRoutes.authLogin);

  Future<void> _onApply(DashboardJob job) {
    return DashboardApplyJobDialog.show(context, job: job);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isLoggedIn = ref.watch(isLoggedInProvider);
    final applyButtonLabel = isLoggedIn
        ? l10n.dashboardJobDetailApply
        : l10n.dashboardJobDetailSignInToApply;
    final detailAsync = ref.watch(
      dashboardJobDetailControllerProvider(widget.jobId),
    );
    final pagePadding = ResponsiveHelper.pagePadding(context);
    final isDark = context.isDark;
    final sectionBg = isDark
        ? AppColors.backgroundDark
        : AppColors.sidebarSearchBg;

    ref.listen(dashboardJobDetailControllerProvider(widget.jobId), (
      previous,
      next,
    ) {
      if (next.hasError && previous?.hasError != true) {
        final error = next.error;
        final message = error is AppException
            ? error.message
            : l10n.dashboardJobDetailLoadFailed;
        ToastService.error(context, message);
      }
    });

    return ColoredBox(
      color: sectionBg,
      child: detailAsync.when(
        loading: () => AppPageLoading(message: 'Loading job details...'),
        error: (error, _) => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
              pagePadding.left,
              48.h,
              pagePadding.right,
              48.h,
            ),
            child: _JobDetailErrorView(
              message: error is AppException
                  ? error.message
                  : l10n.dashboardJobDetailLoadFailed,
              onRetry: () => ref
                  .read(
                    dashboardJobDetailControllerProvider(widget.jobId).notifier,
                  )
                  .refresh(),
            ),
          ),
        ),
        data: (detailState) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DashboardJobDetailHeader(
                job: detailState.job,
                fallbackTitle: l10n.dashboardJobDetailTitle(widget.jobId),
                onBack: () => context.pop(),
                applyButtonLabel: applyButtonLabel,
                onApplyPressed: isLoggedIn
                    ? () => _onApply(detailState.job)
                    : _onSignInToApply,
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                  pagePadding.left,
                  32.h,
                  pagePadding.right,
                  48.h,
                ),
                child: DashboardJobDetailBody(
                  job: detailState.job,
                  applyButtonLabel: applyButtonLabel,
                  onApplyPressed: isLoggedIn
                      ? () => _onApply(detailState.job)
                      : _onSignInToApply,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _JobDetailErrorView extends StatelessWidget {
  const _JobDetailErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 16.h,
      children: [
        Text(
          message,
          style: context.textTheme.bodyLarge?.copyWith(
            color: context.themeTextSecondary,
            fontSize: 16.sp,
          ),
        ),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: FilledButton(
            onPressed: onRetry,
            child: Text(AppLocalizations.of(context)!.commonRetry),
          ),
        ),
      ],
    );
  }
}
