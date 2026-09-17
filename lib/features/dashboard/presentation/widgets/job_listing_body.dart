import 'package:career_portal/core/deep_link/deep_link.dart';
import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/router/app_routes.dart';
import 'package:career_portal/core/theme/app_colors.dart';
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

enum _SortOption { newest, oldest }

class JobListingBody extends ConsumerWidget {
  const JobListingBody({
    required this.jobsState,
    required this.pagePadding,
    required this.maxWidth,
    super.key,
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
              const DashboardActiveFilters(),
              _ListingHeader(totalPositions: totalPositions),
              Gap(24.h),
              if (filteredJobs.isEmpty)
                JobListingEmptyView(
                  title: l10n.dashboardEmptyJobsTitle,
                  message: l10n.dashboardNoJobsFound,
                )
              else ...[
                for (var i = 0; i < jobs.length; i++) ...[
                  if (i > 0) Gap(16.h),
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
                PaginationControls.fromPaginationInfo(
                  paginationInfo: pagination,
                  currentPage: currentPage,
                  pageSize: jobsState.pageSize,
                  showBorder: false,
                  padding: EdgeInsets.only(top: 48.h, bottom: 32.h),
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

class _ListingHeader extends StatefulWidget {
  const _ListingHeader({required this.totalPositions});

  final int totalPositions;

  @override
  State<_ListingHeader> createState() => _ListingHeaderState();
}

class _ListingHeaderState extends State<_ListingHeader> {
  _SortOption _sort = _SortOption.newest;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final subtleColor = isDark
        ? AppColors.textTertiaryDark
        : AppColors.textSecondary;
    final borderColor = isDark
        ? AppColors.cardBorderDark
        : AppColors.cardBorder;
    final bgColor = isDark
        ? AppColors.cardBackgroundDark
        : AppColors.cardBackground;
    final l10n = AppLocalizations.of(context)!;

    return Row(
      children: [
        Expanded(
          child: Text(
            l10n.dashboardPositionsAvailable(widget.totalPositions),
            style: context.textTheme.bodyMedium?.copyWith(
              color: subtleColor,
              fontSize: 14.sp,
            ),
          ),
        ),
        Gap(12.w),
        Container(
          height: 36.h,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: borderColor),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<_SortOption>(
              value: _sort,
              isDense: true,
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 18.w,
                color: subtleColor,
              ),
              style: context.textTheme.bodySmall?.copyWith(
                color: subtleColor,
                fontSize: 13.sp,
              ),
              dropdownColor: bgColor,
              borderRadius: BorderRadius.circular(8.r),
              items: const [
                DropdownMenuItem(
                  value: _SortOption.newest,
                  child: Text('Sort by: Newest'),
                ),
                DropdownMenuItem(
                  value: _SortOption.oldest,
                  child: Text('Sort by: Oldest'),
                ),
              ],
              onChanged: (value) {
                if (value != null) setState(() => _sort = value);
              },
            ),
          ),
        ),
      ],
    );
  }
}
