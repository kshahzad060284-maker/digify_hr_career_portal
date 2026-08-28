import 'package:career_portal/core/common/auth_enums.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/auth/presentation/providers/register_provider.dart';
import 'package:career_portal/features/auth/presentation/widgets/register/add_register_work_experience_dialog.dart';
import 'package:career_portal/features/auth/presentation/widgets/register/register_form_skills_section.dart';
import 'package:career_portal/gen/assets.gen.dart';
import 'package:career_portal/shared/widgets/assets/app_asset.dart';
import 'package:career_portal/shared/widgets/common/app_button.dart';
import 'package:career_portal/shared/widgets/common/app_confirmation_dialog.dart';
import 'package:career_portal/shared/widgets/common/app_form_optional_section.dart';
import 'package:career_portal/shared/widgets/common/app_radio_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class RegisterFormWorkExperienceSection extends ConsumerWidget {
  const RegisterFormWorkExperienceSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(registerControllerProvider);
    final controller = ref.read(registerControllerProvider.notifier);
    final isExperienced =
        state.experienceType == RegisterExperienceType.experienced;
    final workIcon = AppAsset(
      assetPath: Assets.icons.dashboard.department.path,
      width: 20.w,
      height: 20.w,
      color: AppColors.primary,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          spacing: 16.w,
          children: [
            AppRadioOption(
              label: l10n.authFresh,
              selected: state.experienceType == RegisterExperienceType.fresh,
              onTap: () => controller.onExperienceTypeChanged(
                RegisterExperienceType.fresh,
              ),
            ),
            AppRadioOption(
              label: l10n.authExperienced,
              selected: isExperienced,
              onTap: () => controller.onExperienceTypeChanged(
                RegisterExperienceType.experienced,
              ),
            ),
          ],
        ),
        if (isExperienced) ...[
          Gap(16.h),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: AppButton.outline(
              label: l10n.authAddExperience,
              onPressed: () => _openWorkExperienceDialog(context, ref),
            ),
          ),
          Gap(12.h),
          AppFormOptionalSection(
            title: l10n.authWorkExperience,
            icon: workIcon,
            buttonLabel: l10n.authAddExperience,
            emptyStateMessage: l10n.authWorkExperienceEmpty,
            onAddPressed: () => _openWorkExperienceDialog(context, ref),
            showHeader: false,
            items: state.workExperienceEntries
                .map(
                  (e) => AppFormListItem(
                    id: e.id,
                    title: e.displayTitle,
                    subtitle: e.displaySubtitle(l10n),
                  ),
                )
                .toList(),
            onEditItem: (id) =>
                _openWorkExperienceDialog(context, ref, editId: id),
            onRemoveItem: (id) =>
                _confirmRemoveWorkExperience(context, ref, id),
          ),
        ],
        Gap(16.h),
        const RegisterFormSkillsSection(),
      ],
    );
  }

  Future<void> _confirmRemoveWorkExperience(
    BuildContext context,
    WidgetRef ref,
    String id,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final entries = ref.read(registerControllerProvider).workExperienceEntries;
    final entry = entries.where((e) => e.id == id).firstOrNull;
    if (entry == null) return;

    final confirmed = await AppConfirmationDialog.show(
      context,
      title: l10n.authRemoveWorkExperienceTitle,
      message: l10n.authRemoveWorkExperienceMessage,
      itemName: entry.displayTitle,
      confirmLabel: l10n.commonDelete,
      cancelLabel: l10n.commonCancel,
      type: ConfirmationType.danger,
    );
    if (confirmed == true && context.mounted) {
      ref.read(registerControllerProvider.notifier).removeWorkExperience(id);
    }
  }

  Future<void> _openWorkExperienceDialog(
    BuildContext context,
    WidgetRef ref, {
    String? editId,
  }) async {
    final notifier = ref.read(registerControllerProvider.notifier);
    final state = ref.read(registerControllerProvider);
    final initial = editId == null
        ? null
        : state.workExperienceEntries.where((e) => e.id == editId).firstOrNull;

    final result = await AddRegisterWorkExperienceDialog.show(
      context,
      initialEntry: initial,
    );
    if (result == null || !context.mounted) return;

    if (editId != null) {
      notifier.updateWorkExperience(result);
    } else {
      notifier.addWorkExperience(result);
    }
  }
}
