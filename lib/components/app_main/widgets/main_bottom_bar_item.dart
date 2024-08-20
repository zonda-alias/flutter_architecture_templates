import 'package:flutter/material.dart';

import '../models/app_main_entities.dart';

class MainBottomBarItem extends StatelessWidget {
  const MainBottomBarItem({
    super.key,
    required this.tabType,
    this.isSelected = false,
  });

  final MainTabType tabType;

  final bool isSelected;

  //height: kBottomNavigationBarHeight
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          tabType.tabIcon(isSelected),
          const SizedBox(height: 2),
          Text(
            tabType.tabName(context),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: isSelected ? Colors.black : const Color(0xFF929292),
            ),
          )
        ],
      ),
    );
  }
}
