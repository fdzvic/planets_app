import 'package:planets_app/features/planets/domain/list_planets_response.dart';

class PlanetsState {
  final List<Planet>? listPlanets;
  final List<Planet>? filterListPlanets;

  PlanetsState({
    this.listPlanets,
    this.filterListPlanets,
  });

  PlanetsState copyWith({
    List<Planet>? listPlanets,
    List<Planet>? filterListPlanets,
    Planet? selectedPlanet,
  }) {
    return PlanetsState(
      listPlanets: listPlanets ?? this.listPlanets,
      filterListPlanets: filterListPlanets ?? this.filterListPlanets,
    );
  }
}
