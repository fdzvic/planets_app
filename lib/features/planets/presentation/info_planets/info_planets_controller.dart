import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planets_app/core/presentation/utils/user_preferences.dart';
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
      return true;
    } catch (e) {
      print("sucedio un error");
      return false;
    }
  }
}

final infoPlanetsController =
    StateNotifierProvider<InfoPlanetsController, InfoPlanetsState>((ref) {
  return InfoPlanetsController();
});
