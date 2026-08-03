import 'package:career_portal/core/services/responsive/breakpoints.dart';
import 'package:career_portal/core/services/responsive/responsive_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ResponsiveDebugLogger extends StatefulWidget {
  const ResponsiveDebugLogger({super.key, required this.child});

  final Widget child;

  @override
  State<ResponsiveDebugLogger> createState() => _ResponsiveDebugLoggerState();
}

class _ResponsiveDebugLoggerState extends State<ResponsiveDebugLogger> {
  static const _c = '\x1B[95m';
  static const _b = '\x1B[1m';
  static const _r = '\x1B[0m';

  Size? _lastSize;
  ScreenLayout? _lastLayout;

  void _logIfChanged(BuildContext context) {
    if (!kDebugMode) return;

    final size = MediaQuery.sizeOf(context);
    final layout = AppBreakpoints.fromWidth(size.width);
    if (size == _lastSize && layout == _lastLayout) return;

    _lastSize = size;
    _lastLayout = layout;

    final dpr = MediaQuery.devicePixelRatioOf(context);
    final design = ResponsiveHelper.screenUtilDesignSize(context);
    final scale = size.width / design.width;

    debugPrint(
      '$_c$_b🟣 [Responsive]$_r$_c '
      '${size.width.toStringAsFixed(0)}×${size.height.toStringAsFixed(0)} '
      '| $layout '
      '| design ${design.width.toStringAsFixed(0)}×${design.height.toStringAsFixed(0)} '
      '| scale ${scale.toStringAsFixed(2)} '
      '| dpr ${dpr.toStringAsFixed(2)}'
      '$_r',
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, _) {
        _logIfChanged(context);
        return widget.child;
      },
    );
  }
}
