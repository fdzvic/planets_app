import 'package:flutter/material.dart';
import 'package:planets_app/core/presentation/design/atoms/custom_text.dart';
import 'package:planets_app/core/presentation/design/tokens/colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.buttonType = ButtonType.primary,
    this.icon,
    this.enabled = true,
    this.height,
    this.width,
    this.textColor,
    this.borderColor,
    this.isLoading = false,
    this.fontSizeText,
    this.buttonPadding,
  });

  final String text;
  final Function onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final ButtonType buttonType;
  final Widget? icon;
  final bool enabled;
  final double? height;
  final double? width;
  final bool? isLoading;
  final double? fontSizeText;
  final EdgeInsetsGeometry? buttonPadding;

  @override
  Widget build(BuildContext context) {
    return TextButtonTheme(
      data: TextButtonThemeData(
          style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                _getBackgroundColor(buttonType),
              ),
              maximumSize: width != null
                  ? WidgetStatePropertyAll(Size(width!, 52))
                  : null,
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  side: BorderSide(
                      color: borderColor ?? _getBorderColor(buttonType)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              minimumSize:
                  WidgetStateProperty.all(Size(width ?? 160, height ?? 52)),

              /// Color icon
              foregroundColor:
                  WidgetStateProperty.all(_getBackgroundColor(buttonType)),
              overlayColor: WidgetStateProperty.all(Colors.transparent))),
      child: TextButton(
          onPressed: enabled && isLoading == false ? () => onPressed() : null,
          child: Padding(
            padding:
                buttonPadding ?? const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: icon != null
                  ? MainAxisAlignment.spaceEvenly
                  : MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (isLoading!) ...[
                  const SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                ] else ...[
                  CustomText(
                    text,
                    textColor: textColor ?? _getTextColor(buttonType),
                    fontWeight: FontWeight.w500,
                    fontSize: fontSizeText ?? 16,
                  ),
                ]
              ],
            ),
          )),
    );
  }

  _getBackgroundColor(ButtonType buttonType) {
    switch (buttonType) {
      case ButtonType.primary:
        return backgroundColor ??
            (enabled ? colors.primaryColor : colors.gray1);

      case ButtonType.secondary:
        return backgroundColor ??
            (enabled ? colors.primaryColor : colors.gray1);

      default:
        return backgroundColor ??
            (enabled ? colors.primaryColor : colors.gray1);
    }
  }

  _getBorderColor(ButtonType buttonType) {
    switch (buttonType) {
      case ButtonType.primary:
        return borderColor ?? (enabled ? colors.primaryColor : colors.gray1);

      case ButtonType.secondary:
        return borderColor ?? (enabled ? colors.textColor : colors.gray1);

      default:
        return backgroundColor ??
            (enabled ? colors.primaryColor : colors.gray1);
    }
  }

  _getTextColor(ButtonType buttonType) {
    switch (buttonType) {
      case ButtonType.primary:
        return textColor ?? Colors.white;

      case ButtonType.secondary:
        return textColor ?? colors.textColor;

      default:
        return backgroundColor ??
            (enabled ? colors.primaryColor : colors.gray1);
    }
  }
}

enum ButtonType { primary, secondary }
