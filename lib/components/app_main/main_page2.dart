import 'package:flutter/material.dart';
import 'package:flutter_architecture_templates/components/app_main/models/app_main_entities.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'widgets/templates_page.dart';

class AppMainPage2 extends StatefulHookConsumerWidget {
  const AppMainPage2({super.key});

  @override
  ConsumerState<AppMainPage2> createState() => _AppMainPage2State();
}

class _AppMainPage2State extends ConsumerState<AppMainPage2> {
  @override
  Widget build(BuildContext context) {
    //默认使用SingleTickerProviderStateMixin
    final tabController =
        useTabController(initialLength: MainTabType.values.length);

    return Scaffold(
      body: TabBarView(
        controller: tabController,
        children: MainTabType.values
            .map((tabType) => switch (tabType) {
                  MainTabType.home => TemplatesPage(
                      label: tabType.tabName(context),
                      bgColor: Colors.redAccent,
                    ),
                  MainTabType.theatre => TemplatesPage(
                      label: tabType.tabName(context),
                      bgColor: Colors.yellowAccent,
                    ),
                  MainTabType.mine => TemplatesPage(
                      label: tabType.tabName(context),
                      bgColor: Colors.blueAccent,
                    ),
                })
            .toList(),
      ),
      bottomNavigationBar: TabBar(
          controller: tabController,
          indicatorColor: Colors.transparent,
          tabs: MainTabType.values
              .map((tabType) => switch (tabType) {
                    MainTabType.home => const Tab(icon: Icon(Icons.home)),
                    MainTabType.theatre =>
                      const Tab(icon: Icon(Icons.favorite)),
                    MainTabType.mine => const Tab(icon: Icon(Icons.settings)),
                  })
              .toList()),
    );
  }
}
