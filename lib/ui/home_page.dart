import 'package:flutter/material.dart';
import 'package:go_router_tab_routes_example/main.dart';
import 'package:go_router_tab_routes_example/navigation/app_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Text('Deeplinks into specific tabs:'),
        ),
      ),
      // NOTE: Here we create a list of deeplinks.
      // Now that GoRouter is in charge of the navigation inside the tabs we can
      // use the GoRouter to deeplink to the tabs.
      body: ListView.builder(
          itemCount: tabs.length * 2,
          itemBuilder: (context, index) => index < tabs.length
              ? ListTile(
                  title: Text('Query Param - ${tabs[index]}'),
                  onTap: () => AppRouter.of(context).goToQueryParams(tabs[index]),
                )
              : ListTile(
                  title: Text('Path Param - ${tabs[index % tabs.length]}'),
                  onTap: () => AppRouter.of(context).goToPathParams(tabs[index % tabs.length]),
                )),
    );
  }
}
