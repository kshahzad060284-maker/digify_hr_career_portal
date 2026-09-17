import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/services/responsive/responsive_helper.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_jobs_list_provider.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardHeroSliver extends ConsumerWidget {
  const DashboardHeroSliver({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: context.isMobileLayout ? 300.h : 340.h,
        child: const DashboardHeroBackground(),
      ),
    );
  }
}

class DashboardHeroBackground extends ConsumerWidget {
  const DashboardHeroBackground({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isMobile = context.isMobileLayout;
    final hPad = ResponsiveHelper.pagePadding(context).left;
    final jobsCtrl = ref.read(dashboardJobsControllerProvider.notifier);

    return Stack(
      fit: StackFit.expand,
      children: [
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.gradientStart,
                AppColors.primary,
                AppColors.gradientBlue,
              ],
              stops: [0.0, 0.55, 1.0],
            ),
          ),
        ),
        _Orb(top: -40.h, end: -28.w, size: 180.w, opacity: 0.07),
        _Orb(bottom: -60.h, start: -40.w, size: 200.w, opacity: 0.05),
        Column(
          children: [
            const DashboardHeader(onHero: true),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                  hPad,
                  isMobile ? 8.h : 12.h,
                  hPad,
                  isMobile ? 20.h : 28.h,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: kMaxContentWidth,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: isMobile ? 10.h : 14.h,
                      children: [
                        _HeroBadge(
                          label: l10n.dashboardHeroBadge,
                          isMobile: isMobile,
                        ),
                        Text(
                          l10n.dashboardJoinTeamTitle,
                          textAlign: TextAlign.center,
                          style: context.textTheme.displayLarge?.copyWith(
                            color: AppColors.onPrimary,
                            fontSize: isMobile ? 28.sp : 48.sp,
                            fontWeight: FontWeight.w800,
                            height: 1.15,
                            letterSpacing: -0.5,
                          ),
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: isMobile ? double.infinity : 560.w,
                          ),
                          child: Text(
                            l10n.dashboardJoinTeamSubtitle,
                            textAlign: TextAlign.center,
                            style: context.textTheme.bodyLarge?.copyWith(
                              color: AppColors.onPrimary.withValues(
                                alpha: 0.80,
                              ),
                              fontSize: isMobile ? 13.sp : 16.sp,
                              height: 1.6,
                            ),
                          ),
                        ),
                        _HeroSearchBar(
                          hintText: l10n.dashboardJobSearchPlaceholder,
                          isMobile: isMobile,
                          onChanged: jobsCtrl.onSearchChanged,
                          onSubmitted: jobsCtrl.onSearchSubmitted,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Orb extends StatelessWidget {
  const _Orb({
    this.top,
    this.bottom,
    this.start,
    this.end,
    required this.size,
    required this.opacity,
  });

  final double? top;
  final double? bottom;
  final double? start;
  final double? end;
  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      top: top,
      bottom: bottom,
      start: start,
      end: end,
      child: IgnorePointer(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.onPrimary.withValues(alpha: opacity),
          ),
        ),
      ),
    );
  }
}

class _HeroBadge extends StatelessWidget {
  const _HeroBadge({required this.label, required this.isMobile});

  final String label;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 14.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.onPrimary.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999.r),
        border: Border.all(color: AppColors.onPrimary.withValues(alpha: 0.22)),
      ),
      child: Text(
        label,
        style: context.textTheme.labelLarge?.copyWith(
          color: AppColors.onPrimary,
          fontSize: isMobile ? 11.sp : 12.sp,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

class _HeroSearchBar extends StatefulWidget {
  const _HeroSearchBar({
    required this.hintText,
    required this.isMobile,
    this.onChanged,
    this.onSubmitted,
  });

  final String hintText;
  final bool isMobile;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  @override
  State<_HeroSearchBar> createState() => _HeroSearchBarState();
}

class _HeroSearchBarState extends State<_HeroSearchBar> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() => widget.onSubmitted?.call(_controller.text);

  @override
  Widget build(BuildContext context) {
    const double barHeight = 56;
    const double pillRadius = 32.0;
    final double fontSize = widget.isMobile ? 13.sp : 14.sp;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: widget.isMobile ? double.infinity : 700,
      ),
      child: Container(
        height: barHeight,
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(pillRadius),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadowMedium,
              blurRadius: 24,
              offset: Offset(0, 8),
            ),
            BoxShadow(
              color: AppColors.shadowSubtle,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: widget.isMobile ? 16.w : 20.w,
                end: 8.w,
              ),
              child: Icon(
                Icons.search_rounded,
                size: widget.isMobile ? 20 : 22,
                color: AppColors.textPlaceholder,
              ),
            ),
            Expanded(
              child: TextField(
                controller: _controller,
                onChanged: widget.onChanged,
                onSubmitted: (_) => _submit(),
                textInputAction: TextInputAction.search,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontSize: fontSize,
                  color: AppColors.textPrimary,
                ),
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: context.textTheme.bodyMedium?.copyWith(
                    fontSize: fontSize,
                    color: AppColors.textPlaceholder,
                  ),
                  filled: false,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 6),
              child: SizedBox(
                height: barHeight - 12,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.onPrimary,
                    elevation: 0,
                    shadowColor: AppColors.transparent,
                    padding: EdgeInsetsDirectional.symmetric(
                      horizontal: widget.isMobile ? 14.w : 20.w,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(pillRadius - 6),
                    ),
                    textStyle: context.textTheme.bodyMedium?.copyWith(
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: widget.isMobile
                      ? const Icon(Icons.search_rounded, size: 18)
                      : const Text('Search'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
