import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:planets_app/core/presentation/design/atoms/custom_primary_button.dart';
import 'package:planets_app/core/presentation/design/atoms/custom_text.dart';
import 'package:planets_app/core/presentation/design/templates/principal_background.dart';
import 'package:planets_app/core/presentation/design/tokens/colors.dart';
import 'package:planets_app/core/presentation/utils/dimens_extension.dart';
import 'package:planets_app/core/presentation/utils/routes.dart';
import 'package:planets_app/features/home/presentation/home/home_controller.dart';
import 'package:planets_app/features/home/presentation/home/home_state.dart';

class HomeMobileScreen extends StatelessWidget {
  const HomeMobileScreen({
    super.key,
    required this.homeController,
    required this.homeState,
  });

  final HomeController homeController;
  final HomeState homeState;

  @override
  Widget build(BuildContext context) {
    return PrincipalBackground(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomText(
              " ¡Bienvenido a Planets App!",
              fontSize: 24,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              width: context.width(.9),
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: colors.blue2.withOpacity(.8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  const CustomText(
                    "Estamos emocionados de que te unas a nosotros en este viaje a través del cosmos. Aquí podrás explorar los misterios de los planetas de nuestro sistema solar, descubrir curiosidades fascinantes y aprender sobre sus características únicas.\n\nPrepárate para deslumbrarte con la belleza del universo. ¡Comencemos a explorar juntos!",
                    textAlign: TextAlign.center,
                    fontSize: 12,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  PrimaryButton(
                    text: "Comenzar",
                    isLoading: homeState.isLoading,
                    onPressed: () => toContinue(context),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void toContinue(BuildContext context) async {
    bool response = await homeController.toContinue();
    if (!context.mounted) return;
    response ? context.go(Routes.planets) : null;
  }
}
