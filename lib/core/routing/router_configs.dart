import 'package:flutter/widgets.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app_routers.dart';

part 'router_configs.g.dart';


///首页
const homeInMainPath = '/home';

///剧场
const theatreInMainPath = '/theatre';

///我的
const mineInMainPath = '/mine';

@Riverpod(keepAlive: true)
RouteObserver appRouteObserver(AppRouteObserverRef ref) {
  return RouteObserver();
}

@Riverpod(keepAlive: true)
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    routes: $appRoutes,
    initialLocation: homeInMainPath,
    observers: [
      ref.watch(appRouteObserverProvider),
      FlutterSmartDialog.observer,
    ],
  );
}
