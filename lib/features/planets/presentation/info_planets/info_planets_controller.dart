import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planets_app/core/data/user_preferences.dart';
import 'package:planets_app/features/planets/domain/list_planets_response.dart';
import 'info_planets_state.dart';

class InfoPlanetsController extends StateNotifier<InfoPlanetsState> {
  InfoPlanetsController() : super(InfoPlanetsState());
  Future<bool> initData(String planetName) async {
    try {
      ListPlanetsResponse response =
          ListPlanetsResponse.fromJson(json.decode(prefs.listPlanets));
      Planet? selectedPlanet = response.data!.firstWhere(
          (planet) => planet.name!.toLowerCase() == planetName.toLowerCase());
      state = state.copyWith(
          listPlanets: response.data, selectedPlanet: selectedPlanet);
      getFavoditePlanet();
      return true;
    } catch (e) {
      print("sucedio un error");
      return false;
    }
  }

  void getFavoditePlanet() {
    if (prefs.favoritePlanet.isNotEmpty) {
      Planet favoritePlanet =
          Planet.fromJson(json.decode(prefs.favoritePlanet));
      setFavoritePlanet(favoritePlanet.name!.toLowerCase() ==
          state.selectedPlanet!.name!.toLowerCase());
    } else {
      setFavoritePlanet(false);
    }
  }

  void setFavoritePlanet(bool value) {
    state = state.copyWith(isFavoritePlanet: value);
  }
}

final infoPlanetsController =
    StateNotifierProvider<InfoPlanetsController, InfoPlanetsState>((ref) {
  return InfoPlanetsController();
});
