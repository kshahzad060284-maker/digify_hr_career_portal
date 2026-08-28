import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/auth/presentation/providers/register_provider.dart';
import 'package:career_portal/shared/widgets/common/app_button.dart';
import 'package:career_portal/shared/widgets/common/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class RegisterFormSkillsSection extends ConsumerStatefulWidget {
  const RegisterFormSkillsSection({super.key});

  @override
  ConsumerState<RegisterFormSkillsSection> createState() =>
      _RegisterFormSkillsSectionState();
}

class _RegisterFormSkillsSectionState
    extends ConsumerState<RegisterFormSkillsSection> {
  final _skillController = TextEditingController();

  @override
  void dispose() {
    _skillController.dispose();
    super.dispose();
  }

  void _addSkill() {
    final controller = ref.read(registerControllerProvider.notifier);
    controller.addSkill(_skillController.text);
    _skillController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = context.isDark;
    final skills = ref.watch(
      registerControllerProvider.select((state) => state.skills),
    );
    final controller = ref.read(registerControllerProvider.notifier);
    final fillColor = isDark ? AppColors.inputBgDark : AppColors.cardBackground;
    final borderColor = isDark
        ? AppColors.inputBorderDark
        : AppColors.authInputBorder;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text.rich(
          TextSpan(
            text: l10n.authSkills,
            style: context.textTheme.titleSmall?.copyWith(
              color: AppColors.inputLabel,
            ),
            children: const [
              TextSpan(
                text: ' *',
                style: TextStyle(color: AppColors.deleteIconRed),
              ),
            ],
          ),
        ),
        Gap(8.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AppTextField(
                controller: _skillController,
                hintText: l10n.authSkillsHint,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _addSkill(),
                filled: true,
                fillColor: fillColor,
              ),
            ),
            Gap(12.w),
            AppButton(label: l10n.authAddSkill, onPressed: _addSkill),
          ],
        ),
        if (skills.isNotEmpty) ...[
          Gap(12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              for (final skill in skills)
                InputChip(
                  label: Text(skill.skillName),
                  deleteIconColor: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondary,
                  onDeleted: () => controller.removeSkill(skill.skillName),
                  backgroundColor: isDark
                      ? AppColors.inputBgDark
                      : AppColors.cardBackground,
                  side: BorderSide(color: borderColor),
                  labelStyle: context.textTheme.bodyMedium?.copyWith(
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimary,
                  ),
                ),
            ],
          ),
        ],
      ],
    );
  }
}
