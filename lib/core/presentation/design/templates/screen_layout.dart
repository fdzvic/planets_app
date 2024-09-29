import 'package:flutter/material.dart';
import 'package:planets_app/core/presentation/utils/constants.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ScreenLayout extends StatefulWidget {
  const ScreenLayout(
      {super.key,
      required this.screenDesktop,
      required this.screenTablet,
      required this.screenMobile});

  final Widget screenDesktop;
  final Widget screenTablet;
  final Widget screenMobile;

  @override
  State<ScreenLayout> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<ScreenLayout> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      breakpoints: ScreenBreakpoints(
        desktop: constants.dimensDesktop,
        tablet: constants.dimensTablet,
        watch: constants.dimensWatch,
      ),
      desktop: (context) => widget.screenDesktop,
      tablet: (context) => widget.screenTablet,
      mobile: (context) => OrientationLayoutBuilder(
        portrait: (context) => widget.screenMobile,
        landscape: (context) => widget.screenTablet,
      ),
    );
  }
}
