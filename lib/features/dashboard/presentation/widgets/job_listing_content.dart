import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/network/app_exception.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/services/responsive/responsive_helper.dart';
import 'package:career_portal/core/services/toast/toast_service.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_jobs_list_provider.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_content_header.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_footer.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_job_card_skeleton.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/job_listing_body.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/job_listing_error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    final maxWidth = ResponsiveHelper.maxContentWidth(context);

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
      child: LayoutBuilder(
        builder: (context, constraints) {
          final minBodyHeight = constraints.maxHeight;

          return CustomScrollView(
            primary: true,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              const DashboardHeroSliver(),
              SliverToBoxAdapter(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: minBodyHeight),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      jobsAsync.when(
                        skipLoadingOnReload: false,
                        skipLoadingOnRefresh: false,
                        loading: () => Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                            pagePadding.left,
                            20.h,
                            pagePadding.right,
                            20.h,
                          ),
                          child: Center(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: maxWidth),
                              child: const DashboardJobListSkeleton(),
                            ),
                          ),
                        ),
                        error: (error, _) => Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                            pagePadding.left,
                            20.h,
                            pagePadding.right,
                            20.h,
                          ),
                          child: Center(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: maxWidth),
                              child: JobListingErrorView(
                                message: error is AppException
                                    ? error.message
                                    : l10n.dashboardJobsLoadFailed,
                                onRetry: () => ref
                                    .read(
                                      dashboardJobsControllerProvider.notifier,
                                    )
                                    .refresh(),
                              ),
                            ),
                          ),
                        ),
                        data: (jobsState) => JobListingBody(
                          jobsState: jobsState,
                          pagePadding: pagePadding,
                          maxWidth: maxWidth,
                        ),
                      ),
                      const DashboardFooter(),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
