import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'planet_no_found_state.dart';

class PlanetNoFoundController extends StateNotifier<PlanetNoFoundState> {
 
  PlanetNoFoundController(): super(PlanetNoFoundState());
}

final planetNoFoundController =
    StateNotifierProvider<PlanetNoFoundController, PlanetNoFoundState>(
        (ref) {
  return PlanetNoFoundController();
});