import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home_state.dart';

class HomeController extends StateNotifier<HomeState> {
  HomeController() : super(HomeState());

  Future<bool> toContinue() async {
    setIsLoading(true);
    await Future.delayed(const Duration(seconds: 2));
    setIsLoading(false);
    return true;
  }

  void setIsLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }
}

final homeController = StateNotifierProvider<HomeController, HomeState>((ref) {
  return HomeController();
});
