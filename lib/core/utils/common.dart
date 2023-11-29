import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'logger_util.dart';

void launchStringForApp(String launchStr, {bool isSelf = true}) async {
  //https://github.com/flutter/flutter/issues/72515
  if (await canLaunchUrlString(launchStr)) {
    launchUrlString(
      launchStr,
      mode: LaunchMode.externalApplication,
      webOnlyWindowName: isSelf ? "_self" : "._blank",
      // webViewConfiguration: WebViewConfiguration(
      //   headers: {
      //     "token": await readToken() ?? "",
      //   },
      // ),
    );
  } else {
    logger.e("launchStringForApp launchStr is error!");
  }
}

/// 设置StatusBar、NavigationBar样式。(仅针对安卓)
void setSystemBarStyle(
    {Brightness? targetBrightness, Color? systemNavigationBarColor}) {
  if (Platform.isAndroid) {
    //https://docs.flutter.dev/release/breaking-changes/window-singleton
    final brightness = targetBrightness ??
        WidgetsBinding.instance.platformDispatcher.platformBrightness;

    final SystemUiOverlayStyle style = brightness == Brightness.dark
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark;

    logger.i("setSystemBarStyle brightness: $brightness");

    final SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      /// 透明状态栏
      statusBarColor: Colors.transparent,
      statusBarBrightness: style.statusBarBrightness,
      statusBarIconBrightness: style.statusBarIconBrightness,
      systemStatusBarContrastEnforced: style.systemStatusBarContrastEnforced,
      systemNavigationBarColor: style.systemNavigationBarColor,
      systemNavigationBarIconBrightness:
          style.systemNavigationBarIconBrightness,
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}
