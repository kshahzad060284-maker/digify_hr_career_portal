import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/network/app_exception.dart';
import 'package:career_portal/core/services/responsive/responsive_helper.dart';
import 'package:career_portal/core/services/toast/toast_service.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/core/widgets/pagination_controls.dart';
import 'package:career_portal/features/applications/presentation/providers/candidate_applications_list_provider.dart';
import 'package:career_portal/features/applications/presentation/widgets/candidate_application_card.dart';
import 'package:career_portal/features/applications/presentation/widgets/candidate_application_card_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CandidateApplicationsPage extends ConsumerStatefulWidget {
  const CandidateApplicationsPage({super.key});

  @override
  ConsumerState<CandidateApplicationsPage> createState() =>
      _CandidateApplicationsPageState();
}

class _CandidateApplicationsPageState
    extends ConsumerState<CandidateApplicationsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchApplications());
  }

  void _fetchApplications() {
    if (!mounted) return;
    ref.invalidate(candidateApplicationsControllerProvider);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final applicationsAsync = ref.watch(
      candidateApplicationsControllerProvider,
    );
    final pagePadding = ResponsiveHelper.pagePadding(context);
    final isDark = context.isDark;
    final sectionBg = isDark
        ? AppColors.backgroundDark
        : AppColors.sidebarSearchBg;

    ref.listen(candidateApplicationsControllerProvider, (previous, next) {
      if (next.hasError && previous?.hasError != true) {
        final error = next.error;
        final message = error is AppException
            ? error.message
            : l10n.candidateApplicationsLoadFailed;
        ToastService.error(context, message);
      }
    });

    return ColoredBox(
      color: sectionBg,
      child: SingleChildScrollView(
        primary: true,
        padding: EdgeInsetsDirectional.fromSTEB(
          pagePadding.left,
          48.h,
          pagePadding.right,
          48.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 24.h,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8.h,
              children: [
                Text(
                  l10n.candidateApplicationsTitle,
                  style: context.textTheme.headlineSmall?.copyWith(
                    color: context.themeTextPrimary,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  l10n.candidateApplicationsSubtitle,
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: context.themeTextSecondary,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
            applicationsAsync.when(
              skipLoadingOnReload: false,
              skipLoadingOnRefresh: false,
              loading: () =>
                  const CandidateApplicationsListSkeleton(itemCount: 3),
              error: (error, _) => _CandidateApplicationsErrorView(
                message: error is AppException
                    ? error.message
                    : l10n.candidateApplicationsLoadFailed,
                onRetry: () => ref
                    .read(candidateApplicationsControllerProvider.notifier)
                    .refresh(),
              ),
              data: (applicationsState) {
                final controller = ref.read(
                  candidateApplicationsControllerProvider.notifier,
                );

                if (applicationsState.applications.isEmpty) {
                  return _CandidateApplicationsEmptyState(
                    message: l10n.candidateApplicationsEmpty,
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 24.h,
                  children: [
                    Text(
                      l10n.candidateApplicationsCount(
                        applicationsState.pagination.totalItems,
                      ),
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.themeTextSecondary,
                        fontSize: 14.sp,
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: applicationsState.applications.length,
                      separatorBuilder: (_, _) => Gap(16.h),
                      itemBuilder: (context, index) {
                        return CandidateApplicationCard(
                          application: applicationsState.applications[index],
                        );
                      },
                    ),
                    if (applicationsState.pagination.totalItems >
                        applicationsState.pageSize)
                      PaginationControls.fromPaginationInfo(
                        paginationInfo: applicationsState.pagination,
                        currentPage: applicationsState.currentPage,
                        pageSize: applicationsState.pageSize,
                        showBorder: false,
                        padding: EdgeInsets.zero,
                        onPrevious: applicationsState.pagination.hasPrevious
                            ? controller.goToPreviousPage
                            : null,
                        onNext: applicationsState.pagination.hasNext
                            ? controller.goToNextPage
                            : null,
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _CandidateApplicationsEmptyState extends StatelessWidget {
  const _CandidateApplicationsEmptyState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.themeCardBackground,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: context.themeCardBorder),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 48.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16.h,
          children: [
            Icon(
              Icons.assignment_outlined,
              size: 48.sp,
              color: AppColors.primary.withValues(alpha: 0.7),
            ),
            Text(
              message,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.themeTextSecondary,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CandidateApplicationsErrorView extends StatelessWidget {
  const _CandidateApplicationsErrorView({
    required this.message,
    required this.onRetry,
  });

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
