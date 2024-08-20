import 'package:flutter/material.dart';
import 'package:flutter_architecture_templates/components/app_main/main_page2.dart';
import 'package:go_router/go_router.dart';

import '../../components/app_main/main_page.dart';
import '../../components/app_main/widgets/templates_detail_page.dart';
import '../../components/app_main/widgets/templates_page.dart';
import '../constants/restoration.dart';
import 'router_configs.dart';

part 'app_routers.g.dart';

///主页
@TypedStatefulShellRoute<MainShellRouteData>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<StatefulShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<HomeRouteData>(
          path: homeInMainPath,
        ),
      ],
    ),
    TypedStatefulShellBranch<StatefulShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<TheatreRouteData>(
          path: theatreInMainPath,
        ),
      ],
    ),
    TypedStatefulShellBranch<StatefulShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<MineRouteData>(
          path: mineInMainPath,
        ),
      ],
    ),
  ],
)
class MainShellRouteData extends StatefulShellRouteData {
  const MainShellRouteData();

  static const String $restorationScopeId = mainRestorationScopeId;

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return AppMainPage(
      navigationShell: navigationShell,
    );
  }
}

class HomeRouteData extends GoRouteData {
  const HomeRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TemplatesPage(
      label: 'Home page',
      bgColor: Colors.pinkAccent,
    );
  }
}

class TheatreRouteData extends GoRouteData {
  const TheatreRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TemplatesPage(
      label: 'Theatre page',
      bgColor: Colors.blueAccent,
    );
  }
}

class MineRouteData extends GoRouteData {
  const MineRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TemplatesPage(
      label: 'Mine page',
      bgColor: Colors.yellowAccent,
    );
  }
}

class Extra {
  const Extra(this.label, this.bgColor);

  final String label;

  final Color bgColor;
}

@TypedGoRoute<RequiredExtraRoute>(path: '/templates_detail')
class RequiredExtraRoute extends GoRouteData {
  const RequiredExtraRoute({required this.$extra});

  final Extra $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      TemplatesDetailPage(
        label: $extra.label,
        bgColor: $extra.bgColor,
      );
}

@TypedGoRoute<AppMainRoute>(path: appMainPagePath)
class AppMainRoute extends GoRouteData {
  const AppMainRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AppMainPage2();
  }
}
