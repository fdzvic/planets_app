import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:planets_app/core/presentation/design/tokens/theme.dart' as t;
import 'package:planets_app/core/presentation/utils/routes.dart';
import 'package:responsive_builder/responsive_builder.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveApp(
      builder: (context) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'planets_app',
        themeMode: ThemeMode.light,
        theme: t.Theme().theme,
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
        routeInformationProvider: router.routeInformationProvider,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('es'),
          Locale('en'),
        ],
      ),
    );
  }
}
