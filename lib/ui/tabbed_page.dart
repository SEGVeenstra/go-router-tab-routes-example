import 'package:flutter/material.dart';
import 'package:go_router_tab_routes_example/main.dart';
import 'package:go_router_tab_routes_example/ui/tab_content.dart';

class TabbedPage extends StatefulWidget {
  const TabbedPage({
    super.key,
    required this.title,
    required this.tab,
    required this.onTabChanged,
  });

  final String title;

  // NOTE: This is the tab that is currently selected.
  final String? tab;

  // NOTE: This is the callback that is called when a tab is tapped.
  final void Function(int tabIndex) onTabChanged;

  @override
  State<TabbedPage> createState() => _TabbedPageState();
}

class _TabbedPageState extends State<TabbedPage> with SingleTickerProviderStateMixin {
  // NOTE: We create a TabController so we have more control over the tabs then when we would
  // have if we would use the DefaultTabController widget.
  late final _tabController = TabController(length: tabs.length, vsync: this);

  @override
  void initState() {
    super.initState();

    _tabController.index = (tabs.indexOf(widget.tab ?? tabs.first));

    // NOTE: We add a listener to the controller in which we trigger the callback that was passed
    // to the widget.
    _tabController.addListener(
      () {
        if (_tabController.index != _tabController.previousIndex) {
          widget.onTabChanged(_tabController.index);
        }
      },
    );
  }

  // NOTE: When the widget is update with the new tab by GoRouter, we need to reflect that
  // in the TabController.
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
