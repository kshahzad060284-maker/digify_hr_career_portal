import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/network/app_exception.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/router/app_routes.dart';
import 'package:career_portal/core/services/responsive/responsive_helper.dart';
import 'package:career_portal/core/services/toast/toast_service.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/core/widgets/pagination_controls.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_filters_controller.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_jobs_list_provider.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_jobs_pagination_provider.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_jobs_provider.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_filter_bar.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_job_card.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_job_card_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class JobListingContent extends ConsumerWidget {
  const JobListingContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final jobsAsync = ref.watch(dashboardJobsControllerProvider);
    final pagePadding = ResponsiveHelper.pagePadding(context);
    final isDark = context.isDark;
    final sectionBg = isDark
        ? AppColors.backgroundDark
        : AppColors.sidebarSearchBg;

    ref.listen(dashboardJobsControllerProvider, (previous, next) {
      if (next.hasError && previous?.hasError != true) {
        final error = next.error;
        final message = error is AppException
            ? error.message
            : l10n.dashboardJobsLoadFailed;
        ToastService.error(context, message);
      }
    });

    return ColoredBox(
      color: sectionBg,
      child: SingleChildScrollView(
        padding: EdgeInsetsDirectional.fromSTEB(
          pagePadding.left,
          48.h,
          pagePadding.right,
          48.h,
        ),
        child: jobsAsync.when(
          loading: () => const DashboardJobListSkeleton(showFilterBar: false),
          error: (error, _) => _JobsErrorView(
            message: error is AppException
                ? error.message
                : l10n.dashboardJobsLoadFailed,
            onRetry: () =>
                ref.read(dashboardJobsControllerProvider.notifier).refresh(),
          ),
          data: (jobsState) {
            final isReloading = jobsAsync.isLoading;

            if (isReloading) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 24.h,
                children: const [
                  DashboardFilterBar(),
                  DashboardJobListSkeleton(showFilterBar: false),
                ],
              );
            }

            final filteredJobs = ref.watch(dashboardFilteredJobsProvider);
            final jobs = ref.watch(dashboardPaginatedJobsProvider);
            final currentPage = ref.watch(dashboardJobsEffectivePageProvider);
            final pagination = ref.watch(dashboardJobsPaginationInfoProvider);
            final totalPositions = ref.watch(dashboardJobsTotalCountProvider);
            final filters = ref.watch(dashboardFiltersControllerProvider);
            final positionsCount = filters.isAllLocations
                ? totalPositions
                : filteredJobs.length;
            final jobsController = ref.read(
              dashboardJobsControllerProvider.notifier,
            );

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 24.h,
              children: [
                const DashboardFilterBar(),
                Text(
                  l10n.dashboardPositionsAvailable(positionsCount),
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 16.sp,
                  ),
                ),
                if (filteredJobs.isEmpty)
                  Text(
                    l10n.dashboardNoJobsFound,
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: context.themeTextSecondary,
                    ),
                  )
                else ...[
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: jobs.length,
                    separatorBuilder: (_, _) => Gap(16.h),
                    itemBuilder: (context, index) {
                      final job = jobs[index];
                      return DashboardJobCard(
                        job: job,
                        onTap: () => context.pushNamed(
                          AppRouteNames.dashboardJob,
                          pathParameters: {'id': job.id},
                        ),
                      );
                    },
                  ),
                  PaginationControls.fromPaginationInfo(
                    paginationInfo: pagination,
                    currentPage: currentPage,
                    pageSize: jobsState.pageSize,
                    showBorder: false,
                    padding: EdgeInsets.zero,
                    onPrevious: pagination.hasPrevious
                        ? jobsController.goToPreviousPage
                        : null,
                    onNext: pagination.hasNext
                        ? jobsController.goToNextPage
                        : null,
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class _JobsErrorView extends StatelessWidget {
  const _JobsErrorView({required this.message, required this.onRetry});

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
