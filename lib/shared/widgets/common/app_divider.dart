import 'package:career_portal/core/theme/app_colors.dart';
import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:flutter/material.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({
    super.key,
    this.height,
    this.thickness,
    this.color,
    this.indent,
    this.endIndent,
    this.margin,
    this.borderRadius,
  });

  const AppDivider.horizontal({
    super.key,
    this.height = 1,
    this.thickness = 1,
    this.color,
    this.indent,
    this.endIndent,
    this.margin,
    this.borderRadius,
  });

  const AppDivider.thin({
    super.key,
    this.height = 1,
    this.thickness = 0.5,
    this.color,
    this.indent,
    this.endIndent,
    this.margin,
    this.borderRadius,
  });

  const AppDivider.thick({
    super.key,
    this.height = 2,
    this.thickness = 2,
    this.color,
    this.indent,
    this.endIndent,
    this.margin,
    this.borderRadius,
  });

  final double? height;
  final double? thickness;
  final Color? color;
  final double? indent;
  final double? endIndent;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final defaultColor = isDark ? AppColors.cardBorderDark : AppColors.cardBorder;
    final effectiveColor = color ?? defaultColor;
    final effectiveThickness = thickness ?? 1;

    if (borderRadius != null && borderRadius! > 0) {
      final bar = Container(
        height: effectiveThickness,
        decoration: BoxDecoration(
          color: effectiveColor,
          borderRadius: BorderRadius.circular(borderRadius!),
        ),
      );
      return margin != null ? Padding(padding: margin!, child: bar) : bar;
    }

    final divider = Divider(
      height: height,
      thickness: effectiveThickness,
      color: effectiveColor,
      indent: indent,
      endIndent: endIndent,
    );

    return margin != null ? Padding(padding: margin!, child: divider) : divider;
  }
}

class AppVerticalDivider extends StatelessWidget {
  const AppVerticalDivider({
    super.key,
    this.width,
    this.thickness,
    this.color,
    this.indent,
    this.endIndent,
    this.margin,
  });

  const AppVerticalDivider.standard({
    super.key,
    this.width = 1,
    this.thickness = 1,
    this.color,
    this.indent,
    this.endIndent,
    this.margin,
  });

  final double? width;
  final double? thickness;
  final Color? color;
  final double? indent;
  final double? endIndent;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final defaultColor = isDark ? AppColors.cardBorderDark : AppColors.cardBorder;

    final divider = VerticalDivider(
      width: width,
      thickness: thickness ?? 1,
      color: color ?? defaultColor,
      indent: indent,
      endIndent: endIndent,
    );

    return margin != null ? Padding(padding: margin!, child: divider) : divider;
  }
}
