import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/shared/widgets/assets/app_asset.dart';
import 'package:career_portal/shared/widgets/common/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AppFormListItem {
  const AppFormListItem({
    required this.id,
    required this.title,
    required this.subtitle,
  });

  final String id;
  final String title;
  final String subtitle;
}

class AppFormOptionalSection extends StatelessWidget {
  const AppFormOptionalSection({
    super.key,
    required this.title,
    required this.icon,
    required this.buttonLabel,
    required this.emptyStateMessage,
    required this.onAddPressed,
    this.buttonIcon,
    this.buttonSvgPath,
    this.items = const [],
    this.onEditItem,
    this.onRemoveItem,
  });

  final String title;
  final AppAsset icon;
  final String buttonLabel;
  final IconData? buttonIcon;
  final String? buttonSvgPath;
  final String emptyStateMessage;
  final VoidCallback onAddPressed;
  final List<AppFormListItem> items;
  final ValueChanged<String>? onEditItem;
  final ValueChanged<String>? onRemoveItem;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final titleStyle = context.textTheme.titleLarge?.copyWith(
      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            icon,
            Gap(8.w),
            Expanded(
              child: Text(
                title,
                style: titleStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Gap(8.w),
            AppButton.outline(
              label: buttonLabel,
              icon: buttonSvgPath == null ? (buttonIcon ?? Icons.add) : null,
              svgPath: buttonSvgPath,
              onPressed: onAddPressed,
              height: 36.h,
            ),
          ],
        ),
        Gap(12.h),
        if (items.isEmpty)
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: isDark ? AppColors.inputBgDark : AppColors.sidebarSearchBg,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Center(
              child: Text(
                emptyStateMessage,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        else
          Column(
            children: [
              for (var i = 0; i < items.length; i++) ...[
                if (i > 0) Gap(8.h),
                _AppFormListItemTile(
                  item: items[i],
                  isDark: isDark,
                  onEdit: onEditItem != null
                      ? () => onEditItem!(items[i].id)
                      : null,
                  onRemove: onRemoveItem != null
                      ? () => onRemoveItem!(items[i].id)
                      : null,
                ),
              ],
            ],
          ),
      ],
    );
  }
}

class _AppFormListItemTile extends StatelessWidget {
  const _AppFormListItemTile({
    required this.item,
    required this.isDark,
    this.onEdit,
    this.onRemove,
  });

  final AppFormListItem item;
  final bool isDark;
  final VoidCallback? onEdit;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: isDark ? AppColors.inputBgDark : AppColors.sidebarSearchBg,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: isDark ? AppColors.cardBorderDark : AppColors.cardBorder,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: context.textTheme.titleSmall?.copyWith(
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap(4.h),
                Text(
                  item.subtitle,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (onEdit != null) ...[
            IconButton(
              onPressed: onEdit,
              icon: Icon(
                Icons.edit_outlined,
                size: 20.sp,
                color: AppColors.primary,
              ),
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(minWidth: 32.w, minHeight: 32.w),
            ),
          ],
          if (onRemove != null)
            IconButton(
              onPressed: onRemove,
              icon: Icon(
                Icons.delete_outline,
                size: 20.sp,
                color: AppColors.deleteIconRed,
              ),
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(minWidth: 32.w, minHeight: 32.w),
            ),
        ],
      ),
    );
  }
}
