import 'package:flutter/material.dart';
import 'package:planets_app/core/presentation/design/atoms/custom_text.dart';
import 'package:planets_app/core/presentation/design/tokens/colors.dart';
import 'package:planets_app/core/presentation/utils/dimens_extension.dart';
import 'package:planets_app/features/planets/presentation/info_planets/info_planets_state.dart';

class CardInformationPlanet extends StatelessWidget {
  const CardInformationPlanet({
    super.key,
    required this.state,
    this.width,
    this.height,
  });

  final InfoPlanetsState state;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    List<String> planetInfoList = [];
    if (state.selectedPlanet != null) {
      planetInfoList = state.selectedPlanet!
          .toJson()
          .entries
          .where((entry) =>
              entry.key != "name" &&
              entry.key != "image" &&
              entry.key != "description" &&
              entry.value != null) // Filtra las entradas
          .map((entry) {
        final key = getNameKey(entry.key);
        final value = entry.value;
        return "$key: $value"; // Formatea cada entrada
      }).toList();
    }

    return Container(
      width: width ?? context.width(.4),
      height: height ?? context.height(.9),
      padding: const EdgeInsets.all(50),
      color: colors.blue4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: planetInfoList.isEmpty
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                state.selectedPlanet?.name,
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
          const SizedBox(height: 30),
          CustomText(
            state.selectedPlanet?.description,
            fontSize: 16,
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 20),
          const CustomText(
            "Additional information",
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 20),
          if (planetInfoList.isNotEmpty) ...[
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) =>
                      CustomText(planetInfoList[index]),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                  itemCount: planetInfoList.length),
            )
          ] else ...[
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Colors.white,
                ),
                SizedBox(height: 10),
                CustomText("Loading...")
              ],
            )
          ]
        ],
      ),
    );
  }

  getNameKey(String key) {
    switch (key) {
      case "name":
        return "Name";
      case "description":
        return "Description";
      case "orbital_distance_km":
        return "Orbital distance";
      case "equatorial_radius_km":
        return "Equatorial radius";
      case "volume_km3":
        return "Volumen";
      case "mass_kg":
        return "Mass";
      case "density_g_cm3":
        return "Density";
      case "surface_gravity_m_s2":
        return "Surface gravity";
      case "escape_velocity_kmh":
        return "Escape velocity";
      case "day_length_earth_days":
        return "Day length earth days";
      case "year_length_earth_days":
        return "Year length earth days";
      case "orbital_speed_kmh":
        return "Orbital speed";
      case "atmosphere_composition":
        return "Atmosphere composition";
      case "moons":
        return "Moons";
      case "year_length_earth_years":
        return "Year length earth years";
      default:
        return key;
    }
  }
}
