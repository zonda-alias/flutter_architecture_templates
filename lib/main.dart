import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_templates/core/constants/restoration.dart';
import 'package:flutter_architecture_templates/core/localization/localizations_extensions.dart';
import 'package:flutter_architecture_templates/core/remote/test_http_proxy_overrides.dart';
import 'package:flutter_architecture_templates/core/routing/router_configs.dart';
import 'package:flutter_architecture_templates/core/utils/logger_util.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:native_flutter_proxy/custom_proxy.dart';
import 'package:native_flutter_proxy/native_proxy_reader.dart';

import 'core/utils/common.dart';

void main() async {
  CustomFlutterBinding();

  WidgetsFlutterBinding.ensureInitialized();
  await setUpProxyIfNeed();
  setSystemBarStyle(targetBrightness: Brightness.dark);
  runApp(const ProviderScope(child: MyApp()));
}

class CustomFlutterBinding extends WidgetsFlutterBinding {}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      restorationScopeId: appRestorationScopeId,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (BuildContext context) => context.loc.appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          //surfaceVariant: Colors.transparent,
        ),
        useMaterial3: true,
      ),
      routeInformationProvider:
          ref.watch(appRouterProvider).routeInformationProvider,
      routeInformationParser:
          ref.watch(appRouterProvider).routeInformationParser,
      routerDelegate: ref.watch(appRouterProvider).routerDelegate,
      builder: FlutterSmartDialog.init(),
    );
  }
}
