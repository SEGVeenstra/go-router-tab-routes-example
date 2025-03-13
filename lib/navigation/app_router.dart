import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_tab_routes_example/main.dart';
import 'package:go_router_tab_routes_example/ui/home_page.dart';
import 'package:go_router_tab_routes_example/ui/root_page.dart';
import 'package:go_router_tab_routes_example/ui/tabbed_page.dart';

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

  void goToQueryParams(String? tab) {
    go('/query-params?tab=$tab');
  }

  void goToPathParams(String? tab) {
    go('/path-params/$tab');
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
            path: '/query-params',
            builder: (context, state) {
              final tab = state.uri.queryParameters['tab'];
              return TabbedPage(
                title: 'Query Params',
                tab: tab,
                onTabTapped: (value) => AppRouter.of(context).goToQueryParams(tabs[value]),
              );
            },
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          // IMPORTANT! This route is needed to redirect to the first tab
          // because a path with path-param is not allowed as first route!
          GoRoute(
            path: '/path-params',
            redirect: (context, state) => '/path-params/${tabs.first}',
          ),
          GoRoute(
            path: '/path-params/:tab',
            builder: (context, state) {
              final tab = state.pathParameters['tab'];
              return TabbedPage(
                title: 'Path Params',
                tab: tab,
                onTabTapped: (value) => AppRouter.of(context).goToPathParams(tabs[value]),
              );
            },
          ),
        ],
      ),
    ],
  ),
];
