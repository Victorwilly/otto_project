import '../core/guards/app_guard.dart';
import '../shared/models/models.dart';

List<RouteOption> routeOpts = <RouteOption>[
  RouteOption(
    path: '**',
    redirectTo: AppGuard.route,
  ),
];

class AppRouter {
  AppRouter();
}
