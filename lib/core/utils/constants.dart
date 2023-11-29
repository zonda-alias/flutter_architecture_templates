
class Constants {
  /// App运行在Release环境时，inProduction为true；当App运行在Debug和Profile环境时，inProduction为false
  static const bool inProduction = false; //kReleaseMode;

  static bool isDriverTest = false;
  static bool isUnitTest = false;

  ///请求头
  static final Map<String, dynamic> header = {
    "Content-type": "application/json;charset=UTF-8",
    "requestChannel": "UBQ_ANDROID",
    "appVersion": "2.3.0",
  };

  /// 0:浅色； 1:深色
  static int themeModeFlag = 1;

  static const int lightModeFlag = 0;
  static const int darkModeFlag = 1;

  /// -1:跟随系统, 0浅色模式, 1: 深色模式
  static int themeSettingsFlag = 1;

  static const int lightSettingsFlag = 0;
  static const int darkSettingsFlag = 1;
  static const int systemSettingsFlag = -1;

  // API 地址配置
  static const String mainDomain = '';

  /// 接口请求异常通用提示文案(当接口没有返回错误信息时使用)
  static const apiErrorMsg = "接口请求失败，请稍后重试~";

  static const hiveDBName = "UBQ_Settings_DB";

  static const messageCenterIgnoreTipKey = "messageCenterIgnoreTipKey";
  static const messageCenterIgnoreFlag = 1;
  static const messageCenterNotIgnoreFlag = 0;

  static const beiKangActivityKey = "BK20230301";

  static const userInfoStorageKey = "baKenUseInfo"; // 用户信息
  static const userTokenStorageKey = "pro__token"; // token

  static const doNotTokenHeaderKey = "client-doNotTokenHeader";

  static bool isConnected = false;

  static String userAgreementH5 = "https://static.cc-jbl.com/UserAgreement.html";

  static String privacyPolicyH5 = "https://static.cc-jbl.com/PrivacyPolicy.html";
}
