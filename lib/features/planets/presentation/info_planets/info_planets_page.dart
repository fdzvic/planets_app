import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:planets_app/core/presentation/design/atoms/custom_primary_button.dart';
import 'package:planets_app/core/presentation/design/templates/principal_background.dart';
import 'package:planets_app/core/presentation/utils/dimens_extension.dart';
import 'package:planets_app/core/presentation/utils/paths/paths_images.dart';
import 'package:planets_app/core/presentation/utils/routes.dart';
import 'package:planets_app/features/planets/presentation/info_planets/info_planets_controller.dart';
import 'package:planets_app/features/planets/presentation/info_planets/widgets/card_information_planet.dart';

class InfoPlanetsPage extends ConsumerStatefulWidget {
  final String planetName;
  const InfoPlanetsPage({
    super.key,
    required this.planetName,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InfoPlanetsState();
}

class _InfoPlanetsState extends ConsumerState<InfoPlanetsPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      bool success = await ref
          .watch(infoPlanetsController.notifier)
          .initData(widget.planetName);
      if (!success) {
        if (!context.mounted) return;
        context.go(Routes.planetNoFound);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //var controller = ref.watch(infoPlanetsController.notifier);
    var state = ref.watch(infoPlanetsController);
    return PrincipalBackground(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: context.height(),
          width: context.width(.5),
          alignment: Alignment.center,
          child: CardInformationPlanet(state: state),
        ),
        SizedBox(
          height: context.height(),
          width: context.width(.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: "img_hero",
                child: Image.network(
                  state.selectedPlanet?.image ?? "",
                  height: context.height(.6),
                  width: context.width(.4),
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    return Image.asset(
                      images.noImageAvailable,
                      height: context.height(.6),
                      width: context.width(.4),
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PrimaryButton(text: "Marcar como favorito", onPressed: () {}),
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
    ));
  }
}
