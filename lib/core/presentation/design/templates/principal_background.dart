import 'package:flutter/material.dart';
import 'package:planets_app/core/presentation/design/tokens/colors.dart';

class PrincipalBackground extends StatelessWidget {
  const PrincipalBackground({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colors.blue2,
                  colors.blue3,
                ],
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
