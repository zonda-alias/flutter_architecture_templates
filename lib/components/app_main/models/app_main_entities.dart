import 'package:flutter/material.dart';
import 'package:flutter_architecture_templates/core/localization/localizations_extensions.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_main_entities.freezed.dart';

const defaultMainTabType = MainTabType.home;

@freezed
sealed class SelectedTabData with _$SelectedTabData {
  factory SelectedTabData.home() = HomeTabExtra;

  factory SelectedTabData.waybill() = WaybillTabExtra;

  factory SelectedTabData.mine() = MineTabExtra;
}

enum MainTabType {
  home,
  waybill,
  mine;
}

extension MainTabTypeMixin on MainTabType {
  String tabName(BuildContext context) => switch (this) {
        MainTabType.home => context.loc.homeTabName,
        MainTabType.waybill => context.loc.waybillTabName,
        MainTabType.mine => context.loc.mineTabName,
      };

  Widget tabIcon(bool isSelected) => switch (this) {
        MainTabType.home => isSelected
            ? const Icon(Icons.home, color: Colors.greenAccent)
            : const Icon(Icons.home),
        MainTabType.waybill => isSelected
            ? const Icon(Icons.favorite, color: Colors.greenAccent)
            : const Icon(Icons.favorite),
        MainTabType.mine => isSelected
            ? const Icon(Icons.settings, color: Colors.greenAccent)
            : const Icon(Icons.settings),
      };
}

extension SelectedTabDataExt on SelectedTabData? {
  int get selectedTabIndex => switch (this) {
        HomeTabExtra() => MainTabType.values.indexOf(MainTabType.home),
        WaybillTabExtra() => MainTabType.values.indexOf(MainTabType.waybill),
        MineTabExtra() => MainTabType.values.indexOf(MainTabType.mine),
        _ => MainTabType.values.indexOf(defaultMainTabType),
      };
}

extension MainTabIndexExt on int? {
  MainTabType get mainTabType {
    if (this case int index) {
      try {
        return MainTabType.values[index];
      } catch (e) {
        return defaultMainTabType;
      }
    } else {
      return defaultMainTabType;
    }
  }
}

SelectedTabData newTabDataInstance({final int? tabIndex}) =>
    switch (tabIndex.mainTabType) {
      MainTabType.home => SelectedTabData.home(),
      MainTabType.waybill => SelectedTabData.waybill(),
      MainTabType.mine => SelectedTabData.mine(),
    };
