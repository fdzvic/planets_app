import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planets_app/core/data/user_preferences.dart';
import 'package:planets_app/features/planets/data/planets_repository.dart';
import 'package:planets_app/features/planets/domain/list_planets_response.dart';
import 'planets_state.dart';

class PlanetsController extends StateNotifier<PlanetsState> {
  PlanetsController({required this.repository}) : super(PlanetsState());

  final PlanetsRepository repository;

  Future<ListPlanetsResponse> getListPlanets() async {
    ListPlanetsResponse response;
    if (prefs.listPlanets.isEmpty) {
      response = await repository.getListPlanets();
      prefs.listPlanets = response.toRawJson();
    } else {
      response = ListPlanetsResponse.fromJson(json.decode(prefs.listPlanets));
    }
    getFavoritePlanet();
    state = state.copyWith(
        listPlanets: response.data, filterListPlanets: response.data);
    return response;
  }

  Future<List<Planet>> filterPlanetsByName(String name) async {
    if (state.listPlanets == null || state.listPlanets!.isEmpty) {
      await getListPlanets();
    }
    List<Planet> filterListPlanets = state.listPlanets!.where((planet) {
      return planet.name!.toLowerCase().contains(name.toLowerCase());
    }).toList();

    state = state.copyWith(filterListPlanets: filterListPlanets);

    return filterListPlanets;
  }

  void getFavoritePlanet() {
    try {
      if (prefs.favoritePlanet.isNotEmpty) {
        Planet x = Planet.fromJson(json.decode(prefs.favoritePlanet));
        state = state.copyWith(favoritePlanet: x);
        print("Hay planeta favorito");
      }
    } catch (e) {
      print("Error en planeta fovorito");
    }
  }
}

final planetsController =
    StateNotifierProvider<PlanetsController, PlanetsState>((ref) {
  return PlanetsController(repository: ref.watch(planetsRepositoryProvider));
});
