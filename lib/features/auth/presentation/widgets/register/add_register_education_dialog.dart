import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/services/toast/toast_service.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/auth/domain/config/auth_form_config.dart';
import 'package:career_portal/features/auth/domain/models/register_education_entry.dart';
import 'package:career_portal/shared/widgets/common/app_button.dart';
import 'package:career_portal/shared/widgets/common/app_dialog.dart';
import 'package:career_portal/shared/widgets/common/app_select_field.dart';
import 'package:career_portal/shared/widgets/common/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AddRegisterEducationDialog extends StatefulWidget {
  const AddRegisterEducationDialog({super.key, this.initialEntry});

  final RegisterEducationEntry? initialEntry;

  static Future<RegisterEducationEntry?> show(
    BuildContext context, {
    RegisterEducationEntry? initialEntry,
  }) {
    return showDialog<RegisterEducationEntry>(
      context: context,
      builder: (context) =>
          AddRegisterEducationDialog(initialEntry: initialEntry),
    );
  }

  @override
  State<AddRegisterEducationDialog> createState() =>
      _AddRegisterEducationDialogState();
}

class _AddRegisterEducationDialogState
    extends State<AddRegisterEducationDialog> {
  final _degreeController = TextEditingController();
  final _institutionController = TextEditingController();
  final _fieldOfStudyController = TextEditingController();
  final _descriptionController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;
  String? _grade;

  bool get _isEditing => widget.initialEntry != null;

  @override
  void initState() {
    super.initState();
    final entry = widget.initialEntry;
    if (entry != null) {
      _degreeController.text = entry.degreeName;
      _institutionController.text = entry.institutionName;
      _fieldOfStudyController.text = entry.fieldOfStudy;
      _descriptionController.text = entry.description;
      _startDate = entry.startDate;
      _endDate = entry.endDate;
      _grade = entry.grade;
    }
  }

  @override
  void dispose() {
    _degreeController.dispose();
    _institutionController.dispose();
    _fieldOfStudyController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _save() {
    final l10n = AppLocalizations.of(context)!;

    if (_degreeController.text.trim().isEmpty) {
      ToastService.error(context, l10n.authDegreeNameRequired);
      return;
    }
    if (_institutionController.text.trim().isEmpty) {
      ToastService.error(context, l10n.authInstitutionNameRequired);
      return;
    }
    if (_fieldOfStudyController.text.trim().isEmpty) {
      ToastService.error(context, l10n.authFieldOfStudyRequired);
      return;
    }
    if (_startDate == null) {
      ToastService.error(context, l10n.authStartDateRequired);
      return;
    }
    if (_endDate == null) {
      ToastService.error(context, l10n.authEndDateRequired);
      return;
    }
    if (_grade == null || _grade!.isEmpty) {
      ToastService.error(context, l10n.authGradeRequired);
      return;
    }

    final entry = RegisterEducationEntry(
      id:
          widget.initialEntry?.id ??
          DateTime.now().microsecondsSinceEpoch.toString(),
      degreeName: _degreeController.text.trim(),
      institutionName: _institutionController.text.trim(),
      fieldOfStudy: _fieldOfStudyController.text.trim(),
      startDate: _startDate!,
      endDate: _endDate!,
      grade: _grade!,
      description: _descriptionController.text.trim(),
    );
    context.pop(entry);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = context.isDark;
    final fillColor = isDark ? AppColors.inputBgDark : AppColors.authInputFill;

    return AppDialog(
      title: _isEditing
          ? l10n.authEditEducationTitle
          : l10n.authAddEducationTitle,
      width: 520.w,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            labelText: l10n.authDegreeName,
            isRequired: true,
            controller: _degreeController,
            hintText: l10n.authDegreeNameHint,
            filled: true,
            fillColor: fillColor,
          ),
          Gap(16.h),
          AppTextField(
            labelText: l10n.authInstitutionName,
            isRequired: true,
            controller: _institutionController,
            hintText: l10n.authInstitutionNameHint,
            filled: true,
            fillColor: fillColor,
          ),
          Gap(16.h),
          AppTextField(
            labelText: l10n.authFieldOfStudy,
            isRequired: true,
            controller: _fieldOfStudyController,
            hintText: l10n.authFieldOfStudyHint,
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
          Gap(16.h),
          AppSelectFieldWithLabel<String>(
            label: l10n.authGrade,
            isRequired: true,
            value: _grade,
            items: AuthFormConfig.educationGradeOptions,
            itemLabelBuilder: (item) => item,
            hint: l10n.authSelectGrade,
            fillColor: fillColor,
            onChanged: (value) => setState(() => _grade = value),
          ),
          Gap(16.h),
          AppTextArea(
            labelText: l10n.authEducationDescription,
            controller: _descriptionController,
            hintText: l10n.authEducationDescriptionHint,
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
          label: _isEditing ? l10n.commonSaveChanges : l10n.authAddEducation,
          onPressed: _save,
        ),
      ],
    );
  }
}
