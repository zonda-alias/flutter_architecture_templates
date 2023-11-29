import 'dart:io' show Platform;

import 'package:package_info_plus/package_info_plus.dart';

/// App 信息获取
class AppManager {
  static final AppManager _appManager = AppManager._internal();

  static AppManager get instance => _appManager;

  PackageInfo? packageInfo;

  AppManager._internal() {
    PackageInfo.fromPlatform().then((value) => {packageInfo = value});
  }

  String get requestChannel {
    if (Platform.isAndroid) {
      return "UBQ_ANDROID";
    }
    if (Platform.isIOS) {
      return "UBQ_IOS";
    }
    return "";
  }

  String get userDevice {
    if (Platform.isAndroid) {
      return "Android";
    }
    if (Platform.isIOS) {
      return "iOS";
    }
    return "";
  }

  String get netOS {
    if (Platform.isAndroid) {
      return "Android";
    }
    if (Platform.isIOS) {
      return "IOS";
    }
    return "";
  }
}
