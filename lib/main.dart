import 'package:flutter/material.dart';
import 'package:go_router_tab_routes_example/analytics/app_analytics.dart';
import 'package:go_router_tab_routes_example/app.dart';
import 'package:go_router_tab_routes_example/navigation/app_router.dart';

final tabs = ['Tab 1', 'Tab 2', 'Tab 3'];

void main() {
  final router = AppRouter();
  AppAnalytics.init(router);

  router.routerDelegate.addListener(
    () {
      AppAnalytics().logPageView();
    },
  );

  runApp(
    App(
      router: router,
    ),
  );
}
