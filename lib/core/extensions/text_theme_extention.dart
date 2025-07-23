

import 'package:flutter/material.dart';

extension EmphasizedTextTheme on TextTheme {
  TextStyle get displayLargeEmphasized =>displayLarge!.copyWith(fontWeight: FontWeight.w500);
  TextStyle get displayMediumEmphasized => displayMedium!.copyWith(fontWeight: FontWeight.w500);
  TextStyle get displaySmallEmphasized => displaySmall!.copyWith(fontWeight: FontWeight.w500);

  TextStyle get headlineLargeEmphasized => headlineLarge!.copyWith(fontWeight: FontWeight.w500);
  TextStyle get headlineMediumEmphasized => headlineMedium!.copyWith(fontWeight: FontWeight.w500);
  TextStyle get headlineSmallEmphasized => headlineSmall!.copyWith(fontWeight: FontWeight.w500);

  TextStyle get titleLargeEmphasized => titleLarge!.copyWith(fontWeight: FontWeight.w500);
  TextStyle get titleMediumEmphasized => titleMedium!.copyWith(fontWeight: FontWeight.w700);
  TextStyle get titleSmallEmphasized => titleSmall!.copyWith(fontWeight: FontWeight.w700);

  TextStyle get bodyLargeEmphasized => bodyLarge!.copyWith(fontWeight: FontWeight.w500);
  TextStyle get bodyMediumEmphasized => bodyMedium!.copyWith(fontWeight: FontWeight.w500);
  TextStyle get bodySmallEmphasized => bodySmall!.copyWith(fontWeight: FontWeight.w500);

  TextStyle get labelLargeEmphasized => labelLarge!.copyWith(fontWeight: FontWeight.w700);
  TextStyle get labelMediumEmphasized => labelMedium!.copyWith(fontWeight: FontWeight.w700);
  TextStyle get labelSmallEmphasized => labelSmall!.copyWith(fontWeight: FontWeight.w700);
}

