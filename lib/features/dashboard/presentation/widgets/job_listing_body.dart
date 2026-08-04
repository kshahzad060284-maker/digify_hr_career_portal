import 'package:career_portal/core/deep_link/deep_link.dart';
import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/router/app_routes.dart';
import 'package:career_portal/core/widgets/pagination_controls.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_jobs_list_provider.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_jobs_pagination_provider.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_jobs_provider.dart';
import 'package:career_portal/features/dashboard/presentation/state/dashboard_jobs_state.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_filter_bar.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_job_card.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/job_listing_empty_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class JobListingBody extends ConsumerWidget {
  const JobListingBody({
    super.key,
    required this.jobsState,
    required this.pagePadding,
    required this.maxWidth,
  });

  final DashboardJobsState jobsState;
  final EdgeInsets pagePadding;
  final double maxWidth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final filteredJobs = ref.watch(dashboardFilteredJobsProvider);
    final jobs = ref.watch(dashboardPaginatedJobsProvider);
    final currentPage = ref.watch(dashboardJobsEffectivePageProvider);
    final pagination = ref.watch(dashboardJobsPaginationInfoProvider);
    final totalPositions = ref.watch(dashboardJobsTotalCountProvider);
    final jobsController = ref.read(dashboardJobsControllerProvider.notifier);

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
        pagePadding.left,
        20.h,
        pagePadding.right,
        20.h,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const DashboardFilterBar(),
              Gap(18.h),
              Text(
                l10n.dashboardPositionsAvailable(totalPositions),
                textAlign: TextAlign.start,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.themeTextSecondary,
                  fontSize: 16.sp,
                ),
              ),
              Gap(16.h),
              if (filteredJobs.isEmpty)
                JobListingEmptyView(
                  title: l10n.dashboardEmptyJobsTitle,
                  message: l10n.dashboardNoJobsFound,
                )
              else ...[
                for (var i = 0; i < jobs.length; i++) ...[
                  if (i > 0) Gap(12.h),
                  DashboardJobCard(
                    job: jobs[i],
                    onTap: () {
                      context.goNamed(
                        AppRouteNames.jobDetail,
                        queryParameters: DeepLink.jobDetailQuery(
                          jobId: jobs[i].id,
                        ),
                      );
                    },
                  ),
                ],
                Gap(16.h),
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
          ),
        ),
      ),
    );
  }
}
