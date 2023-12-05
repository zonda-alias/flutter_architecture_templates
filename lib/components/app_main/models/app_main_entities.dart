import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_templates/core/localization/localizations_extensions.dart';

enum MainTabType {
  home,
  theatre,
  mine;
}

extension MainTabTypeMixin on MainTabType {

  String tabName(BuildContext context) => switch (this) {
        MainTabType.home => context.loc.homeTabName,
        MainTabType.theatre => context.loc.theatreTabName,
        MainTabType.mine => context.loc.mineTabName,
      };


}
