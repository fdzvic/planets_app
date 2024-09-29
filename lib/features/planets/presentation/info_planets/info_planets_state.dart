import 'package:planets_app/features/planets/domain/list_planets_response.dart';

class InfoPlanetsState {
  final List<Planet>? listPlanets;
  final Planet? selectedPlanet;
  InfoPlanetsState({
    this.listPlanets,
    this.selectedPlanet,
  });

  InfoPlanetsState copyWith({
    List<Planet>? listPlanets,
    Planet? selectedPlanet,
  }) {
    return InfoPlanetsState(
      listPlanets: listPlanets ?? this.listPlanets,
      selectedPlanet: selectedPlanet ?? this.selectedPlanet,
    );
  }
}
