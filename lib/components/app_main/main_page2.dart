import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_templates/components/app_main/models/app_main_entities.dart';
import 'package:flutter_lazy_indexed_stack/flutter_lazy_indexed_stack.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'controller/main_provider.dart';
import 'widgets/main_bottom_bar_item.dart';
import 'widgets/templates_page.dart';

class AppMainPage2 extends StatefulHookConsumerWidget {
  const AppMainPage2({super.key});

  @override
  ConsumerState<AppMainPage2> createState() => _AppMainPage2State();
}

class _AppMainPage2State extends ConsumerState<AppMainPage2> {
  @override
  Widget build(BuildContext context) {
    final selectedTabData = ref.watch(selectedTabIndexStateProvider);

    final selectedIndex =
        selectedTabData?.selectedTabIndex ?? defaultMainTabType.index;

    return Scaffold(
      bottomNavigationBar: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Color(0xFFEBEBEB), width: 0.5),
          ),
        ),
        child: BottomNavigationBar(
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          currentIndex: selectedIndex,
          onTap: (int index) {
            _onTabChange(index);
          },
          items: [
            ...MainTabType.values.mapIndexed(
              (index, tabType) => BottomNavigationBarItem(
                icon: MainBottomBarItem(
                  tabType: tabType,
                  isSelected: index == selectedIndex,
                ),
                label: '',
              ),
            )
          ],
        ),
      ),
      body: LazyIndexedStack(
        index: selectedIndex,
        children: [
          ...MainTabType.values.map(
            (tabType) => switch (tabType) {
              MainTabType.home => TemplatesPage(
                  label: tabType.tabName(context),
                  bgColor: Colors.blueAccent,
                ),
              MainTabType.waybill => TemplatesPage(
                  label: tabType.tabName(context),
                  bgColor: Colors.redAccent,
                ),
              MainTabType.mine => TemplatesPage(
                  label: tabType.tabName(context),
                  bgColor: Colors.greenAccent,
                ),
            },
          ),
        ],
      ),
    );
  }

  void _onTabChange(int index) {
    final selectedTabData = ref.read(selectedTabIndexStateProvider);
    final checkedSelectedIndex =
        selectedTabData?.selectedTabIndex ?? defaultMainTabType.index;
    if (checkedSelectedIndex == index) {
      ref.read(onTabReselectedStateProvider.notifier).setTabIndex(index);
      return;
    }

    if (checkedSelectedIndex != index) {
      ref
          .read(onTabUnselectedStateProvider.notifier)
          .setTabIndex(checkedSelectedIndex);
      ref.read(onTabSelectedStateProvider.notifier).setTabIndex(index);
    }

    // if (MainTabType.values[index] == MainTabType.assetTab) {
    //   takeIfLogin((isLogin) {
    //     if (isLogin) {
    //       ref.read(selectedTabIndexStateProvider.notifier).setTabIndex(index);
    //     } else {
    //       SendMessageToNativeApi().openNative(openNativeLoginPage, {});
    //     }
    //   });
    //   return;
    // }

    ref.read(selectedTabIndexStateProvider.notifier).setTabIndex(index);
  }
}
