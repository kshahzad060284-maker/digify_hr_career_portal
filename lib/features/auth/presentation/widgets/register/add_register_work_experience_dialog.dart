import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/services/toast/toast_service.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/auth/domain/config/auth_form_config.dart';
import 'package:career_portal/features/auth/domain/models/register_work_experience_entry.dart';
import 'package:career_portal/shared/widgets/common/app_button.dart';
import 'package:career_portal/shared/widgets/common/app_dialog.dart';
import 'package:career_portal/shared/widgets/common/app_select_field.dart';
import 'package:career_portal/shared/widgets/common/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AddRegisterWorkExperienceDialog extends StatefulWidget {
  const AddRegisterWorkExperienceDialog({super.key, this.initialEntry});

  final RegisterWorkExperienceEntry? initialEntry;

  static Future<RegisterWorkExperienceEntry?> show(
    BuildContext context, {
    RegisterWorkExperienceEntry? initialEntry,
  }) {
    return showDialog<RegisterWorkExperienceEntry>(
      context: context,
      builder: (context) =>
          AddRegisterWorkExperienceDialog(initialEntry: initialEntry),
    );
  }

  @override
  State<AddRegisterWorkExperienceDialog> createState() =>
      _AddRegisterWorkExperienceDialogState();
}

class _AddRegisterWorkExperienceDialogState
    extends State<AddRegisterWorkExperienceDialog> {
  final _companyController = TextEditingController();
  final _jobTitleController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;
  bool _isCurrentJob = false;

  bool get _isEditing => widget.initialEntry != null;

  @override
  void initState() {
    super.initState();
    final entry = widget.initialEntry;
    if (entry != null) {
      _companyController.text = entry.companyName;
      _jobTitleController.text = entry.jobTitle;
      _locationController.text = entry.location;
      _descriptionController.text = entry.description;
      _startDate = entry.startDate;
      _endDate = entry.endDate;
      _isCurrentJob = entry.isCurrentJob;
    }
  }

  @override
  void dispose() {
    _companyController.dispose();
    _jobTitleController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _save() {
    final l10n = AppLocalizations.of(context)!;

    if (_companyController.text.trim().isEmpty) {
      ToastService.error(context, l10n.authCompanyNameRequired);
      return;
    }
    if (_jobTitleController.text.trim().isEmpty) {
      ToastService.error(context, l10n.authJobTitleRequired);
      return;
    }
    if (_locationController.text.trim().isEmpty) {
      ToastService.error(context, l10n.authWorkLocationRequired);
      return;
    }
    if (_startDate == null) {
      ToastService.error(context, l10n.authStartDateRequired);
      return;
    }
    if (!_isCurrentJob && _endDate == null) {
      ToastService.error(context, l10n.authEndDateRequired);
      return;
    }

    final entry = RegisterWorkExperienceEntry(
      id:
          widget.initialEntry?.id ??
          DateTime.now().microsecondsSinceEpoch.toString(),
      companyName: _companyController.text.trim(),
      jobTitle: _jobTitleController.text.trim(),
      location: _locationController.text.trim(),
      startDate: _startDate!,
      endDate: _isCurrentJob ? null : _endDate,
      isCurrentJob: _isCurrentJob,
      description: _descriptionController.text.trim(),
    );
    context.pop(entry);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = context.isDark;
    final fillColor = isDark ? AppColors.inputBgDark : AppColors.authInputFill;
    final currentJobOptions = [l10n.authYes, l10n.authNo];
    final currentJobValue = _isCurrentJob ? l10n.authYes : l10n.authNo;

    return AppDialog(
      title: _isEditing
          ? l10n.authEditWorkExperienceTitle
          : l10n.authAddWorkExperienceTitle,
      width: 520.w,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            labelText: l10n.authCompanyName,
            isRequired: true,
            controller: _companyController,
            hintText: l10n.authCompanyNameHint,
            filled: true,
            fillColor: fillColor,
          ),
          Gap(16.h),
          AppTextField(
            labelText: l10n.authJobTitle,
            isRequired: true,
            controller: _jobTitleController,
            hintText: l10n.authJobTitleHint,
            filled: true,
            fillColor: fillColor,
          ),
          Gap(16.h),
          AppTextField(
            labelText: l10n.authWorkLocation,
            isRequired: true,
            controller: _locationController,
            hintText: l10n.authWorkLocationHint,
            filled: true,
            fillColor: fillColor,
          ),
          Gap(16.h),
          AppDateField(
            label: l10n.authStartDate,
            isRequired: true,
            hintText: l10n.authDateHint,
            initialDate: _startDate,
            firstDate: AuthFormConfig.formDateFirst,
            lastDate: AuthFormConfig.formDateLast,
            fillColor: fillColor,
            onDateSelected: (date) => setState(() => _startDate = date),
          ),
          Gap(16.h),
          AppSelectFieldWithLabel<String>(
            label: l10n.authCurrentJob,
            isRequired: true,
            value: currentJobValue,
            items: currentJobOptions,
            itemLabelBuilder: (item) => item,
            hint: l10n.authSelectCurrentJob,
            fillColor: fillColor,
            onChanged: (value) {
              if (value == null) return;
              setState(() {
                _isCurrentJob = value == l10n.authYes;
                if (_isCurrentJob) _endDate = null;
              });
            },
          ),
          if (!_isCurrentJob) ...[
            Gap(16.h),
            AppDateField(
              label: l10n.authEndDate,
              isRequired: true,
              hintText: l10n.authDateHint,
              initialDate: _endDate,
              firstDate: AuthFormConfig.formDateFirst,
              lastDate: AuthFormConfig.formDateLast,
              fillColor: fillColor,
              onDateSelected: (date) => setState(() => _endDate = date),
            ),
          ],
          Gap(16.h),
          AppTextArea(
            labelText: l10n.authWorkDescription,
            controller: _descriptionController,
            hintText: l10n.authWorkDescriptionHint,
            maxLines: 3,
            fillColor: fillColor,
          ),
        ],
      ),
      actions: [
        AppButton.outline(
          label: l10n.commonCancel,
          onPressed: () => context.pop(),
        ),
        SizedBox(width: 12.w),
        AppButton.primary(
          label: _isEditing ? l10n.commonSaveChanges : l10n.authAddExperience,
          onPressed: _save,
        ),
      ],
    );
  }
}
