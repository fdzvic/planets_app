import 'package:flutter/material.dart';
import 'package:planets_app/core/presentation/design/tokens/colors.dart';

class Theme {
  ThemeData theme = ThemeData(
    useMaterial3: true,
    primaryColor: colors.primaryColor,
    scaffoldBackgroundColor: colors.backgroundColor,
    // dialogBackgroundColor: colors.cardColor,
    // hintColor: colors.avocado,
    // focusColor: colors.lettuce,
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: colors.textColor,
        fontSize: 18,
      ),
      bodyMedium: TextStyle(
        color: colors.textColor,
        fontSize: 16,
      ),
      displayLarge: TextStyle(
        color: colors.textColor,
        fontSize: 26,
        fontWeight: FontWeight.w500,
      ),
      displayMedium: TextStyle(
        color: colors.textColor,
        fontSize: 22,
        fontWeight: FontWeight.w500,
      ),
      displaySmall: TextStyle(
        color: colors.textColor,
        fontSize: 15,
      ),
    ),
  );
}
