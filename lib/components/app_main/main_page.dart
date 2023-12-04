import 'package:flutter/material.dart';
import 'package:flutter_architecture_templates/core/localization/localizations_extensions.dart';
import 'package:go_router/go_router.dart';

class AppMainPage extends StatelessWidget {
  const AppMainPage({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: context.loc.homeTabName,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite),
            label: context.loc.theatreTabName,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: context.loc.mineTabName,
          ),
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: (int index) => _onTap(context, index),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
