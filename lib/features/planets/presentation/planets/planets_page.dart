import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:planets_app/core/data/user_preferences.dart';
import 'package:planets_app/core/presentation/design/atoms/custom_text.dart';
import 'package:planets_app/core/presentation/design/atoms/custom_text_form_field.dart';
import 'package:planets_app/core/presentation/design/templates/principal_background.dart';
import 'package:planets_app/core/presentation/design/tokens/colors.dart';
import 'package:planets_app/core/presentation/utils/dimens_extension.dart';
import 'package:planets_app/core/presentation/utils/routes.dart';
import 'package:planets_app/features/planets/domain/list_planets_response.dart';
import 'package:planets_app/features/planets/presentation/planets/widgets/card_planet.dart';
import 'planets_controller.dart';

class PlanetsPage extends ConsumerStatefulWidget {
  const PlanetsPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PlanetsState();
}

class _PlanetsState extends ConsumerState<PlanetsPage> {
  TextEditingController tecFilter = TextEditingController();

  Future<ListPlanetsResponse>? _futurePlanets;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      _futurePlanets = ref.watch(planetsController.notifier).getListPlanets();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var controller = ref.watch(planetsController.notifier);
    var state = ref.watch(planetsController);
    return PrincipalBackground(
        child: FutureBuilder(
      future: _futurePlanets,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Row(
            children: [
              SizedBox(
                width: context.width(.5),
                child: Container(
                  color: colors.blue2,
                  width: context.width(.4),
                  margin: const EdgeInsets.only(left: 50),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CustomText(
                        "Panel de control",
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                      const SizedBox(height: 30),
                      CustomTextFormField(
                        label: "Filtrar por nombre del planeta",
                        controller: tecFilter,
                        onChanged: (x) => controller.filterPlanetsByName(x),
                      ),
                      if (prefs.favoritePlanet.isNotEmpty) ...[
                        const SizedBox(height: 20),
                        const CustomText(
                          "Planeta favorito",
                          fontSize: 24,
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: context.width(.2),
                          width: context.width(.2),
                          child: CardPlanet(
                            imageHeight: context.width(.17),
                            name: state.favoritePlanet?.name ?? "No hay nombre",
                            pathImage: state.favoritePlanet?.image ?? "",
                          ),
                        )
                      ]
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: context.width(.5),
                height: context.height(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    const CustomText(
                      "Selecciona un planeta para obtener\nmás información.",
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      textAlign: TextAlign.center,
                      height: 1.1,
                    ),
                    const SizedBox(height: 20),
                    if (state.filterListPlanets?.isEmpty ?? true) ...[
                      Expanded(
                        child: Container(
                            alignment: Alignment.center,
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.warning,
                                  color: Colors.white,
                                  size: 50,
                                ),
                                SizedBox(height: 10),
                                CustomText("No se encontró ningun planeta"),
                              ],
                            )),
                      )
                    ] else ...[
                      SizedBox(
                        width: context.width(.4),
                        height: context.height(.8),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: .9,
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: state.filterListPlanets!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                context.go(
                                    '${Routes.planets}/${state.filterListPlanets![index].name}');
                              },
                              child: CardPlanet(
                                name: state.filterListPlanets![index].name,
                                pathImage:
                                    state.filterListPlanets![index].image,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                    ]
                  ],
                ),
              )
            ],
          );
        } else if (snapshot.hasError) {
          return const Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                  "Ocurrió un error inesperado, por favor recargue la página."),
            ],
          ));
        }

        return const Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Colors.white,
            ),
            SizedBox(height: 10),
            CustomText("Estamos cargando la información...")
          ],
        ));
      },
    ));
  }
}
