import 'package:go_router/go_router.dart';

import '../../pages/main_page.dart';
import '../../pages/settings_page.dart';
import '../../pages/statistics_page.dart';

class AppRouter {
  
  static GoRouter router = GoRouter(
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
}
