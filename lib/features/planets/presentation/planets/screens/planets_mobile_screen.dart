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
import 'package:planets_app/features/planets/presentation/planets/planets_controller.dart';
import 'package:planets_app/features/planets/presentation/planets/planets_state.dart';
import 'package:planets_app/features/planets/presentation/planets/widgets/card_planet.dart';

class PlanetsMobileScreen extends StatelessWidget {
  const PlanetsMobileScreen({
    super.key,
    required Future<ListPlanetsResponse>? futurePlanets,
    required this.tecFilter,
    required this.controller,
    required this.state,
  }) : _futurePlanets = futurePlanets;

  final Future<ListPlanetsResponse>? _futurePlanets;
  final TextEditingController tecFilter;
  final PlanetsController controller;
  final PlanetsState state;

  @override
  Widget build(BuildContext context) {
    return PrincipalBackground(
        child: FutureBuilder(
      future: _futurePlanets,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      color: colors.blue2,
                      width: context.width(.6),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CustomText(
                            "Control panel",
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          const SizedBox(height: 30),
                          CustomTextFormField(
                            label: "Filter by planet name",
                            controller: tecFilter,
                            onChanged: (x) => controller.filterPlanetsByName(x),
                          ),
                        ],
                      ),
                    ),
                    if (prefs.favoritePlanet.isNotEmpty) ...[
                      const SizedBox(width: 10),
                      Container(
                        color: colors.blue2,
                        width: context.width(.3),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            const CustomText(
                              "Favorite planet",
                              fontSize: 12,
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: context.width(.3),
                              width: context.width(.3),
                              child: CardPlanet(
                                imageHeight: 80,
                                name: state.favoritePlanet?.name ??
                                    "Name not found",
                                pathImage: state.favoritePlanet?.image ?? "",
                              ),
                            )
                          ],
                        ),
                      )
                    ]
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: context.width(.9),
                  height: context.height(.7),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      const CustomText(
                        "Select a planet to get\nmore information.",
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
                                  CustomText("No planet was found"),
                                ],
                              )),
                        )
                      ] else ...[
                        SizedBox(
                          width: context.width(.9),
                          height: context.height(.5),
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
                                  imageHeight: 90,
                                  name: state.filterListPlanets![index].name,
                                  pathImage:
                                      state.filterListPlanets![index].image,
                                ),
                              );
                            },
                          ),
                        ),
                      ]
                    ],
                  ),
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
                  "An unexpected error occurred, please reload the page."),
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
            CustomText("We are loading the information...")
          ],
        ));
      },
    ));
  }
}
