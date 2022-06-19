import 'package:flutter/material.dart';

import 'color_palette/colors.dart';

abstract class AppTypography {
  static const TextStyle regular = TextStyle(
    fontFamily: 'Bebas',
    color: AppColors.white,
  );
  static const TextStyle bold = TextStyle(
    fontFamily: 'BebasBold',
    color: AppColors.white,
  );
}
