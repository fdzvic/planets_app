import 'package:flutter/material.dart';
import 'package:planets_app/core/presentation/design/atoms/custom_text.dart';
import 'package:planets_app/core/presentation/design/tokens/colors.dart';
import 'package:planets_app/core/presentation/utils/validators.dart';

class CustomTextFormField extends StatefulWidget {
  /// Titulo input.
  final String label;
  final double? labelFontSize;
  final FontWeight? fontWeight;

  /// Text controller.
  final TextEditingController? controller;

  /// Whether the form is able to receive user input.
  final bool? enabled;

  /// Tipo de dato que se ingresará en el formulario.
  final InputValueType? inputValueType;

  /// Si es repetición de valor se debe validar.
  final String? matchValue;

  /// HintText del textFormField.
  final String? hintText;

  /// Ubicación icono de suffix;
  final String? suffixIconPath;

  /// Ubicación icono de prefix;
  final String? prefixIconPath;
  //Funcion para detectar los cambios en los inputs
  final Function(String)? onChanged;
  // Boleano para detectar errores del back que afecten el input
  final bool? errorBack;

  final String? timeToCompare;

  final Color? backgroundColor;

  final bool? suffixIconEnabled;

  final double? titleSpacingHeigth;
  final double? preffixSpacingWidth;

  final double? runSpacing;

  final String? helpText;

  final void Function(String)? onFieldSubmitted;

  const CustomTextFormField({
    super.key,
    required this.label,
    this.suffixIconPath,
    this.controller,
    this.enabled = true,
    this.inputValueType = InputValueType.text,
    this.matchValue,
    this.hintText,
    this.onChanged,
    this.errorBack = false,
    this.timeToCompare,
    this.prefixIconPath,
    this.labelFontSize,
    this.fontWeight,
    this.backgroundColor,
    this.suffixIconEnabled = true,
    this.titleSpacingHeigth,
    this.runSpacing,
    this.preffixSpacingWidth,
    this.helpText,
    this.onFieldSubmitted,
  });

  @override
  CustomTextFormFieldState createState() => CustomTextFormFieldState();
}

class CustomTextFormFieldState extends State<CustomTextFormField> {
  FocusNode focusNode = FocusNode();
  bool obscureText = false;
  bool? showError = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();

    focusNode.addListener(() {
      setState(() {});
    });

    Future.delayed(
      Duration.zero,
      () => {
        _addTextControllerListener(),
      },
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != "") ...[
          Row(
            children: [
              CustomText(
                widget.label,
                fontWeight: widget.fontWeight ?? FontWeight.w400,
                fontSize: widget.labelFontSize ?? 16,
                textColor: Colors.white,
              ),
            ],
          ),
          SizedBox(height: widget.titleSpacingHeigth ?? 5),
        ],
        Container(
          height: 48,
          padding: const EdgeInsets.only(left: 16, right: 18),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.fromBorderSide(BorderSide(color: _accentColor())),
          ),
          child: GestureDetector(
            onTap: () {
              focusNode.unfocus();
            },
            child: AbsorbPointer(
              absorbing: focusNode.hasFocus,
              child: TextFormField(
                focusNode: focusNode,
                onFieldSubmitted: widget.onFieldSubmitted,
                controller: widget.controller,
                validator: (x) => _validateInput(x ?? ''),
                onChanged: widget.onChanged,
                enabled: widget.enabled,
                textInputAction: TextInputAction.none,
                style: const TextStyle(
                  fontFamily: "Roboto",
                  color: Colors.white,
                  fontSize: 16,
                ),
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                    hintText: widget.hintText,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    isCollapsed: true,
                    errorStyle: const TextStyle(
                      fontSize: 0,
                      color: Colors.red,
                    ),
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontFamily: "Roboto",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    prefixIconConstraints:
                        const BoxConstraints(maxHeight: 25, maxWidth: 25)),
                keyboardType: _keyboardType(),
                obscureText: obscureText,
                obscuringCharacter: "*",
                cursorHeight: 24,
                cursorWidth: 1,
                cursorColor: Colors.white,
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Column(
            children: [
              /// Mensaje error
              if (showError! && errorMessage != "") ...[
                SizedBox(
                  width: double.infinity,
                  height: 24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 2),
                      CustomText(
                        errorMessage ?? "Esto es un error",
                        textColor: colors.red1,
                        fontSize: 14,
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                )
              ] else ...[
                if (widget.helpText?.isNotEmpty ?? false) ...[
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomText(widget.helpText,
                          fontSize: 14, textColor: colors.gray2),
                    ],
                  ),
                  const SizedBox(height: 5),
                ] else ...[
                  const SizedBox(height: 24),
                ],
              ]
            ],
          ),
        )
      ],
    );
  }

  void onTapSuffixIcon() {
    obscureText = !obscureText;
    setState(() {});
  }

  Color _accentColor() {
    if (showError! || widget.errorBack!) {
      return colors.red1;
    }
    return focusNode.hasFocus || (widget.controller?.text.isNotEmpty ?? false)
        ? Colors.white
        : Colors.white70;
  }

  _validate(String text) {
    switch (widget.inputValueType) {
      case InputValueType.text:
      default:
        errorMessage = validateText(text, matchValue: widget.matchValue);
        break;
    }
    showError = errorMessage != null;
    return errorMessage;
  }

  _addTextControllerListener() {
    if (widget.controller != null) {
      widget.controller!.addListener(() {});
    }
  }

  String? _validateInput(String x) {
    _validate(x);
    setState(() {});
    return errorMessage;
  }

  _keyboardType() {
    switch (widget.inputValueType) {
      case InputValueType.text:
      default:
        return TextInputType.text;
    }
  }
}

enum InputValueType {
  text,
}
