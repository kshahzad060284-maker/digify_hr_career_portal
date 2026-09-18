import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/services/responsive/responsive_helper.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/dashboard/domain/models/dashboard_job.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_job_detail_view_provider.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_job_detail_body.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_job_detail_header_delegate.dart';
import 'package:career_portal/features/dashboard/presentation/widgets/dashboard_job_detail_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardJobDetailDesktopLayout extends ConsumerStatefulWidget {
  const DashboardJobDetailDesktopLayout({
    super.key,
    required this.job,
    required this.fallbackTitle,
    required this.applyButtonLabel,
    required this.onBack,
    required this.onApplyPressed,
    required this.hasApplied,
    required this.sidebarWidth,
  });

  final DashboardJob job;
  final String fallbackTitle;
  final String applyButtonLabel;
  final VoidCallback onBack;
  final VoidCallback? onApplyPressed;
  final bool hasApplied;
  final double sidebarWidth;

  @override
  ConsumerState<DashboardJobDetailDesktopLayout> createState() =>
      _DashboardJobDetailDesktopLayoutState();
}

class _DashboardJobDetailDesktopLayoutState
    extends ConsumerState<DashboardJobDetailDesktopLayout> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_handleScroll)
      ..dispose();
    super.dispose();
  }

  void _handleScroll() {
    ref
        .read(dashboardJobDetailViewProvider.notifier)
        .updateScrollOffset(_scrollController.offset);
  }

  void _scrollToTop() {
    // Scale the trip with the distance: a fixed duration blurs past a long
    // page and crawls on a short one.
    final distance = _scrollController.offset;
    final milliseconds = (240 + distance * 0.32).clamp(280, 900).toInt();

    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: milliseconds),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = ResponsiveHelper.pagePadding(context).left;
    final viewState = ref.watch(dashboardJobDetailViewProvider);

    return Stack(
      children: [
        CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: DashboardJobDetailHeaderDelegate(
                job: widget.job,
                fallbackTitle: widget.fallbackTitle,
                onBack: widget.onBack,
                applyButtonLabel: widget.applyButtonLabel,
                onApplyPressed: widget.onApplyPressed,
                hasApplied: widget.hasApplied,
              ),
            ),
            SliverPadding(
              padding: EdgeInsetsDirectional.fromSTEB(
                horizontalPadding,
                20.h,
                horizontalPadding,
                32.h,
              ),
              sliver: SliverToBoxAdapter(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: DashboardJobDetailBody(
                        job: widget.job,
                        hasApplied: widget.hasApplied,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    SizedBox(
                      width: widget.sidebarWidth.w,
                      child: DashboardJobDetailSidebar(
                        job: widget.job,
                        postingGuid: widget.job.id,
                        applyButtonLabel: widget.applyButtonLabel,
                        onApplyPressed: widget.onApplyPressed,
                        hasApplied: widget.hasApplied,
                        showApplyAction: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        PositionedDirectional(
          bottom: 28.h,
          end: horizontalPadding,
          child: DashboardJobDetailBackToTopButton(
            visible: viewState.showBackToTop,
            onPressed: _scrollToTop,
          ),
        ),
      ],
    );
  }
}

class DashboardJobDetailBackToTopButton extends StatefulWidget {
  const DashboardJobDetailBackToTopButton({
    super.key,
    required this.visible,
    required this.onPressed,
  });

  final bool visible;
  final VoidCallback onPressed;

  @override
  State<DashboardJobDetailBackToTopButton> createState() =>
      _DashboardJobDetailBackToTopButtonState();
}

class _DashboardJobDetailBackToTopButtonState
    extends State<DashboardJobDetailBackToTopButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !widget.visible,
      child: AnimatedSlide(
        duration: const Duration(milliseconds: 240),
        curve: Curves.easeOutCubic,
        offset: widget.visible ? Offset.zero : Offset(0, 0.4.h),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 240),
          opacity: widget.visible ? 1 : 0,
          child: MouseRegion(
            onEnter: (_) => setState(() => _hovered = true),
            onExit: (_) => setState(() => _hovered = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              decoration: BoxDecoration(
                color: context.themeCardBackground,
                shape: BoxShape.circle,
                border: Border.all(
                  color: _hovered ? AppColors.primary : context.themeCardBorder,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowColor.withValues(
                      alpha: _hovered ? 0.16 : 0.08,
                    ),
                    blurRadius: _hovered ? 18 : 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Material(
                color: AppColors.transparent,
                shape: const CircleBorder(),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: widget.onPressed,
                  child: Padding(
                    padding: EdgeInsets.all(11.w),
                    child: Icon(
                      Icons.arrow_upward_rounded,
                      size: 18.sp,
                      color: _hovered
                          ? AppColors.primary
                          : context.themeTextSecondary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
