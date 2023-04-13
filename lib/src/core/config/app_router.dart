import 'package:go_router/go_router.dart';
import 'package:shift_check/src/features/history/domain/models/month_summary.dart';
import 'package:shift_check/src/features/history/presentation/pages/history_detail_page.dart';

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
              routes: [
                GoRoute(
                  name: 'history-detail',
                  path: 'history-detail',
                  builder: (context, state) => HistoryDetailPage(
                    summary: state.extra! as MonthSummary,
                  ),
                ),
              ]),
        ],
      )
    ],
  );
}
