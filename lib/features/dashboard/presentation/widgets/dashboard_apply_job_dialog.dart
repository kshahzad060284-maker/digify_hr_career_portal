import 'package:career_portal/core/config/app_config.dart';
import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/network/app_exception.dart';
import 'package:career_portal/core/enterprise/enterprise_id_provider.dart';
import 'package:career_portal/core/services/toast/toast_service.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:career_portal/features/dashboard/domain/models/apply_job_input.dart';
import 'package:career_portal/features/dashboard/domain/models/dashboard_job.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_jobs_di_provider.dart';
import 'package:career_portal/shared/widgets/common/app_button.dart';
import 'package:career_portal/shared/widgets/common/app_dialog.dart';
import 'package:career_portal/shared/widgets/common/app_file_upload_field.dart';
import 'package:career_portal/shared/widgets/common/app_text_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class DashboardApplyJobDialog extends ConsumerStatefulWidget {
  const DashboardApplyJobDialog({super.key, required this.job});

  final DashboardJob job;

  static Future<bool?> show(BuildContext context, {required DashboardJob job}) {
    return showDialog<bool>(
      context: context,
      builder: (context) => DashboardApplyJobDialog(job: job),
    );
  }

  @override
  ConsumerState<DashboardApplyJobDialog> createState() =>
      _DashboardApplyJobDialogState();
}

class _DashboardApplyJobDialogState
    extends ConsumerState<DashboardApplyJobDialog> {
  static const _resumeExtensions = ['pdf', 'doc', 'docx'];

  final _sourceController = TextEditingController(
    text: AppConfig.defaultJobApplySourceCode,
  );
  PlatformFile? _resumeFile;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _sourceController.dispose();
    super.dispose();
  }

  Future<void> _pickResume() async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: _resumeExtensions,
      withData: true,
    );
    if (!mounted || result == null || result.files.isEmpty) return;
    setState(() => _resumeFile = result.files.first);
  }

  void _clearResume() => setState(() => _resumeFile = null);

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context)!;
    final sourceCode = _sourceController.text.trim();

    if (sourceCode.isEmpty) {
      ToastService.error(context, l10n.dashboardJobApplySourceRequired);
      return;
    }
    if (_resumeFile == null) {
      ToastService.error(context, l10n.dashboardJobApplyResumeRequired);
      return;
    }

    final resumeBytes = _resumeFile!.bytes;
    if (resumeBytes == null || resumeBytes.isEmpty) {
      ToastService.error(context, l10n.dashboardJobApplyResumeInvalid);
      return;
    }

    final candidateGuid = ref.read(authSessionProvider).session?.candidateGuid;
    if (candidateGuid == null || candidateGuid.isEmpty) {
      ToastService.error(context, l10n.dashboardJobApplySessionRequired);
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      await ref
          .read(applyJobUseCaseProvider)
          .call(
            ApplyJobInput(
              postingGuid: widget.job.id,
              enterpriseId: ref.read(enterpriseIdProvider),
              candidateGuid: candidateGuid,
              sourceCode: sourceCode,
              resumeFileName: _resumeFile!.name,
              resumeBytes: resumeBytes,
              createdBy: AppConfig.defaultJobApplyCreatedBy,
            ),
          );

      if (!mounted) return;
      ToastService.success(context, l10n.dashboardJobApplySuccess);
      context.pop(true);
    } on AppException catch (error) {
      if (!mounted) return;
      ToastService.error(
        context,
        error.message.isNotEmpty ? error.message : l10n.dashboardJobApplyFailed,
      );
    } catch (_) {
      if (!mounted) return;
      ToastService.error(context, l10n.dashboardJobApplyFailed);
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = context.isDark;
    final fillColor = isDark ? AppColors.inputBgDark : AppColors.authInputFill;

    return AppDialog(
      title: l10n.dashboardJobApplyDialogTitle,
      subtitle: l10n.dashboardJobApplyDialogSubtitle(widget.job.title),
      width: 520.w,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            labelText: l10n.authSource,
            isRequired: true,
            controller: _sourceController,
            hintText: l10n.authSourceHint,
            filled: true,
            fillColor: fillColor,
            readOnly: _isSubmitting,
          ),
          Gap(16.h),
          AppFileUploadField(
            labelText: l10n.dashboardJobApplyResume,
            isRequired: true,
            hintText: l10n.dashboardJobApplyResumeHint,
            chooseFileLabel: l10n.dashboardJobApplyChooseFile,
            fileName: _resumeFile?.name,
            fillColor: fillColor,
            onPick: _isSubmitting ? () {} : _pickResume,
            onClear: _isSubmitting ? null : _clearResume,
          ),
        ],
      ),
      actions: [
        AppButton.outline(
          label: l10n.commonCancel,
          onPressed: _isSubmitting ? null : () => context.pop(),
        ),
        SizedBox(width: 12.w),
        AppButton.primary(
          label: l10n.dashboardJobApplySubmit,
          isLoading: _isSubmitting,
          onPressed: _isSubmitting ? null : _submit,
        ),
      ],
    );
  }
}
