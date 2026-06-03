import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/auth/presentation/providers/register_provider.dart';
import 'package:career_portal/features/auth/presentation/widgets/register/add_register_education_dialog.dart';
import 'package:career_portal/gen/assets.gen.dart';
import 'package:career_portal/shared/widgets/assets/app_asset.dart';
import 'package:career_portal/shared/widgets/common/app_confirmation_dialog.dart';
import 'package:career_portal/shared/widgets/common/app_form_optional_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterFormEducationSection extends ConsumerWidget {
  const RegisterFormEducationSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(registerControllerProvider);

    return AppFormOptionalSection(
      title: l10n.authEducationOptional,
      icon: AppAsset(
        assetPath: Assets.icons.auth.education.path,
        width: 20.w,
        height: 20.w,
        color: AppColors.primary,
      ),
      buttonLabel: l10n.authAddEducation,
      emptyStateMessage: l10n.authEducationEmpty,
      onAddPressed: () => _openEducationDialog(context, ref),
      items: state.educationEntries
          .map(
            (e) => AppFormListItem(
              id: e.id,
              title: e.displayTitle,
              subtitle: e.displaySubtitle,
            ),
          )
          .toList(),
      onEditItem: (id) => _openEducationDialog(context, ref, editId: id),
      onRemoveItem: (id) => _confirmRemoveEducation(context, ref, id),
    );
  }

  Future<void> _confirmRemoveEducation(
    BuildContext context,
    WidgetRef ref,
    String id,
  ) async {
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
    if (confirmed == true && context.mounted) {
      ref.read(registerControllerProvider.notifier).removeEducation(id);
    }
  }

  Future<void> _openEducationDialog(
    BuildContext context,
    WidgetRef ref, {
    String? editId,
  }) async {
    final notifier = ref.read(registerControllerProvider.notifier);
    final state = ref.read(registerControllerProvider);
    final initial = editId == null
        ? null
        : state.educationEntries.where((e) => e.id == editId).firstOrNull;

    final result = await AddRegisterEducationDialog.show(
      context,
      initialEntry: initial,
    );
    if (result == null || !context.mounted) return;

    if (editId != null) {
      notifier.updateEducation(result);
    } else {
      notifier.addEducation(result);
    }
  }
}
