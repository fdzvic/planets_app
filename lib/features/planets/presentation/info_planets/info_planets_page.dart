import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:planets_app/core/presentation/design/templates/screen_layout.dart';
import 'package:planets_app/core/presentation/utils/routes.dart';
import 'package:planets_app/features/planets/presentation/info_planets/info_planets_controller.dart';
import 'package:planets_app/features/planets/presentation/info_planets/screen/info_planets_desktop_screen.dart';
import 'package:planets_app/features/planets/presentation/info_planets/screen/info_planets_mobile_screen.dart';
import 'package:planets_app/features/planets/presentation/info_planets/screen/info_planets_tablet_screen.dart';

class InfoPlanetsPage extends ConsumerStatefulWidget {
  final String planetName;
  const InfoPlanetsPage({
    super.key,
    required this.planetName,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InfoPlanetsState();
}

class _InfoPlanetsState extends ConsumerState<InfoPlanetsPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async => initData(context));
    super.initState();
  }

  Future<void> initData(BuildContext context) async {
    bool success = await ref
        .watch(infoPlanetsController.notifier)
        .initData(widget.planetName);
    if (!success) {
      if (!context.mounted) return;
      context.go(Routes.planetNoFound);
    }
  }

  @override
  Widget build(BuildContext context) {
    var controller = ref.watch(infoPlanetsController.notifier);
    var state = ref.watch(infoPlanetsController);
    return ScreenLayout(
      screenDesktop:
          InfoPlanetsDesktopScreen(state: state, controller: controller),
      screenTablet:
          InfoPlanetsTabletScreen(state: state, controller: controller),
      screenMobile:
          InfoPlanetsMobileScreen(state: state, controller: controller),
    );
  }
}
