import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shift_check/constants/constants.dart';

import 'pages/main_page.dart';
import 'pages/settings_page.dart';
import 'pages/statistics_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Settings.init(cacheProvider: SharePreferenceCache());
  initAppTheme();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final isDarkMode = ref.watch(darkModeProvider);
        return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: _router,
            title: 'Shift Check',
            theme: isDarkMode
                ? FlexThemeData.dark(
                    scheme: FlexScheme.mandyRed,
                    useMaterial3: true,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    surface: Colors.blueGrey.shade800,
                  )
                : FlexThemeData.light(
                    scheme: FlexScheme.damask,
                    useMaterial3: true,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    surface: Colors.amberAccent.shade100,
                    secondary: Colors.amber));
      },
    );
  }
}

final GoRouter _router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'home',
      path: "/",
      builder: (context, state) => MainPage(),
      routes: [
        GoRoute(
          name: 'settings',
          path: 'settings',
          builder: (context, state) => const SettingsPage(),
        ),
        GoRoute(
          name: 'statistics',
          path: 'statistics',
          builder: (context, state) => const StatisticsPage(),
        )
      ],
    )
  ],
);
