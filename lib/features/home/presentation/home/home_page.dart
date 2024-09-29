import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:planets_app/core/presentation/design/templates/screen_layout.dart';
import 'package:planets_app/features/home/presentation/home/screens/home_desktop_screen.dart';
import 'package:planets_app/features/home/presentation/home/screens/home_mobile_screen.dart';
import 'package:planets_app/features/home/presentation/home/screens/home_tablet_screen.dart';

import 'home_controller.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var controller = ref.watch(homeController.notifier);
    var state = ref.watch(homeController);
    return ScreenLayout(
      screenDesktop: HomeDesktopScreen(
        homeController: controller,
        homeState: state,
      ),
      screenTablet: HomeTabletScreen(
        homeController: controller,
        homeState: state,
      ),
      screenMobile: HomeMobileScreen(
        homeController: controller,
        homeState: state,
      ),
    );
  }
}
