import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:planets_app/core/presentation/design/templates/screen_layout.dart';
import 'package:planets_app/features/planets/domain/list_planets_response.dart';
import 'package:planets_app/features/planets/presentation/planets/screens/planets_desktop_screen.dart';
import 'package:planets_app/features/planets/presentation/planets/screens/planets_mobile_screen.dart';
import 'package:planets_app/features/planets/presentation/planets/screens/planets_tablet_screen.dart';
import 'planets_controller.dart';

class PlanetsPage extends ConsumerStatefulWidget {
  const PlanetsPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PlanetsState();
}

class _PlanetsState extends ConsumerState<PlanetsPage> {
  TextEditingController tecFilter = TextEditingController();

  Future<ListPlanetsResponse>? _futurePlanets;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      _futurePlanets = ref.watch(planetsController.notifier).getListPlanets();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var controller = ref.watch(planetsController.notifier);
    var state = ref.watch(planetsController);
    return ScreenLayout(
      screenDesktop: PlanetsDesktopScreen(
        futurePlanets: _futurePlanets,
        tecFilter: tecFilter,
        controller: controller,
        state: state,
      ),
      screenTablet: PlanetsTabletScreen(
        futurePlanets: _futurePlanets,
        tecFilter: tecFilter,
        controller: controller,
        state: state,
      ),
      screenMobile: PlanetsMobileScreen(
        futurePlanets: _futurePlanets,
        tecFilter: tecFilter,
        controller: controller,
        state: state,
      ),
    );
  }
}
