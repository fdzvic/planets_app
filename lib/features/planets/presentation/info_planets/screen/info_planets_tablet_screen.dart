import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:planets_app/core/presentation/design/atoms/custom_primary_button.dart';
import 'package:planets_app/core/presentation/design/templates/principal_background.dart';
import 'package:planets_app/core/presentation/design/tokens/colors.dart';
import 'package:planets_app/core/presentation/utils/dimens_extension.dart';
import 'package:planets_app/core/presentation/utils/paths/paths_images.dart';
import 'package:planets_app/core/presentation/utils/routes.dart';
import 'package:planets_app/features/planets/presentation/info_planets/info_planets_controller.dart';
import 'package:planets_app/features/planets/presentation/info_planets/info_planets_state.dart';
import 'package:planets_app/features/planets/presentation/info_planets/widgets/card_information_planet.dart';

class InfoPlanetsTabletScreen extends StatelessWidget {
  const InfoPlanetsTabletScreen({
    super.key,
    required this.state,
    required this.controller,
  });

  final InfoPlanetsState state;
  final InfoPlanetsController controller;

  @override
  Widget build(BuildContext context) {
    return PrincipalBackground(
        child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: CardInformationPlanet(
                width: context.width(),
                height: context.height(.4),
                state: state),
          ),
          SizedBox(
            height: context.height(.5),
            width: context.width(.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  state.selectedPlanet?.image ?? "",
                  height: context.height(.4),
                  width: context.width(.8),
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    return Image.asset(
                      images.noImageAvailable,
                      height: context.height(.4),
                      width: context.width(.7),
                      fit: BoxFit.cover,
                    );
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrimaryButton(
                        text: state.isFavoritePlanet!
                            ? "Quitar de Favorito"
                            : "Marcar como favorito",
                        backgroundColor:
                            state.isFavoritePlanet! ? colors.red1 : null,
                        onPressed: () => state.isFavoritePlanet!
                            ? controller.deleteFavorite()
                            : controller.onFavoritePlanet()),
                    const SizedBox(width: 20),
                    PrimaryButton(
                        text: "Buscar otro planeta",
                        onPressed: () => context.go(Routes.planets)),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
