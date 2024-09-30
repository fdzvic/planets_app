import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:planets_app/core/presentation/design/atoms/custom_primary_button.dart';
import 'package:planets_app/core/presentation/design/atoms/custom_text.dart';
import 'package:planets_app/core/presentation/design/templates/principal_background.dart';
import 'package:planets_app/core/presentation/utils/dimens_extension.dart';
import 'package:planets_app/core/presentation/utils/routes.dart';

class PlanetNoFoundPage extends ConsumerWidget {
  const PlanetNoFoundPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // var controller = ref.watch(planetNoFoundController.notifier);
    // var state = ref.watch(planetNoFoundController);
    return PrincipalBackground(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.warning,
            size: 200,
            color: Colors.white,
          ),
          const CustomText(
            "Planet no found",
            fontSize: 32,
          ),
          const SizedBox(height: 20),
          PrimaryButton(
              text: "Retry search",
              width: context.width(.5),
              onPressed: () => context.go(Routes.planets))
        ],
      )),
    );
  }
}
