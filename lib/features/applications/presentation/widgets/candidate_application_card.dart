import 'package:career_portal/core/deep_link/deep_link.dart';
import 'package:career_portal/core/enterprise/enterprise_id_provider.dart';
import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/router/app_routes.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/core/utils/open_external_url.dart';
import 'package:career_portal/core/widgets/app_status_capsule.dart';
import 'package:career_portal/features/applications/domain/helpers/application_resume_url_builder.dart';
import 'package:career_portal/features/applications/domain/models/candidate_application.dart';
import 'package:career_portal/shared/widgets/common/app_button.dart';
import 'package:career_portal/shared/widgets/common/app_divider.dart';
import 'package:career_portal/shared/widgets/common/app_meta_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class CandidateApplicationCard extends ConsumerWidget {
  const CandidateApplicationCard({super.key, required this.application});

  final CandidateApplication application;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final dateFormat = DateFormat.yMMMd(l10n.localeName);
    final statusLabel = application.stageCode.isNotEmpty
        ? application.stageCode
        : application.statusCode;
    final resumeFileName = application.resumeFileName?.trim();
    final canOpenResume =
        resumeFileName != null &&
        resumeFileName.isNotEmpty &&
        application.applicationGuid.isNotEmpty;

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
                        application.postingTitle.isNotEmpty
                            ? application.postingTitle
                            : application.requisitionTitle,
                        style: context.textTheme.titleSmall?.copyWith(
                          color: context.themeTextPrimary,
                          fontSize: 20.sp,
                        ),
                      ),
                      if (_subtitle(application).isNotEmpty)
                        Text(
                          _subtitle(application),
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.themeTextSecondary,
                            fontSize: 14.sp,
                          ),
                        ),
                    ],
                  ),
                ),
                Gap(12.w),
                if (statusLabel.isNotEmpty)
                  AppStatusCapsule(status: statusLabel),
              ],
            ),
            if (canOpenResume)
              _ResumeLink(
                fileName: resumeFileName,
                onTap: () {
                  final url = ApplicationResumeUrlBuilder.build(
                    applicationGuid: application.applicationGuid,
                    enterpriseId: ref.read(enterpriseIdProvider),
                  );
                  openExternalUrl(url);
                },
              )
            else if (resumeFileName != null && resumeFileName.isNotEmpty)
              AppMetaItem(
                icon: Icons.attach_file_rounded,
                label: resumeFileName,
                expanded: true,
              ),
            const AppDivider.thin(),
            Row(
              children: [
                if (application.appliedDate != null)
                  Expanded(
                    child: AppMetaItem(
                      icon: Icons.calendar_today_outlined,
                      label: l10n.candidateApplicationAppliedOn(
                        dateFormat.format(application.appliedDate!),
                      ),
                      color: context.themeTextMuted,
                      fontSize: 13.sp,
                    ),
                  )
                else
                  const Spacer(),
                if (application.postingGuid.isNotEmpty)
                  AppButton(
                    label: l10n.candidateApplicationViewJob,
                    type: AppButtonType.outline,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 4.h,
                    ),
                    onPressed: () {
                      context.goNamed(
                        AppRouteNames.jobDetail,
                        queryParameters: DeepLink.jobDetailQuery(
                          jobId: application.postingGuid,
                        ),
                      );
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _subtitle(CandidateApplication application) {
    return [
      if (application.applicationNumber.isNotEmpty)
        application.applicationNumber,
      if (application.requisitionTitle.isNotEmpty &&
          application.postingTitle.isNotEmpty)
        application.requisitionTitle,
    ].join(' · ');
  }
}

class _ResumeLink extends StatelessWidget {
  const _ResumeLink({required this.fileName, required this.onTap});

  final String fileName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4.r),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h),
          child: Row(
            children: [
              Icon(
                Icons.attach_file_rounded,
                size: 16.sp,
                color: AppColors.primary,
              ),
              Gap(4.w),
              Expanded(
                child: Text(
                  fileName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: AppColors.primary,
                    fontSize: 14.sp,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
