import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/network/app_exception.dart';
import 'package:career_portal/core/services/toast/toast_service.dart';
import 'package:career_portal/core/widgets/app_status_capsule.dart';
import 'package:career_portal/features/offers/domain/models/candidate_offer.dart';
import 'package:career_portal/features/offers/presentation/providers/candidate_offers_list_provider.dart';
import 'package:career_portal/shared/widgets/common/app_button.dart';
import 'package:career_portal/shared/widgets/common/app_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class CandidateOfferCard extends ConsumerWidget {
  const CandidateOfferCard({super.key, required this.offer, this.onView});

  final CandidateOffer offer;
  final VoidCallback? onView;

  static final _compactButtonPadding = EdgeInsets.symmetric(
    horizontal: 12.w,
    vertical: 4.h,
  );

  Future<void> _onAccept(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await AppConfirmationDialog.show(
      context,
      title: l10n.candidateOfferAcceptTitle,
      message: l10n.candidateOfferAcceptMessage,
      itemName: offer.jobTitle,
      confirmLabel: l10n.candidateOfferAccept,
      cancelLabel: l10n.commonCancel,
      type: ConfirmationType.success,
      icon: Icons.check_circle_outline_rounded,
    );

    if (confirmed != true || !context.mounted) return;

    try {
      await ref
          .read(candidateOffersControllerProvider.notifier)
          .acceptOffer(offer.offerGuid);
      if (!context.mounted) return;
      ToastService.success(context, l10n.candidateOfferAcceptSuccess);
    } on AppException catch (error) {
      if (!context.mounted) return;
      ToastService.error(
        context,
        error.message.isNotEmpty
            ? error.message
            : l10n.candidateOfferAcceptFailed,
      );
    } catch (_) {
      if (!context.mounted) return;
      ToastService.error(context, l10n.candidateOfferAcceptFailed);
    }
  }

  Future<void> _onDecline(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final comments = await AppConfirmationDialog.showWithInput(
      context,
      title: l10n.candidateOfferDeclineTitle,
      message: l10n.candidateOfferDeclineMessage,
      itemName: offer.jobTitle,
      confirmLabel: l10n.candidateOfferDecline,
      cancelLabel: l10n.commonCancel,
      type: ConfirmationType.danger,
      icon: Icons.cancel_outlined,
      textFieldLabel: l10n.candidateOfferDeclineCommentsLabel,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return l10n.candidateOfferDeclineCommentsRequired;
        }
        return null;
      },
    );

    if (comments == null || comments.trim().isEmpty || !context.mounted) return;

    try {
      await ref
          .read(candidateOffersControllerProvider.notifier)
          .declineOffer(
            offerGuid: offer.offerGuid,
            declineComments: comments.trim(),
          );
      if (!context.mounted) return;
      ToastService.success(context, l10n.candidateOfferDeclineSuccess);
    } on AppException catch (error) {
      if (!context.mounted) return;
      ToastService.error(
        context,
        error.message.isNotEmpty
            ? error.message
            : l10n.candidateOfferDeclineFailed,
      );
    } catch (_) {
      if (!context.mounted) return;
      ToastService.error(context, l10n.candidateOfferDeclineFailed);
    }
  }

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
        borderRadius: BorderRadius.circular(12.r),
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
                  _OfferMetaItem(
                    icon: Icons.location_on_outlined,
                    label: offer.location,
                  ),
                if (offer.employmentType.isNotEmpty)
                  _OfferMetaItem(
                    icon: Icons.schedule_outlined,
                    label: offer.employmentType,
                  ),
                if (offer.salary.isNotEmpty)
                  _OfferMetaItem(
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
                  _OfferDateText(
                    label: l10n.candidateOfferSentOn(
                      dateFormat.format(offer.sentDate!),
                    ),
                  ),
                if (offer.expiryDate != null)
                  _OfferDateText(
                    label: l10n.candidateOfferExpiresOn(
                      dateFormat.format(offer.expiryDate!),
                    ),
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
                      onPressed: isProcessing
                          ? null
                          : () => _onAccept(context, ref),
                    ),
                    Gap(8.w),
                    AppButton.dangerOutline(
                      label: l10n.candidateOfferDecline,
                      padding: _compactButtonPadding,
                      isLoading: isDeclining,
                      onPressed: isProcessing
                          ? null
                          : () => _onDecline(context, ref),
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

class _OfferMetaItem extends StatelessWidget {
  const _OfferMetaItem({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final color = context.themeTextSecondary;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16.sp, color: color),
        Gap(4.w),
        Text(
          label,
          style: context.textTheme.bodyMedium?.copyWith(
            color: color,
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }
}

class _OfferDateText extends StatelessWidget {
  const _OfferDateText({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: context.textTheme.bodySmall?.copyWith(
        color: context.themeTextMuted,
        fontSize: 13.sp,
      ),
    );
  }
}
