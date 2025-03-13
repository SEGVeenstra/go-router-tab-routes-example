import 'package:flutter/material.dart';
import 'package:go_router_tab_routes_example/navigation/app_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => AppRouter.of(context).goToItems('grid'),
          child: const Text('Deeplink to grid'),
        ),
      ),
    );
  }
}
