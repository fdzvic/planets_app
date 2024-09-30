import 'package:planets_app/features/planets/domain/list_planets_response.dart';

class PlanetsState {
  final List<Planet>? listPlanets;
  final List<Planet>? filterListPlanets;
  final Planet? favoritePlanet;

  PlanetsState({
    this.listPlanets,
    this.filterListPlanets,
    this.favoritePlanet,
  });

  PlanetsState copyWith({
    List<Planet>? listPlanets,
    List<Planet>? filterListPlanets,
    Planet? selectedPlanet,
    Planet? favoritePlanet,
  }) {
    return PlanetsState(
      listPlanets: listPlanets ?? this.listPlanets,
      filterListPlanets: filterListPlanets ?? this.filterListPlanets,
      favoritePlanet: favoritePlanet ?? this.favoritePlanet,
    );
  }
}
