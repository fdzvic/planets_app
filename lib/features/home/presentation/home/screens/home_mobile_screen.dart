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
              "!Welcome to Planets App!",
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
                    "We are excited to have you join us on this journey through the cosmos. Here you will be able to explore the mysteries of the planets in our solar system, discover fascinating curiosities, and learn about their unique characteristics.\n\nGet ready to be dazzled by the beauty of the universe. Let's start exploring together!",
                    textAlign: TextAlign.center,
                    fontSize: 12,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  PrimaryButton(
                    text: "See planets",
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
