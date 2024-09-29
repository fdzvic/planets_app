import 'package:flutter/material.dart';
import 'package:planets_app/core/presentation/design/tokens/colors.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final Color? textColor;
  final FontWeight? fontWeight;
  final TextDecoration? textDecoration;
  final double? fontSize;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? height;
  final bool? isTitle;

  const CustomText(
    this.text, {
    super.key,
    this.textColor,
    this.fontWeight = FontWeight.w400,
    this.textDecoration,
    this.maxLines,
    this.textAlign,
    this.fontSize = 16,
    this.overflow,
    this.height = 1,
    this.isTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      textAlign: textAlign,
      maxLines: maxLines ?? 100,
      overflow: overflow,
      style: TextStyle(
        color: textColor ?? colors.textColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: height,
        decoration: textDecoration,
        decorationColor: textColor ?? colors.textColor,
      ),
    );
  }
}
