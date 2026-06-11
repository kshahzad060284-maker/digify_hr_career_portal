import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/network/app_exception.dart';
import 'package:career_portal/core/services/responsive/responsive_helper.dart';
import 'package:career_portal/core/services/toast/toast_service.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/core/widgets/pagination_controls.dart';
import 'package:career_portal/features/offers/presentation/providers/candidate_offers_list_provider.dart';
import 'package:career_portal/features/offers/presentation/widgets/candidate_offer_card.dart';
import 'package:career_portal/features/offers/presentation/widgets/candidate_offer_card_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CandidateOffersPage extends ConsumerStatefulWidget {
  const CandidateOffersPage({super.key});

  @override
  ConsumerState<CandidateOffersPage> createState() =>
      _CandidateOffersPageState();
}

class _CandidateOffersPageState extends ConsumerState<CandidateOffersPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchOffers());
  }

  void _fetchOffers() {
    if (!mounted) return;
    ref.invalidate(candidateOffersControllerProvider);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final offersAsync = ref.watch(candidateOffersControllerProvider);
    final pagePadding = ResponsiveHelper.pagePadding(context);
    final isDark = context.isDark;
    final sectionBg = isDark
        ? AppColors.backgroundDark
        : AppColors.sidebarSearchBg;

    ref.listen(candidateOffersControllerProvider, (previous, next) {
      if (next.hasError && previous?.hasError != true) {
        final error = next.error;
        final message = error is AppException
            ? error.message
            : l10n.candidateOffersLoadFailed;
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 24.h,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8.h,
              children: [
                Text(
                  l10n.candidateOffersTitle,
                  style: context.textTheme.headlineSmall?.copyWith(
                    color: context.themeTextPrimary,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  l10n.candidateOffersSubtitle,
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: context.themeTextSecondary,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
            offersAsync.when(
              loading: () => const CandidateOffersListSkeleton(itemCount: 3),
              error: (error, _) => _CandidateOffersErrorView(
                message: error is AppException
                    ? error.message
                    : l10n.candidateOffersLoadFailed,
                onRetry: () => ref
                    .read(candidateOffersControllerProvider.notifier)
                    .refresh(),
              ),
              data: (offersState) {
                final isReloading = offersAsync.isLoading;
                final offersController = ref.read(
                  candidateOffersControllerProvider.notifier,
                );

                if (isReloading) {
                  return const CandidateOffersListSkeleton(itemCount: 3);
                }

                if (offersState.offers.isEmpty) {
                  return _CandidateOffersEmptyState(
                    message: l10n.candidateOffersEmpty,
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 24.h,
                  children: [
                    Text(
                      l10n.candidateOffersCount(
                        offersState.pagination.totalItems,
                      ),
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.themeTextSecondary,
                        fontSize: 14.sp,
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: offersState.offers.length,
                      separatorBuilder: (_, _) => Gap(16.h),
                      itemBuilder: (context, index) {
                        return CandidateOfferCard(
                          offer: offersState.offers[index],
                        );
                      },
                    ),
                    if (offersState.pagination.totalItems >
                        offersState.pageSize)
                      PaginationControls.fromPaginationInfo(
                        paginationInfo: offersState.pagination,
                        currentPage: offersState.currentPage,
                        pageSize: offersState.pageSize,
                        showBorder: false,
                        padding: EdgeInsets.zero,
                        onPrevious: offersState.pagination.hasPrevious
                            ? offersController.goToPreviousPage
                            : null,
                        onNext: offersState.pagination.hasNext
                            ? offersController.goToNextPage
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

class _CandidateOffersEmptyState extends StatelessWidget {
  const _CandidateOffersEmptyState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.themeCardBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: context.themeCardBorder),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 48.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16.h,
          children: [
            Icon(
              Icons.description_outlined,
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

class _CandidateOffersErrorView extends StatelessWidget {
  const _CandidateOffersErrorView({
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
