import 'package:go_router/go_router.dart';

import '../../features/history/presentation/pages/history_page.dart';
import '../../features/shifts/presentation/pages/main_page.dart';
import '../../features/menu/presentation/pages/settings_page.dart';
import '../../features/menu/presentation/pages/statistics_page.dart';

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
          ),
          GoRoute(
            name: 'history',
            path: 'history',
            builder: (context, state) => const HistoryPage(),
          ),
        ],
      )
    ],
  );
}
