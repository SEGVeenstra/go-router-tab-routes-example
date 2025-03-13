import 'package:flutter/material.dart';
import 'package:go_router_tab_routes_example/analytics/app_analytics.dart';
import 'package:go_router_tab_routes_example/app.dart';
import 'package:go_router_tab_routes_example/navigation/app_router.dart';

// NOTE: This is a list of tabs that will dynamically create the tabs and content.
// This is just to show that you can have a dynamic amount of tabs.
final tabs = ['Tab1', 'Tab2', 'Tab3', 'Tab4'];

void main() {
  final router = AppRouter();
  AppAnalytics.init(router);

  // NOTE: You can add a listener to the [GoRouterDelegate] to get notified
  // whenever the route changes.
  router.routerDelegate.addListener(
    () => AppAnalytics().logPageView(),
  );

  runApp(
    App(
      router: router,
    ),
  );
}
