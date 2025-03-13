import 'package:flutter/material.dart';

class RootPage extends StatelessWidget {
  const RootPage({
    super.key,
    required this.child,
    required this.tabIndex,
    required this.onTabTapped,
  });

  final Widget child;
  final int tabIndex;
  final void Function(int index) onTabTapped;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabIndex,
        onTap: onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.query_stats),
            label: 'Query',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.route),
            label: 'Path',
          ),
        ],
      ),
    );
  }
}
