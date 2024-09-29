import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:planets_app/core/presentation/design/atoms/custom_primary_button.dart';
import 'package:planets_app/core/presentation/design/atoms/custom_text.dart';
import 'package:planets_app/core/presentation/design/atoms/custom_text_form_field.dart';
import 'package:planets_app/core/presentation/design/templates/principal_background.dart';
import 'package:planets_app/core/presentation/design/tokens/colors.dart';
import 'package:planets_app/core/presentation/utils/dimens_extension.dart';
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
              Container(
                width: context.width(.5),
                height: context.height(),
                alignment: Alignment.center,
                child: Container(
                  color: colors.blue2,
                  width: context.width(.4),
                  height: context.height(.3),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextFormField(
                        label: "Filtrar por nombre del planeta",
                        controller: tecFilter,
                        onChanged: (x) => controller.filterPlanetsByName(x),
                      ),
                      const SizedBox(height: 10),
                      PrimaryButton(text: "Buscar", onPressed: () {})
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
                      Expanded(
                        child: SizedBox(
                          width: context.width(.3),
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: .75,
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: state.filterListPlanets!.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  context.go(
                                      '/information-planets/${state.filterListPlanets![index].name}');
                                },
                                child: CardPlanet(
                                  name: state.filterListPlanets![index].name,
                                  pathImage:
                                      state.filterListPlanets![index].image,
                                  mass: state.filterListPlanets![index].massKg,
                                ),
                              );
                            },
                          ),
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
