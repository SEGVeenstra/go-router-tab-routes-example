import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppAnalytics {
  AppAnalytics._(this.router);

  factory AppAnalytics() => _instance!;

  static AppAnalytics? _instance;
  final GoRouter router;

  static void init(GoRouter router) {
    _instance = AppAnalytics._(router);
  }

  void logPageView() {
    final uri = router.state.uri;

    debugPrint('[ANALYTICS] Path: $uri');
    debugPrint('[ANALYTICS] Page Name: ${router.routerDelegate.currentConfiguration.last.route.name}');
  }
}
