import 'package:flutter/material.dart';

class TabContent extends StatelessWidget {
  const TabContent({
    super.key,
    required this.tabName,
  });

  final String tabName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Tab: $tabName',
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
    );
  }
}
