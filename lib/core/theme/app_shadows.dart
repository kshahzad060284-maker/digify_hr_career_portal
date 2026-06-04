import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppShadows {
  static List<BoxShadow> get primaryShadow => [
    BoxShadow(
      color: AppColors.shadowColor,
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];
}
