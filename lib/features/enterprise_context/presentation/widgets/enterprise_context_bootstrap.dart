import 'dart:async';
import 'dart:math' as math;

import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/localization/generated/app_localizations.dart';
import 'package:career_portal/core/network/app_exception.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/features/enterprise_context/domain/models/enterprise_context.dart';
import 'package:career_portal/features/enterprise_context/presentation/providers/enterprise_context_provider.dart';
import 'package:career_portal/gen/assets.gen.dart';
import 'package:career_portal/shared/widgets/assets/app_asset.dart';
import 'package:career_portal/shared/widgets/common/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class EnterpriseContextBootstrap extends ConsumerStatefulWidget {
  const EnterpriseContextBootstrap({required this.child, super.key});

  final Widget child;

  @override
  ConsumerState<EnterpriseContextBootstrap> createState() =>
      _EnterpriseContextBootstrapState();
}

class _EnterpriseContextBootstrapState
    extends ConsumerState<EnterpriseContextBootstrap> {
  static const Duration _minBrandedLoadingDuration = Duration(seconds: 3);

  bool _holdComplete = false;
  String? _enterpriseName;
  Timer? _holdTimer;

  @override
  void dispose() {
    _holdTimer?.cancel();
    super.dispose();
  }

  void _startHold(EnterpriseContext context) {
    _holdTimer?.cancel();
    setState(() {
      _holdComplete = false;
      _enterpriseName = context.enterpriseName.trim();
    });
    _holdTimer = Timer(_minBrandedLoadingDuration, () {
      if (!mounted) return;
      setState(() => _holdComplete = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<EnterpriseContext>>(enterpriseContextProvider, (
      previous,
      next,
    ) {
      next.whenOrNull(
        data: _startHold,
        loading: () {
          _holdTimer?.cancel();
          setState(() {
            _holdComplete = false;
            _enterpriseName = null;
          });
        },
        error: (error, stackTrace) {
          _holdTimer?.cancel();
          setState(() {
            _holdComplete = false;
            _enterpriseName = null;
          });
        },
      );
    });

    final asyncContext = ref.watch(enterpriseContextProvider);

    return asyncContext.when(
      data: (enterpriseContext) {
        if (!_holdComplete && _holdTimer == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted || _holdComplete || _holdTimer != null) return;
            _startHold(enterpriseContext);
          });
        }
        if (!_holdComplete) {
          return _EnterpriseContextLoadingView(
            enterpriseName: _enterpriseName ?? enterpriseContext.enterpriseName,
          );
        }
        return widget.child;
      },
      loading: () =>
          _EnterpriseContextLoadingView(enterpriseName: _enterpriseName),
      error: (error, _) => _EnterpriseContextErrorView(
        message: _resolveErrorMessage(context, error),
        onRetry: () => ref.read(enterpriseContextProvider.notifier).retry(),
      ),
    );
  }

  String _resolveErrorMessage(BuildContext context, Object error) {
    final localizations = AppLocalizations.of(context);
    if (error is AppException && error.message.trim().isNotEmpty) {
      return error.message;
    }
    return localizations?.enterpriseContextLoadFailed ??
        'Unable to resolve enterprise context. Please try again.';
  }
}

/// Fixed logical sizes shared with `web/splash/splash.css` so the HTML
/// engine-boot splash and this view hand off without a size jump.
/// Do not use ScreenUtil here — scaling would break that match.
class _SplashMetrics {
  static const double orbit = 200;
  static const double logoWrap = 104;
  static const double logo = 54;
  static const double gapAfterOrbit = 36;
  static const double titleSize = 24;
  static const double gapTitleSubtitle = 10;
  static const double subtitleSize = 16;
  static const double gapBeforeBar = 32;
  static const double barWidth = 240;
  static const double barHeight = 5;
  static const double horizontalPadding = 32;
  static const double shadowBlur = 32;
  static const double shadowSpread = 3;
  static const double lineHeight = 1.2;
}

class _EnterpriseContextLoadingView extends StatefulWidget {
  const _EnterpriseContextLoadingView({this.enterpriseName});

  final String? enterpriseName;

  @override
  State<_EnterpriseContextLoadingView> createState() =>
      _EnterpriseContextLoadingViewState();
}

class _EnterpriseContextLoadingViewState
    extends State<_EnterpriseContextLoadingView>
    with TickerProviderStateMixin {
  late final AnimationController _orbitController;
  late final AnimationController _barController;

  @override
  void initState() {
    super.initState();
    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();
    _barController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat();
  }

  @override
  void dispose() {
    _orbitController.dispose();
    _barController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final isDark = context.isDark;
    final enterpriseName = widget.enterpriseName?.trim();
    final title = enterpriseName != null && enterpriseName.isNotEmpty
        ? (localizations?.loadingWebsite(enterpriseName) ??
              'Loading $enterpriseName...')
        : (localizations?.loading ?? 'Loading...');
    final subtitle =
        localizations?.loadingWebsiteMessage ?? 'Preparing your workspace...';
    final accent = AppColors.primary;
    final ringColor = isDark
        ? AppColors.textSecondaryDark.withValues(alpha: 0.35)
        : accent.withValues(alpha: 0.18);

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: _SplashMetrics.horizontalPadding,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: _SplashMetrics.orbit,
                height: _SplashMetrics.orbit,
                child: AnimatedBuilder(
                  animation: _orbitController,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: _OrbitDotsPainter(
                        progress: _orbitController.value,
                        accent: accent,
                        ringColor: ringColor,
                      ),
                      child: Center(child: child),
                    );
                  },
                  child: Container(
                    width: _SplashMetrics.logoWrap,
                    height: _SplashMetrics.logoWrap,
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.cardBackgroundDark
                          : AppColors.cardBackground,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: accent.withValues(alpha: isDark ? 0.25 : 0.16),
                          blurRadius: _SplashMetrics.shadowBlur,
                          spreadRadius: _SplashMetrics.shadowSpread,
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: AppAsset(
                      // Same mark as web/splash/digify-mark.png
                      assetPath: Assets.logo.digifyFavicon.path,
                      width: _SplashMetrics.logo,
                      height: _SplashMetrics.logo,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: _SplashMetrics.gapAfterOrbit),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: _SplashMetrics.titleSize,
                  height: _SplashMetrics.lineHeight,
                  letterSpacing: 0,
                ),
              ),
              const SizedBox(height: _SplashMetrics.gapTitleSubtitle),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondary,
                  fontWeight: FontWeight.w400,
                  fontSize: _SplashMetrics.subtitleSize,
                  height: _SplashMetrics.lineHeight,
                  letterSpacing: 0,
                ),
              ),
              const SizedBox(height: _SplashMetrics.gapBeforeBar),
              SizedBox(
                width: _SplashMetrics.barWidth,
                height: _SplashMetrics.barHeight,
                child: AnimatedBuilder(
                  animation: _barController,
                  builder: (context, _) {
                    return CustomPaint(
                      painter: _IndeterminateBarPainter(
                        progress: _barController.value,
                        accent: accent,
                        trackColor: isDark
                            ? AppColors.textSecondaryDark.withValues(alpha: 0.2)
                            : accent.withValues(alpha: 0.12),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrbitDotsPainter extends CustomPainter {
  _OrbitDotsPainter({
    required this.progress,
    required this.accent,
    required this.ringColor,
  });

  final double progress;
  final Color accent;
  final Color ringColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.shortestSide * 0.42;

    final ringPaint = Paint()
      ..color = ringColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, radius, ringPaint);

    const dotCount = 3;
    for (var i = 0; i < dotCount; i++) {
      final angle = (progress * 2 * math.pi) + (i * 2 * math.pi / dotCount);
      final opacity =
          0.35 + (0.65 * ((math.sin(progress * 2 * math.pi + i) + 1) / 2));
      final dotOffset = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      final paint = Paint()..color = accent.withValues(alpha: opacity);
      canvas.drawCircle(dotOffset, 7 - (i * 0.8), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _OrbitDotsPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.accent != accent ||
        oldDelegate.ringColor != ringColor;
  }
}

class _IndeterminateBarPainter extends CustomPainter {
  _IndeterminateBarPainter({
    required this.progress,
    required this.accent,
    required this.trackColor,
  });

  final double progress;
  final Color accent;
  final Color trackColor;

  @override
  void paint(Canvas canvas, Size size) {
    final radius = Radius.circular(size.height);
    final trackRect = RRect.fromRectAndRadius(Offset.zero & size, radius);
    canvas.drawRRect(trackRect, Paint()..color = trackColor);

    final travel = progress * 1.4 - 0.2;
    final start = (travel.clamp(0.0, 1.0)) * size.width;
    final end = ((travel + 0.35).clamp(0.0, 1.0)) * size.width;
    if (end <= start) return;

    final barRect = RRect.fromRectAndRadius(
      Rect.fromLTRB(start, 0, end, size.height),
      radius,
    );
    canvas.drawRRect(barRect, Paint()..color = accent);
  }

  @override
  bool shouldRepaint(covariant _IndeterminateBarPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.accent != accent ||
        oldDelegate.trackColor != trackColor;
  }
}

class _EnterpriseContextErrorView extends StatelessWidget {
  const _EnterpriseContextErrorView({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final isDark = context.isDark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.cloud_off_outlined,
                size: 48.r,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondary,
              ),
              Gap(16.h),
              Text(
                message,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimary,
                ),
              ),
              Gap(24.h),
              AppButton(
                label: localizations?.retry ?? 'Retry',
                onPressed: onRetry,
                type: AppButtonType.primary,
                width: 160.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
