import 'package:flutter/material.dart';
import 'package:planets_app/core/presentation/design/atoms/custom_text.dart';
import 'package:planets_app/core/presentation/design/tokens/colors.dart';
import 'package:planets_app/core/presentation/utils/dimens_extension.dart';
import 'package:planets_app/features/planets/presentation/info_planets/info_planets_state.dart';

class CardInformationPlanet extends StatelessWidget {
  const CardInformationPlanet({
    super.key,
    required this.state,
  });

  final InfoPlanetsState state;

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
      width: context.width(.4),
      height: context.height(.9),
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
            "Información adicional",
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
                CustomText("Cargando")
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
        return "Nombre";
      case "description":
        return "Descripción";
      case "orbital_distance_km":
        return "Distancia orbital";
      case "equatorial_radius_km":
        return "Radio ecuatorial";
      case "volume_km3":
        return "Volumen";
      case "mass_kg":
        return "Masa";
      case "density_g_cm3":
        return "Densidad";
      case "surface_gravity_m_s2":
        return "Gravedad superficial";
      case "escape_velocity_kmh":
        return "Velocidad de escape";
      case "day_length_earth_days":
        return "Duración del día en dias tierra";
      case "year_length_earth_days":
        return "Duración del año en dias tierra";
      case "orbital_speed_kmh":
        return "Velocidad orbital";
      case "atmosphere_composition":
        return "Composición atmosferica";
      case "moons":
        return "Lunas";
      case "year_length_earth_years":
        return "Duración del año en años tierra";
      default:
        return key;
    }
  }
}
