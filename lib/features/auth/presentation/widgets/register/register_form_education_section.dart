import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/auth/domain/config/auth_form_config.dart';
import 'package:career_portal/features/auth/presentation/providers/register_provider.dart';
import 'package:career_portal/features/auth/presentation/widgets/register/add_register_education_dialog.dart';
import 'package:career_portal/gen/assets.gen.dart';
import 'package:career_portal/shared/widgets/assets/app_asset.dart';
import 'package:career_portal/shared/widgets/common/app_button.dart';
import 'package:career_portal/shared/widgets/common/app_confirmation_dialog.dart';
import 'package:career_portal/shared/widgets/common/app_form_optional_section.dart';
import 'package:career_portal/shared/widgets/common/app_select_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class RegisterFormEducationSection extends ConsumerStatefulWidget {
  const RegisterFormEducationSection({super.key});

  @override
  ConsumerState<RegisterFormEducationSection> createState() =>
      _RegisterFormEducationSectionState();
}

class _RegisterFormEducationSectionState
    extends ConsumerState<RegisterFormEducationSection> {
  String? _selectedLevel;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(registerControllerProvider);
    final isDark = context.isDark;
    final educationIcon = AppAsset(
      assetPath: Assets.icons.auth.education.path,
      width: 20.w,
      height: 20.w,
      color: AppColors.primary,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.authEducationHighestLevelHint,
          style: context.textTheme.bodyMedium?.copyWith(
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondary,
          ),
        ),
        Gap(12.h),
        Row(
          children: [
            Expanded(
              child: AppSelectField<String>(
                value: _selectedLevel,
                items: AuthFormConfig.educationLevelOptions,
                itemLabelBuilder: (item) => item,
                hint: l10n.authSelectEducationLevel,
                fillColor: isDark
                    ? AppColors.inputBgDark
                    : AppColors.cardBackground,
                onChanged: (value) => setState(() => _selectedLevel = value),
              ),
            ),
            if (_selectedLevel != null) ...[
              Gap(12.w),
              AppButton.outline(
                label: l10n.authAddEducation,
                icon: Icons.add,
                onPressed: () =>
                    _openEducationDialog(initialDegreeName: _selectedLevel),
              ),
            ],
          ],
        ),
        Gap(16.h),
        AppFormOptionalSection(
          title: l10n.authEducation,
          icon: educationIcon,
          buttonLabel: l10n.authAddEducation,
          emptyStateMessage: l10n.authEducationEmpty,
          onAddPressed: () =>
              _openEducationDialog(initialDegreeName: _selectedLevel),
          showHeader: false,
          items: state.educationEntries
              .map(
                (e) => AppFormListItem(
                  id: e.id,
                  title: e.displayTitle,
                  subtitle: e.displaySubtitle,
                ),
              )
              .toList(),
          onEditItem: (id) => _openEducationDialog(editId: id),
          onRemoveItem: _confirmRemoveEducation,
        ),
      ],
    );
  }

  Future<void> _confirmRemoveEducation(String id) async {
    final l10n = AppLocalizations.of(context)!;
    final entries = ref.read(registerControllerProvider).educationEntries;
    final entry = entries.where((e) => e.id == id).firstOrNull;
    if (entry == null) return;

    final confirmed = await AppConfirmationDialog.show(
      context,
      title: l10n.authRemoveEducationTitle,
      message: l10n.authRemoveEducationMessage,
      itemName: entry.displayTitle,
      confirmLabel: l10n.commonDelete,
      cancelLabel: l10n.commonCancel,
      type: ConfirmationType.danger,
    );
    if (confirmed == true && mounted) {
      ref.read(registerControllerProvider.notifier).removeEducation(id);
    }
  }

  Future<void> _openEducationDialog({
    String? editId,
    String? initialDegreeName,
  }) async {
    final notifier = ref.read(registerControllerProvider.notifier);
    final state = ref.read(registerControllerProvider);
    final initial = editId == null
        ? null
        : state.educationEntries.where((e) => e.id == editId).firstOrNull;

    final result = await AddRegisterEducationDialog.show(
      context,
      initialEntry: initial,
      initialDegreeName: editId == null ? initialDegreeName : null,
    );
    if (result == null || !mounted) return;

    if (editId != null) {
      notifier.updateEducation(result);
    } else {
      notifier.addEducation(result);
    }
  }
}
