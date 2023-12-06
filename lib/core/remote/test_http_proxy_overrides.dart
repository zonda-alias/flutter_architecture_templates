import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:native_flutter_proxy/custom_proxy.dart';
import 'package:native_flutter_proxy/native_proxy_reader.dart';

import '../utils/logger_util.dart';

Future<void> setUpProxyIfNeed() async {
  if (kReleaseMode) {
    return;
  }

  NativeProxyReader.proxySetting.then((settings) {
    final proxyHost = settings.host;
    logger.i('message proxySetting:${settings.host}:${settings.port}');
    if (proxyHost != null && settings.enabled) {
      HttpOverrides.global = TestHttpProxyOverrides.withProxy(
        CustomProxy(ipAddress: proxyHost, port: settings.port).toString(),
        allowBadCertificates: true,
      );
    }
  }).catchError((onError) {
    logger.e('message onError ---> $onError ');
  });
}

class TestHttpProxyOverrides extends HttpOverrides {
  /// The entire proxy server
  /// Format: "localhost:8888"
  final String proxyString;

  /// Set this to true
  /// - Warning: Setting this to true in production apps can be dangerous. Use with care!
  final bool allowBadCertificates;

  /// Initializer
  TestHttpProxyOverrides.withProxy(
    this.proxyString, {
    this.allowBadCertificates = false,
  });

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return (super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => allowBadCertificates)
      ..findProxy = (url) => 'PROXY $proxyString; DIRECT';
  }
}
