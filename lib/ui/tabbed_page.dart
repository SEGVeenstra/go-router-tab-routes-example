import 'package:flutter/material.dart';
import 'package:go_router_tab_routes_example/main.dart';
import 'package:go_router_tab_routes_example/ui/tab_content.dart';

class TabbedPage extends StatefulWidget {
  const TabbedPage({
    super.key,
    required this.title,
    required this.tab,
    required this.onTabTapped,
  });

  final String title;
  final String? tab;
  final void Function(int tabIndex) onTabTapped;

  @override
  State<TabbedPage> createState() => _TabbedPageState();
}

class _TabbedPageState extends State<TabbedPage> with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: tabs.length, vsync: this);

  @override
  void initState() {
    super.initState();

    _tabController.index = (tabs.indexOf(widget.tab ?? tabs.first));
  }

  @override
  void didUpdateWidget(covariant TabbedPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    _tabController.index = (tabs.indexOf(widget.tab ?? tabs.first));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: TabBar(
          controller: _tabController,
          onTap: widget.onTabTapped,
          tabs: [
            for (final tab in tabs) Tab(text: tab),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          for (final tab in tabs) TabContent(tabName: tab),
        ],
      ),
    );
  }
}
