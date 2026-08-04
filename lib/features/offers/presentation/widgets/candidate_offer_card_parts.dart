part of 'candidate_offer_card.dart';

class _OfferHeader extends StatelessWidget {
  const _OfferHeader({required this.offer});

  final CandidateOffer offer;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                offer.jobTitle,
                style: context.textTheme.titleSmall?.copyWith(
                  color: context.themeTextPrimary,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  height: 1.25,
                ),
              ),
              if (offer.subtitle.isNotEmpty) ...[
                Gap(4.h),
                Text(
                  offer.subtitle,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.themeTextSecondary,
                    fontSize: 13.sp,
                    height: 1.35,
                  ),
                ),
              ],
            ],
          ),
        ),
        Gap(12.w),
        AppStatusCapsule(status: offer.statusCode),
      ],
    );
  }
}

class _SalaryHighlight extends StatelessWidget {
  const _SalaryHighlight({required this.salary});

  final String salary;

  @override
  Widget build(BuildContext context) {
    final missing = CandidateOffer.isMissing(salary);
    final color = missing
        ? context.themeTextMuted
        : (context.isDark ? AppColors.infoTextDark : AppColors.infoText);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.isDark ? AppColors.infoBgDark : AppColors.infoBg,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: context.isDark
              ? AppColors.infoBorderDark
              : AppColors.infoBorder,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        child: Row(
          children: [
            Icon(Icons.payments_outlined, size: 20.sp, color: color),
            Gap(10.w),
            Expanded(
              child: Text(
                missing ? CandidateOffer.missingValue : salary,
                style: context.textTheme.titleSmall?.copyWith(
                  color: color,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final missing = CandidateOffer.isMissing(label);
    final color = missing ? context.themeTextMuted : context.themeTextSecondary;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.isDark
            ? AppColors.cardBackgroundGreyDark.withValues(alpha: 0.55)
            : AppColors.cardBackgroundGrey,
        borderRadius: BorderRadius.circular(999.r),
        border: Border.all(color: context.themeCardBorder),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
        child: AppMetaItem(
          icon: icon,
          label: missing ? CandidateOffer.missingValue : label,
          color: color,
          iconSize: 14.sp,
          iconGap: 6.w,
          fontSize: 13.sp,
        ),
      ),
    );
  }
}

class _OfferFooter extends StatelessWidget {
  const _OfferFooter({
    required this.offer,
    required this.l10n,
    required this.isAccepting,
    required this.isDeclining,
    required this.isProcessing,
    required this.onAccept,
    required this.onDecline,
    required this.onView,
  });

  final CandidateOffer offer;
  final AppLocalizations l10n;
  final bool isAccepting;
  final bool isDeclining;
  final bool isProcessing;
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;
  final VoidCallback? onView;

  static final _padding = EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h);

  @override
  Widget build(BuildContext context) {
    final dates = _Dates(offer: offer, l10n: l10n);
    final actions = _Actions(
      canRespond: offer.canRespond,
      l10n: l10n,
      isAccepting: isAccepting,
      isDeclining: isDeclining,
      enabled: !isProcessing,
      onAccept: onAccept,
      onDecline: onDecline,
      onView: onView,
      stretch: context.isMobileLayout,
    );

    if (context.isMobileLayout) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [dates, Gap(12.h), actions],
      );
    }

    return Row(
      children: [
        Expanded(child: dates),
        Gap(12.w),
        actions,
      ],
    );
  }
}

class _Dates extends StatelessWidget {
  const _Dates({required this.offer, required this.l10n});

  final CandidateOffer offer;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final format = DateFormat.yMMMd(l10n.localeName);
    final urgent = offer.isExpiryUrgent;
    final expiryColor = urgent
        ? (context.isDark ? AppColors.warningTextDark : AppColors.warningText)
        : context.themeTextMuted;

    String label(DateTime? date) =>
        date != null ? format.format(date) : CandidateOffer.missingValue;

    return Wrap(
      spacing: 16.w,
      runSpacing: 6.h,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        AppMetaItem(
          icon: Icons.send_outlined,
          label: l10n.candidateOfferSentOn(label(offer.sentDate)),
          color: context.themeTextMuted,
          fontSize: 12.sp,
        ),
        AppMetaItem(
          icon: urgent ? Icons.event_busy_outlined : Icons.event_outlined,
          label: l10n.candidateOfferExpiresOn(label(offer.expiryDate)),
          color: expiryColor,
          fontSize: 12.sp,
        ),
      ],
    );
  }
}

class _Actions extends StatelessWidget {
  const _Actions({
    required this.canRespond,
    required this.l10n,
    required this.isAccepting,
    required this.isDeclining,
    required this.enabled,
    required this.onAccept,
    required this.onDecline,
    required this.onView,
    required this.stretch,
  });

  final bool canRespond;
  final AppLocalizations l10n;
  final bool isAccepting;
  final bool isDeclining;
  final bool enabled;
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;
  final VoidCallback? onView;
  final bool stretch;

  @override
  Widget build(BuildContext context) {
    final view = _btn(l10n.candidateOfferView, AppButtonType.outline, onView);

    if (!canRespond) {
      return stretch
          ? view
          : Align(alignment: AlignmentDirectional.centerEnd, child: view);
    }

    final accept = _btn(
      l10n.candidateOfferAccept,
      AppButtonType.primary,
      onAccept,
      loading: isAccepting,
    );
    final decline = AppButton.dangerOutline(
      label: l10n.candidateOfferDecline,
      padding: _OfferFooter._padding,
      isLoading: isDeclining,
      width: stretch ? double.infinity : null,
      onPressed: enabled ? onDecline : null,
    );

    if (!stretch) {
      return Wrap(
        spacing: 8.w,
        runSpacing: 8.h,
        alignment: WrapAlignment.end,
        children: [view, decline, accept],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        accept,
        Gap(8.h),
        Row(
          children: [
            Expanded(child: decline),
            Gap(8.w),
            Expanded(child: view),
          ],
        ),
      ],
    );
  }

  AppButton _btn(
    String label,
    AppButtonType type,
    VoidCallback? onPressed, {
    bool loading = false,
  }) {
    return AppButton(
      label: label,
      type: type,
      padding: _OfferFooter._padding,
      width: stretch ? double.infinity : null,
      isLoading: loading,
      onPressed: enabled ? onPressed : null,
    );
  }
}
