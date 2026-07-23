import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/widgets/app_status_capsule.dart';
import 'package:career_portal/features/offers/domain/models/candidate_offer.dart';
import 'package:career_portal/features/offers/presentation/providers/candidate_offers_list_provider.dart';
import 'package:career_portal/shared/widgets/common/app_button.dart';
import 'package:career_portal/shared/widgets/common/app_meta_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class CandidateOfferCard extends ConsumerWidget {
  const CandidateOfferCard({
    super.key,
    required this.offer,
    this.onAccept,
    this.onDecline,
    this.onView,
  });

  final CandidateOffer offer;
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;
  final VoidCallback? onView;

  static final _compactButtonPadding = EdgeInsets.symmetric(
    horizontal: 12.w,
    vertical: 4.h,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final offersState = ref.watch(candidateOffersControllerProvider).value;
    final isAccepting = offersState?.isAccepting(offer.offerGuid) ?? false;
    final isDeclining = offersState?.isDeclining(offer.offerGuid) ?? false;
    final isProcessing = offersState?.isProcessing(offer.offerGuid) ?? false;
    final dateFormat = DateFormat.yMMMd(l10n.localeName);
    final subtitle = _buildSubtitle(offer);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.themeCardBackground,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: context.themeCardBorder),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4.h,
                    children: [
                      Text(
                        offer.jobTitle,
                        style: context.textTheme.titleSmall?.copyWith(
                          color: context.themeTextPrimary,
                          fontSize: 20.sp,
                        ),
                      ),
                      if (subtitle.isNotEmpty)
                        Text(
                          subtitle,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.themeTextSecondary,
                            fontSize: 14.sp,
                          ),
                        ),
                    ],
                  ),
                ),
                Gap(12.w),
                AppStatusCapsule(status: offer.statusCode),
              ],
            ),
            Wrap(
              spacing: 16.w,
              runSpacing: 8.h,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                if (offer.location.isNotEmpty)
                  AppMetaItem(
                    icon: Icons.location_on_outlined,
                    label: offer.location,
                  ),
                if (offer.employmentType.isNotEmpty)
                  AppMetaItem(
                    icon: Icons.schedule_outlined,
                    label: offer.employmentType,
                  ),
                if (offer.salary.isNotEmpty)
                  AppMetaItem(
                    icon: Icons.payments_outlined,
                    label: offer.salary,
                  ),
              ],
            ),
            Divider(height: 1.h, color: context.themeCardBorder),
            Wrap(
              spacing: 16.w,
              runSpacing: 4.h,
              children: [
                if (offer.sentDate != null)
                  AppMetaItem(
                    icon: Icons.send_outlined,
                    label: l10n.candidateOfferSentOn(
                      dateFormat.format(offer.sentDate!),
                    ),
                    color: context.themeTextMuted,
                    fontSize: 13.sp,
                  ),
                if (offer.expiryDate != null)
                  AppMetaItem(
                    icon: Icons.event_outlined,
                    label: l10n.candidateOfferExpiresOn(
                      dateFormat.format(offer.expiryDate!),
                    ),
                    color: context.themeTextMuted,
                    fontSize: 13.sp,
                  ),
              ],
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (offer.canRespond) ...[
                    AppButton(
                      label: l10n.candidateOfferAccept,
                      type: AppButtonType.primary,
                      padding: _compactButtonPadding,
                      isLoading: isAccepting,
                      onPressed: isProcessing ? null : onAccept,
                    ),
                    Gap(8.w),
                    AppButton.dangerOutline(
                      label: l10n.candidateOfferDecline,
                      padding: _compactButtonPadding,
                      isLoading: isDeclining,
                      onPressed: isProcessing ? null : onDecline,
                    ),
                    Gap(8.w),
                  ],
                  AppButton(
                    label: l10n.candidateOfferView,
                    type: AppButtonType.outline,
                    padding: _compactButtonPadding,
                    onPressed: isProcessing ? null : onView,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _buildSubtitle(CandidateOffer offer) {
    final parts = <String>[
      if (offer.postingTitle.isNotEmpty)
        offer.postingTitle
      else
        offer.offerNumber,
      if (offer.department.isNotEmpty) offer.department,
    ];
    return parts.join(' · ');
  }
}
