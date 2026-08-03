import 'package:career_portal/core/deep_link/deep_link.dart';
import 'package:career_portal/core/enterprise/enterprise_id_provider.dart';
import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/network/app_exception.dart';
import 'package:career_portal/core/router/app_routes.dart';
import 'package:career_portal/core/services/toast/toast_service.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/applications/presentation/providers/candidate_applications_list_provider.dart';
import 'package:career_portal/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:career_portal/features/dashboard/domain/models/dashboard_job.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_job_detail_provider.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_jobs_list_provider.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_apply_job_dialog.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_footer.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_job_detail_error_view.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_job_detail_loaded_view.dart';
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

  Future<void> _onApply(DashboardJob job) async {
    final applied = await DashboardApplyJobDialog.show(context, job: job);
    if (!mounted || applied != true) return;
    await ref
        .read(dashboardJobDetailControllerProvider(widget.jobId).notifier)
        .refresh();
    await ref.read(dashboardJobsControllerProvider.notifier).refresh();
    ref.invalidate(candidateApplicationsControllerProvider);
  }

  String _applyButtonLabel({
    required AppLocalizations l10n,
    required bool isLoggedIn,
  }) {
    if (!isLoggedIn) return l10n.dashboardJobDetailSignInToApply;
    return l10n.dashboardJobDetailApply;
  }

  void _onBack() {
    if (context.canPop()) {
      context.pop();
      return;
    }
    context.go(
      DeepLink.withEnterpriseId(AppRoutes.home, ref.read(enterpriseIdProvider)),
    );
  }

  void _onRetry() {
    ref
        .read(dashboardJobDetailControllerProvider(widget.jobId).notifier)
        .refresh();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isLoggedIn = ref.watch(isLoggedInProvider);
    final detailAsync = ref.watch(
      dashboardJobDetailControllerProvider(widget.jobId),
    );
    final horizontalInset = 30.w;
    final maxWidth = MediaQuery.sizeOf(context).width;
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
        loading: () => AppPageLoading(message: l10n.dashboardJobDetailLoading),
        error: (error, _) => Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsetsDirectional.fromSTEB(
                    horizontalInset,
                    48.h,
                    horizontalInset,
                    48.h,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    child: DashboardJobDetailErrorView(
                      message: error is AppException
                          ? error.message
                          : l10n.dashboardJobDetailLoadFailed,
                      onRetry: _onRetry,
                      onBack: _onBack,
                    ),
                  ),
                ),
              ),
            ),
            const DashboardFooter(),
          ],
        ),
        data: (detailState) {
          final hasApplied = detailState.job.hasApplied;
          final applyButtonLabel = _applyButtonLabel(
            l10n: l10n,
            isLoggedIn: isLoggedIn,
          );
          final VoidCallback? onApplyPressed = hasApplied
              ? null
              : !isLoggedIn
              ? _onSignInToApply
              : () => _onApply(detailState.job);

          return DashboardJobDetailLoadedView(
            job: detailState.job,
            fallbackTitle: l10n.dashboardJobDetailTitle(widget.jobId),
            applyButtonLabel: applyButtonLabel,
            onBack: _onBack,
            onApplyPressed: onApplyPressed,
            hasApplied: hasApplied,
          );
        },
      ),
    );
  }
}
