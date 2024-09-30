import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:planets_app/features/home/presentation/home/home_page.dart';
import 'package:planets_app/features/planets/presentation/info_planets/info_planets_page.dart';
import 'package:planets_app/features/planets/presentation/planet_no_found/planet_no_found_page.dart';
import 'package:planets_app/features/planets/presentation/planets/planets_page.dart';

class Routes {
  static const String home = '/home';
  static const String planets = '/planets';
  static const String informationPlanets = '/planets/:planetName';
  static const String planetNoFound = '/planet-no-found';
}

final router = GoRouter(
  initialLocation: Routes.home,
  redirect: (context, state) {
    if (state.fullPath?.isEmpty ?? false) {
      return Routes.home;
    }
    return null;
  },
  routes: [
    GoRoute(
      path: Routes.home,
      pageBuilder: (context, state) =>
          page(state: state, child: const HomePage()),
    ),
    GoRoute(
      path: Routes.planets,
      pageBuilder: (context, state) =>
          page(state: state, child: const PlanetsPage()),
    ),
    GoRoute(
      path: Routes.informationPlanets,
      pageBuilder: (context, state) {
        final planetName = state.pathParameters['planetName']!;
        return page(
          state: state,
          child: InfoPlanetsPage(planetName: planetName),
        );
      },
    ),
    GoRoute(
      path: Routes.planetNoFound,
      pageBuilder: (context, state) =>
          page(state: state, child: const PlanetNoFoundPage()),
    ),
  ],
);

NoTransitionPage<void> page({
  required GoRouterState state,
  required Widget child,
}) =>
    NoTransitionPage<void>(key: state.pageKey, child: child);
