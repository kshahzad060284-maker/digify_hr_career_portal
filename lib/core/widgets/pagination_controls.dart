import 'package:career_portal/core/domain/models/pagination_info.dart';
import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PaginationControls extends StatelessWidget {
  const PaginationControls({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.pageSize,
    required this.hasNext,
    required this.hasPrevious,
    this.onPrevious,
    this.onNext,
    this.onPageTap,
    this.isLoading = false,
    this.showPageNumbers = false,
    this.padding,
    this.showBorder = true,
    this.style = PaginationStyle.simple,
  });

  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int pageSize;
  final bool hasNext;
  final bool hasPrevious;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;
  final ValueChanged<int>? onPageTap;
  final bool isLoading;
  final bool showPageNumbers;
  final EdgeInsets? padding;
  final bool showBorder;
  final PaginationStyle style;

  factory PaginationControls.fromPaginationInfo({
    required PaginationInfo paginationInfo,
    required int currentPage,
    required int pageSize,
    VoidCallback? onPrevious,
    VoidCallback? onNext,
    ValueChanged<int>? onPageTap,
    bool isLoading = false,
    EdgeInsets? padding,
    bool showBorder = true,
    PaginationStyle style = PaginationStyle.simple,
    Key? key,
  }) {
    return PaginationControls(
      key: key,
      currentPage: currentPage,
      totalPages: paginationInfo.totalPages,
      totalItems: paginationInfo.totalItems,
      pageSize: pageSize,
      hasNext: paginationInfo.hasNext,
      hasPrevious: paginationInfo.hasPrevious,
      onPrevious: onPrevious,
      onNext: onNext,
      onPageTap: onPageTap,
      isLoading: isLoading,
      padding: padding,
      showBorder: showBorder,
      style: style,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = context.isDark;
    final hasAnyItems = totalItems > 0;
    final startItem = hasAnyItems ? ((currentPage - 1) * pageSize) + 1 : 0;
    final endItem = hasAnyItems
        ? (currentPage * pageSize > totalItems
              ? totalItems
              : currentPage * pageSize)
        : 0;

    final controls = style == PaginationStyle.simple
        ? _buildSimpleControls(context, isDark, l10n)
        : _buildFullControls(context, isDark);

    final infoText = Text(
      l10n.paginationShowingRange(startItem, endItem, totalItems),
      style: context.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w500,
        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
      ),
    );

    return Container(
      padding: padding ?? EdgeInsetsDirectional.all(16.w),
      decoration: showBorder
          ? BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: isDark
                      ? AppColors.cardBorderDark
                      : AppColors.cardBorder,
                  width: 1,
                ),
              ),
            )
          : null,
      child: context.isMobileLayout
          ? MobilePaginationControls(
              isDark: isDark,
              currentPage: currentPage,
              totalPages: totalPages,
              hasPrevious: hasPrevious,
              hasNext: hasNext,
              onPrevious: onPrevious,
              onNext: onNext,
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [infoText, controls],
            ),
    );
  }

  Widget _buildSimpleControls(
    BuildContext context,
    bool isDark,
    AppLocalizations l10n,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _SleekTextNavButton(
          isDark: isDark,
          text: 'Previous',
          icon: Icons.arrow_back,
          enabled: hasPrevious && !isLoading,
          onTap: onPrevious,
        ),
        Gap(24.w),
        Text(
          l10n.paginationPageOf(currentPage, totalPages),
          style: context.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
          ),
        ),
        Gap(24.w),
        _SleekTextNavButton(
          isDark: isDark,
          text: 'Next',
          icon: Icons.arrow_forward,
          isNext: true,
          enabled: hasNext && !isLoading,
          onTap: onNext,
        ),
      ],
    );
  }

  Widget _buildFullControls(BuildContext context, bool isDark) {
    final pageNumbers = _generatePageNumbers();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (totalPages > 7 && currentPage > 4)
          _buildPageButton(
            context: context,
            isDark: isDark,
            page: 1,
            onTap: () => onPageTap?.call(1),
          ),
        if (totalPages > 7 && currentPage > 4) Gap(4.w),
        if (_shouldShowFirstEllipsis())
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Text(
              '...',
              style: context.textTheme.bodyMedium?.copyWith(
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondary,
              ),
            ),
          ),
        if (_shouldShowFirstEllipsis()) Gap(4.w),
        _buildNavButton(
          context: context,
          isDark: isDark,
          icon: Icons.chevron_left,
          enabled: hasPrevious && !isLoading,
          onTap: onPrevious,
        ),
        Gap(4.w),
        ...pageNumbers.map((page) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: _buildPageButton(
              context: context,
              isDark: isDark,
              page: page,
              isActive: page == currentPage,
              onTap: () => onPageTap?.call(page),
            ),
          );
        }),
        Gap(4.w),
        _buildNavButton(
          context: context,
          isDark: isDark,
          icon: Icons.chevron_right,
          enabled: hasNext && !isLoading,
          onTap: onNext,
        ),
        if (_shouldShowLastEllipsis()) Gap(4.w),
        if (_shouldShowLastEllipsis())
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Text(
              '...',
              style: context.textTheme.bodyMedium?.copyWith(
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondary,
              ),
            ),
          ),
        if (_shouldShowLastEllipsis()) Gap(4.w),
        if (totalPages > 7 && currentPage < totalPages - 3) Gap(4.w),
        if (totalPages > 7 && currentPage < totalPages - 3)
          _buildPageButton(
            context: context,
            isDark: isDark,
            page: totalPages,
            onTap: () => onPageTap?.call(totalPages),
          ),
      ],
    );
  }

  Widget _buildNavButton({
    required BuildContext context,
    required bool isDark,
    required IconData icon,
    required bool enabled,
    required VoidCallback? onTap,
  }) {
    if (isLoading) {
      return SizedBox(
        width: 48.w,
        height: 48.w,
        child: Center(
          child: SizedBox(
            width: 20.w,
            height: 20.w,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
              ),
            ),
          ),
        ),
      );
    }

    return _HoverNavButton(
      isDark: isDark,
      icon: icon,
      enabled: enabled,
      onTap: onTap,
    );
  }

  Widget _buildPageButton({
    required BuildContext context,
    required bool isDark,
    required int page,
    bool isActive = false,
    required VoidCallback? onTap,
  }) {
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6.r),
        child: Container(
          width: 36.w,
          height: 36.h,
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.primary
                : (isDark
                      ? AppColors.cardBackgroundGreyDark
                      : AppColors.grayBg),
            borderRadius: BorderRadius.circular(6.r),
            border: isActive
                ? null
                : Border.all(
                    color: isDark
                        ? AppColors.cardBorderDark
                        : AppColors.cardBorder,
                    width: 1,
                  ),
          ),
          alignment: Alignment.center,
          child: Text(
            '$page',
            style: context.textTheme.bodySmall?.copyWith(
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              color: isActive
                  ? AppColors.onPrimary
                  : (isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimary),
            ),
          ),
        ),
      ),
    );
  }

  List<int> _generatePageNumbers() {
    if (totalPages <= 7) {
      return List.generate(totalPages, (index) => index + 1);
    } else {
      if (currentPage <= 3) {
        return [1, 2, 3, 4, 5];
      } else if (currentPage >= totalPages - 2) {
        return [
          totalPages - 4,
          totalPages - 3,
          totalPages - 2,
          totalPages - 1,
          totalPages,
        ];
      } else {
        return [
          currentPage - 2,
          currentPage - 1,
          currentPage,
          currentPage + 1,
          currentPage + 2,
        ];
      }
    }
  }

  bool _shouldShowFirstEllipsis() {
    return totalPages > 7 && currentPage > 4;
  }

  bool _shouldShowLastEllipsis() {
    return totalPages > 7 && currentPage < totalPages - 3;
  }
}

enum PaginationStyle { simple, full }

class MobilePaginationControls extends StatelessWidget {
  const MobilePaginationControls({
    super.key,
    required this.isDark,
    required this.currentPage,
    required this.totalPages,
    required this.hasPrevious,
    required this.hasNext,
    this.onPrevious,
    this.onNext,
  });

  final bool isDark;
  final int currentPage;
  final int totalPages;
  final bool hasPrevious;
  final bool hasNext;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _MobileNavButton(
          isDark: isDark,
          icon: Icons.chevron_left,
          enabled: hasPrevious,
          onTap: onPrevious,
        ),
        Gap(16.w),
        Text(
          l10n.paginationPageOf(currentPage, totalPages),
          style: context.textTheme.labelMedium?.copyWith(
            fontSize: 13.sp,
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
          ),
        ),
        Gap(16.w),
        _MobileNavButton(
          isDark: isDark,
          icon: Icons.chevron_right,
          enabled: hasNext,
          onTap: onNext,
        ),
      ],
    );
  }
}

class _MobileNavButton extends StatelessWidget {
  const _MobileNavButton({
    required this.isDark,
    required this.icon,
    required this.enabled,
    this.onTap,
  });

  final bool isDark;
  final IconData icon;
  final bool enabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.w,
      width: 40.w,
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10.r),
          onTap: enabled ? onTap : null,
          child: Center(
            child: Icon(
              icon,
              size: 20.sp,
              color: enabled
                  ? (isDark ? AppColors.textPrimaryDark : AppColors.textPrimary)
                  : (isDark
                        ? AppColors.textPlaceholderDark
                        : AppColors.textPlaceholder),
            ),
          ),
        ),
      ),
    );
  }
}

class _HoverNavButton extends StatefulWidget {
  const _HoverNavButton({
    required this.isDark,
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  final bool isDark;
  final IconData icon;
  final bool enabled;
  final VoidCallback? onTap;

  @override
  State<_HoverNavButton> createState() => _HoverNavButtonState();
}

class _HoverNavButtonState extends State<_HoverNavButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.enabled
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) {
        if (widget.enabled) setState(() => _isHovered = true);
      },
      onExit: (_) {
        if (widget.enabled) setState(() => _isHovered = false);
      },
      child: GestureDetector(
        onTap: widget.enabled ? widget.onTap : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          width: 48.w,
          height: 48.w,
          transform: Matrix4.translationValues(0, _isHovered ? -2.0 : 0, 0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _isHovered
                ? AppColors.primary
                : (widget.isDark
                      ? AppColors.cardBackgroundGreyDark
                      : AppColors.onPrimary),
            border: Border.all(
              color: _isHovered
                  ? AppColors.primary
                  : (widget.isDark
                        ? AppColors.cardBorderDark
                        : AppColors.borderLight),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? AppColors.shadowColor
                    : AppColors.shadowXSubtle,
                blurRadius: _isHovered ? 8 : 4,
                offset: Offset(0, _isHovered ? 4 : 2),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              widget.icon,
              size: 24.sp,
              color: _isHovered
                  ? AppColors.onPrimary
                  : (widget.enabled
                        ? AppColors.textSecondary
                        : (widget.isDark
                              ? AppColors.textPlaceholderDark
                              : AppColors.textPlaceholder)),
            ),
          ),
        ),
      ),
    );
  }
}

class _SleekTextNavButton extends StatefulWidget {
  const _SleekTextNavButton({
    required this.isDark,
    required this.text,
    required this.icon,
    required this.enabled,
    required this.onTap,
    this.isNext = false,
  });

  final bool isDark;
  final String text;
  final IconData icon;
  final bool enabled;
  final VoidCallback? onTap;
  final bool isNext;

  @override
  State<_SleekTextNavButton> createState() => _SleekTextNavButtonState();
}

class _SleekTextNavButtonState extends State<_SleekTextNavButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.enabled
        ? (widget.isDark ? AppColors.textPrimaryDark : AppColors.textPrimary)
        : (widget.isDark
              ? AppColors.textPlaceholderDark
              : AppColors.textPlaceholder);

    final hoverBg = widget.isDark
        ? AppColors.cardBackgroundGreyDark.withValues(alpha: 0.5)
        : AppColors.grayBg;

    return MouseRegion(
      cursor: widget.enabled
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) {
        if (widget.enabled) setState(() => _isHovered = true);
      },
      onExit: (_) {
        if (widget.enabled) setState(() => _isHovered = false);
      },
      child: GestureDetector(
        onTap: widget.enabled ? widget.onTap : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: _isHovered ? hoverBg : AppColors.transparent,
            borderRadius: BorderRadius.circular(100.r),
            border: Border.all(
              color: widget.enabled
                  ? (widget.isDark
                        ? AppColors.cardBorderDark
                        : AppColors.borderLight)
                  : AppColors.transparent,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!widget.isNext) ...[
                Icon(widget.icon, size: 16.sp, color: color),
                Gap(8.w),
              ],
              Text(
                widget.text,
                style: context.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
              if (widget.isNext) ...[
                Gap(8.w),
                Icon(widget.icon, size: 16.sp, color: color),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
