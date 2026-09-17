import 'package:career_portal/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Reusable [BoxDecoration] presets.
///
/// Use these on [Container] / [DecoratedBox] when you need the exact soft
/// shadow that [CardThemeData] cannot express (Flutter's Card widget only
/// supports elevation + shadowColor, not a custom [BoxShadow] list).
///
/// Example:
/// ```dart
/// Container(
///   decoration: AppDecorations.card,
///   child: ...,
/// )
/// ```
abstract final class AppDecorations {
  static const _cardRadius = BorderRadius.all(Radius.circular(16));
  static const _cardShadow = [
    BoxShadow(
      color: AppColors.shadowXSubtle,
      blurRadius: 10,
      offset: Offset(0, 4),
    ),
  ];

  /// White card with soft shadow — matches the design spec exactly.
  static const BoxDecoration card = BoxDecoration(
    color: AppColors.cardBackground,
    borderRadius: _cardRadius,
    boxShadow: _cardShadow,
  );

  /// Elevated card — slightly more prominent shadow for modals / dropdowns.
  static const BoxDecoration cardElevated = BoxDecoration(
    color: AppColors.cardBackground,
    borderRadius: _cardRadius,
    boxShadow: [
      BoxShadow(
        color: AppColors.shadowColor,
        blurRadius: 24,
        offset: Offset(0, 8),
      ),
    ],
  );

  /// Dark-mode card.
  static const BoxDecoration cardDark = BoxDecoration(
    color: AppColors.cardBackgroundDark,
    borderRadius: _cardRadius,
    boxShadow: [
      BoxShadow(
        color: AppColors.shadowDark,
        blurRadius: 10,
        offset: Offset(0, 4),
      ),
    ],
  );

  /// Bordered card — use when a subtle outline IS needed (e.g. table rows).
  static const BoxDecoration cardBordered = BoxDecoration(
    color: AppColors.cardBackground,
    borderRadius: _cardRadius,
    border: Border.fromBorderSide(BorderSide(color: AppColors.cardBorder)),
    boxShadow: _cardShadow,
  );
}
