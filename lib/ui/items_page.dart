import 'package:flutter/material.dart';
import 'package:go_router_tab_routes_example/main.dart';
import 'package:go_router_tab_routes_example/navigation/app_router.dart';
import 'package:go_router_tab_routes_example/ui/content_tab.dart';

class ItemsPage extends StatefulWidget {
  const ItemsPage({
    super.key,
    required this.tab,
  });

  final String? tab;

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: tabs.length, vsync: this);

  @override
  void didUpdateWidget(covariant ItemsPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    _tabController.animateTo(tabs.indexOf(widget.tab ?? tabs.first));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Items'),
        bottom: TabBar(
          controller: _tabController,
          onTap: (value) => AppRouter.of(context).goToItems(tabs[value]),
          tabs: [
            for (final tab in tabs) Tab(text: tab),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          for (final tab in tabs) ContentTab(tabName: tab),
        ],
      ),
    );
  }
}
