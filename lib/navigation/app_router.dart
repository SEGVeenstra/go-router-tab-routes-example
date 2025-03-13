import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_tab_routes_example/ui/home_page.dart';
import 'package:go_router_tab_routes_example/ui/items_page.dart';
import 'package:go_router_tab_routes_example/ui/root_page.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter extends GoRouter {
  AppRouter()
      : super.routingConfig(
          initialLocation: '/',
          navigatorKey: rootNavigatorKey,
          routingConfig: ValueNotifier(
            RoutingConfig(routes: _routes),
          ),
        );

  void goToHome() {
    go('/');
  }

  void goToItems(String? tab) {
    go('/items?tab=$tab');
  }

  static AppRouter of(BuildContext context) {
    return GoRouter.of(context) as AppRouter;
  }
}

final _routes = [
  StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) => RootPage(
      tabIndex: navigationShell.currentIndex,
      child: navigationShell,
      onTabTapped: (index) {
        navigationShell.goBranch(index);
      },
    ),
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const HomePage(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '/items',
            builder: (context, state) {
              final tab = state.uri.queryParameters['tab'];
              return ItemsPage(
                tab: tab,
              );
            },
          ),
        ],
      ),
    ],
  ),
];
