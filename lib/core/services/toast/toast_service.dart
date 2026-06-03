import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../router/app_router.dart';
import '../../theme/app_colors.dart';

enum ToastType { success, error, warning, info }

class ToastService {
  ToastService._();

  static OverlayEntry? _currentToast;

  static void show({
    required BuildContext context,
    required String message,
    required ToastType type,
    Duration duration = const Duration(seconds: 3),
    String? title,
  }) {
    try {
      dismiss();

      OverlayState? overlay;
      try {
        overlay = Overlay.maybeOf(context, rootOverlay: true);
      } catch (_) {}
      overlay ??= Overlay.maybeOf(context, rootOverlay: false);
      overlay ??= rootNavigatorKey.currentState?.overlay;

      if (overlay == null) {
        _showSnackBarFallback(context, message, type);
        return;
      }

      final overlayEntry = OverlayEntry(
        builder: (context) => _ToastWidget(
          message: message,
          type: type,
          title: title,
          duration: duration,
          onDismiss: dismiss,
        ),
      );

      _currentToast = overlayEntry;
      overlay.insert(overlayEntry);
    } catch (e) {
      debugPrint('ToastService error: $e');
      _showSnackBarFallback(context, message, type);
    }
  }

  static void _showSnackBarFallback(
    BuildContext context,
    String message,
    ToastType type,
  ) {
    final color = switch (type) {
      ToastType.error => AppColors.error,
      ToastType.success => AppColors.success,
      ToastType.warning => AppColors.warning,
      ToastType.info => AppColors.info,
    };

    ScaffoldMessenger.maybeOf(context)?.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static void success(
    BuildContext context,
    String message, {
    String? title,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context: context,
      message: message,
      type: ToastType.success,
      title: title,
      duration: duration,
    );
  }

  static void error(
    BuildContext context,
    String message, {
    String? title,
    Duration duration = const Duration(seconds: 4),
  }) {
    show(
      context: context,
      message: message,
      type: ToastType.error,
      title: title,
      duration: duration,
    );
  }

  static void warning(
    BuildContext context,
    String message, {
    String? title,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context: context,
      message: message,
      type: ToastType.warning,
      title: title,
      duration: duration,
    );
  }

  static void info(
    BuildContext context,
    String message, {
    String? title,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context: context,
      message: message,
      type: ToastType.info,
      title: title,
      duration: duration,
    );
  }

  static void successRoot(
    String message, {
    String? title,
    Duration duration = const Duration(seconds: 3),
  }) {
    final nav = rootNavigatorKey.currentState;
    if (nav == null || !nav.mounted) return;
    success(nav.context, message, title: title, duration: duration);
  }

  static void errorRoot(
    String message, {
    String? title,
    Duration duration = const Duration(seconds: 4),
  }) {
    final nav = rootNavigatorKey.currentState;
    if (nav == null || !nav.mounted) return;
    error(nav.context, message, title: title, duration: duration);
  }

  static void dismiss() {
    _currentToast?.remove();
    _currentToast = null;
  }
}

class _ToastWidget extends StatefulWidget {
  const _ToastWidget({
    required this.message,
    required this.type,
    required this.duration,
    required this.onDismiss,
    this.title,
  });

  final String message;
  final ToastType type;
  final String? title;
  final Duration duration;
  final VoidCallback onDismiss;

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();

    Future.delayed(widget.duration, () {
      if (mounted) {
        _dismiss();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _dismiss() async {
    await _controller.reverse();
    widget.onDismiss();
  }

  Color _backgroundColor() {
    return switch (widget.type) {
      ToastType.success => AppColors.successBg,
      ToastType.error => AppColors.errorBg,
      ToastType.warning => AppColors.warningBg,
      ToastType.info => AppColors.infoBg,
    };
  }

  Color _borderColor() {
    return switch (widget.type) {
      ToastType.success => AppColors.success,
      ToastType.error => AppColors.error,
      ToastType.warning => AppColors.warning,
      ToastType.info => AppColors.info,
    };
  }

  Color _textColor() {
    return switch (widget.type) {
      ToastType.success => AppColors.successText,
      ToastType.error => AppColors.errorText,
      ToastType.warning => AppColors.warningText,
      ToastType.info => AppColors.infoText,
    };
  }

  IconData _icon() {
    return switch (widget.type) {
      ToastType.success => Icons.check_circle_rounded,
      ToastType.error => Icons.error_rounded,
      ToastType.warning => Icons.warning_rounded,
      ToastType.info => Icons.info_rounded,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20.h,
      left: 0,
      right: 0,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                constraints: BoxConstraints(maxWidth: 500.w, minWidth: 300.w),
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: _backgroundColor(),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: _borderColor(), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(_icon(), color: _borderColor(), size: 24.sp),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.title != null) ...[
                            Text(
                              widget.title!,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: _textColor(),
                              ),
                            ),
                            SizedBox(height: 2.h),
                          ],
                          Text(
                            widget.message,
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              color: _textColor(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8.w),
                    GestureDetector(
                      onTap: _dismiss,
                      child: Icon(
                        Icons.close_rounded,
                        color: _textColor(),
                        size: 20.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
