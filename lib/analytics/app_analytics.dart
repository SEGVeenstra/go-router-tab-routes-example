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
    Future.delayed(Duration.zero, () => print('Page view: $uri'));
  }
}
