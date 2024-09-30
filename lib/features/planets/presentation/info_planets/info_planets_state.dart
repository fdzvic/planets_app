import 'package:planets_app/features/planets/domain/list_planets_response.dart';

class InfoPlanetsState {
  final List<Planet>? listPlanets;
  final Planet? selectedPlanet;
  final bool? isFavoritePlanet;
  InfoPlanetsState({
    this.listPlanets,
    this.selectedPlanet,
    this.isFavoritePlanet = false,
  });

  InfoPlanetsState copyWith({
    List<Planet>? listPlanets,
    Planet? selectedPlanet,
    bool? isFavoritePlanet,
  }) {
    return InfoPlanetsState(
      listPlanets: listPlanets ?? this.listPlanets,
      selectedPlanet: selectedPlanet ?? this.selectedPlanet,
      isFavoritePlanet: isFavoritePlanet ?? this.isFavoritePlanet,
    );
  }
}
