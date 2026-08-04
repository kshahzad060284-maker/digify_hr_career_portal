import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/core/widgets/app_status_capsule.dart';
import 'package:career_portal/features/offers/domain/models/candidate_offer.dart';
import 'package:career_portal/features/offers/presentation/providers/candidate_offers_list_provider.dart';
import 'package:career_portal/shared/widgets/common/app_button.dart';
import 'package:career_portal/shared/widgets/common/app_divider.dart';
import 'package:career_portal/shared/widgets/common/app_meta_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

part 'candidate_offer_card_parts.dart';

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(candidateOffersControllerProvider).value;
    final guid = offer.offerGuid;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.themeCardBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: context.themeCardBorder),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20.w, 20.h, 20.w, 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _OfferHeader(offer: offer),
            Gap(14.h),
            _SalaryHighlight(salary: offer.salary),
            Gap(12.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                _MetaChip(
                  icon: Icons.location_on_outlined,
                  label: offer.location,
                ),
                _MetaChip(
                  icon: Icons.schedule_outlined,
                  label: offer.employmentType,
                ),
              ],
            ),
            if (offer.visibleStageDescription case final description?) ...[
              Gap(12.h),
              Text(
                description,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.themeTextMuted,
                  fontSize: 13.sp,
                  height: 1.4,
                ),
              ),
            ],
            Gap(14.h),
            const AppDivider.thin(),
            Gap(12.h),
            _OfferFooter(
              offer: offer,
              l10n: l10n,
              isAccepting: state?.isAccepting(guid) ?? false,
              isDeclining: state?.isDeclining(guid) ?? false,
              isProcessing: state?.isProcessing(guid) ?? false,
              onAccept: onAccept,
              onDecline: onDecline,
              onView: onView,
            ),
          ],
        ),
      ),
    );
  }
}
