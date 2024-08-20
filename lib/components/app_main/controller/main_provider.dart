import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/app_main_entities.dart';

part 'main_provider.g.dart';

@riverpod
class SelectedTabIndexState extends _$SelectedTabIndexState {
  @override
  SelectedTabData? build() {
    return null;
  }

  void setTabIndex(int tabIndex) {
    if (state?.selectedTabIndex != tabIndex) {
      state = newTabDataInstance(tabIndex: tabIndex);
    }
  }
}

@riverpod
class OnTabSelectedState extends _$OnTabSelectedState {
  @override
  int build() {
    return -1;
  }

  void setTabIndex(int tabIndex) {
    if (state != tabIndex) {
      state = min(MainTabType.values.length - 1, max(0, tabIndex));
    }
  }
}

@riverpod
class OnTabUnselectedState extends _$OnTabUnselectedState {
  @override
  int build() {
    return -1;
  }

  void setTabIndex(int tabIndex) {
    if (state != tabIndex) {
      state = min(MainTabType.values.length - 1, max(0, tabIndex));
    }
  }
}

@riverpod
class OnTabReselectedState extends _$OnTabReselectedState {
  @override
  int build() {
    return -1;
  }

  void setTabIndex(int tabIndex) {
    if (state != tabIndex) {
      state = min(MainTabType.values.length - 1, max(0, tabIndex));
    }
  }
}
