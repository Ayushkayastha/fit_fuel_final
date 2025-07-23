
import 'package:fit_fuel_final/core/app_theme/text_form_theme.dart';
import 'package:fit_fuel_final/core/app_theme/text_theme.dart';
import 'package:flutter/material.dart';
class AppTheme{
  static  final _darkColorScheme=ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFFFB77B),
    onPrimary: Color(0xFF4C2700),
    primaryContainer: Color(0xFFFB8C00),
    onPrimaryContainer:Color(0xFF5F3200) ,
    primaryFixed:Color(0xFFFFDCC2),
    primaryFixedDim:Color(0xFFFFB77B) ,
    onPrimaryFixed:Color(0xFF2E1500) ,
    onPrimaryFixedVariant:Color(0xFF6D3A00) ,

    secondary: Color(0xFF99CBFF),
    onSecondary: Color(0xFF003355),
    secondaryContainer: Color(0xFF42A5F5),
    onSecondaryContainer: Color(0xFF00395E),
    secondaryFixed:Color(0xFFCFE5FF),
    secondaryFixedDim:Color(0xFF99CBFF),
    onSecondaryFixed:Color(0xFF001D34),
    onSecondaryFixedVariant:Color(0xFF004A78),

    tertiary: Color(0xFFD4BBFF),
    onTertiary: Color(0xFF3F0F81),
    tertiaryContainer:Color(0xFF7E57C2),
    onTertiaryContainer: Color(0xFFF6ECFF),
    tertiaryFixed: Color(0xFFEBDCFF),
    tertiaryFixedDim: Color(0xFFD4BBFF),
    onTertiaryFixed: Color(0xFF260058),
    onTertiaryFixedVariant: Color(0xFF572E99),

    error:Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    errorContainer: Color(0xFF),
    onErrorContainer: Color(0xFF),

    surface: Color(0xFF1B110A),
    onSurface: Color(0xFFF3DFD2),
    surfaceDim: Color(0xFF1B110A),
    surfaceBright: Color(0xFF43372E),
    surfaceContainerLowest:Color(0xFF150C06),
    surfaceContainerLow:Color(0xFF241A12),
    surfaceContainer: Color(0xFF281E15),
    surfaceContainerHigh: Color(0xFF33281F),
    surfaceContainerHighest: Color(0xFF3E3229),
    surfaceVariant:Color(0xFF564334),
    outline: Color(0xFFA48C7A),
    outlineVariant: Color(0xFF564334),
    inverseSurface: Color(0xFFF3DFD2),
    onInverseSurface: Color(0xFF3A2E25),
    onSurfaceVariant: Color(0xFFDCC1AE),
    inversePrimary: Color(0xFF8F4E00),
    scrim: Color(0xFF000000),
    shadow:Color(0xFF000000),
  );
  static  final _lightColorScheme=ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF8F4E00),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFFB8C00),
    onPrimaryContainer:Color(0xFF5F3200) ,
    primaryFixed:Color(0xFFFFDCC2),
    primaryFixedDim:Color(0xFFFFB77B) ,
    onPrimaryFixed:Color(0xFF2E1500) ,
    onPrimaryFixedVariant:Color(0xFF6D3A00) ,

    secondary: Color(0xFF00629D),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFF42A5F5),
    onSecondaryContainer: Color(0xFF00395E),
    secondaryFixed:Color(0xFFCFE5FF),
    secondaryFixedDim:Color(0xFF99CBFF),
    onSecondaryFixed:Color(0xFF001D34),
    onSecondaryFixedVariant:Color(0xFF004A78),

    tertiary: Color(0xFF653DA7),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer:Color(0xFF7E57C2),
    onTertiaryContainer: Color(0xFFF6ECFF),
    tertiaryFixed: Color(0xFFEBDCFF),
    tertiaryFixedDim: Color(0xFFD4BBFF),
    onTertiaryFixed: Color(0xFF260058),
    onTertiaryFixedVariant: Color(0xFF572E99),

    error:Color(0xFFBA1A1A),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF93000A),

    surface: Color(0xFFFFF8F5),
    onSurface: Color(0xFF241A12),
    surfaceDim: Color(0xFFEAD6C9),
    surfaceBright: Color(0xFFFFF8F5),
    surfaceContainerLowest: Color(0xFFFFFFFF),
    surfaceContainerLow:Color(0xFFFFF1E8),
    surfaceContainer: Color(0xFFFEEADD),
    surfaceContainerHigh: Color(0xFFF9E4D7),
    surfaceContainerHighest: Color(0xFFF3DFD2),
    surfaceVariant:Color(0xFFFADDC9),
    outline: Color(0xFF897362),
    outlineVariant: Color(0xFFDCC1AE),
    inverseSurface: Color(0xFF3A2E25),
    onInverseSurface: Color(0xFFFFEDE2),
    onSurfaceVariant: Color(0xFF564334),
    inversePrimary: Color(0xFFFFB77B),
    scrim: Color(0xFF000000),
    shadow:Color(0xFF000000),
  );

  static ThemeData getTheme({required bool isDark}) {
    return ThemeData(
      colorScheme: isDark ? _darkColorScheme : _lightColorScheme,
      textTheme: appTextTheme,
      inputDecorationTheme: textFormTheme(
        isDark ? _darkColorScheme : _lightColorScheme,
        appTextTheme,
      ),
    );
  }
}