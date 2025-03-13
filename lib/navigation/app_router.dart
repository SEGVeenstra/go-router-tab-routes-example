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

  // NOTE: Below are some helper functions to navigate to different pages.
  // It's just personal preference to have these functions in the router.
  // You can also call `go('/path')` directly.
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
        // NOTE: This is the way to change between branches in the StatefulShellRoute
        // when you want to go to the page you we're on the last time you were on this branch.
        navigationShell.goBranch(index);
      },
    ),
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            name: 'HomePage',
            path: '/',
            builder: (context, state) => const HomePage(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            name: 'TabbedPage (Query Params)',
            path: '/query-params',
            builder: (context, state) {
              // NOTE: Here we're getting the 'tab' query parameter from the URI which we
              // then pass to the TabbedPage to show the correct tab.
              final tab = state.uri.queryParameters['tab'];
              return TabbedPage(
                title: 'Query Params',
                tab: tab,
                // NOTE: onTabChanged is called  by TabbedPage when a tab is changed by
                // either tapping the tabbar or swiping the TabBarView.
                // We use this callback to tell GoRouter the navigation changed.
                // Because we're still on the same page, you won't see any visual change,
                // but the URL will be updated and the listener on the RouterDelegate will be triggered.
                onTabChanged: (value) => AppRouter.of(context).goToQueryParams(tabs[value]),
              );
            },
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          // NOTE: This route is needed to redirect to the first tab
          // because a path with path-param is not allowed as first route!
          GoRoute(
            path: '/path-params',
            redirect: (context, state) => '/path-params/${tabs.first}',
          ),
          // NOTE: Other than that, this basically works the same as the query-params route
          GoRoute(
            name: 'TabbedPage (Path Params)',
            path: '/path-params/:tab',
            builder: (context, state) {
              final tab = state.pathParameters['tab'];
              return TabbedPage(
                title: 'Path Params',
                tab: tab,
                onTabChanged: (value) => AppRouter.of(context).goToPathParams(tabs[value]),
              );
            },
          ),
        ],
      ),
    ],
  ),
];
