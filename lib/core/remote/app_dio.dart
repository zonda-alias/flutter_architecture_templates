import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../utils/constants.dart';
import 'app_manager.dart';

const _tokenHeaderName = "Authorization";

class AppDio with DioMixin implements Dio {
  AppDio._([BaseOptions? options]) {
    options = BaseOptions(
        baseUrl: '',
        contentType: 'application/json',
        connectTimeout: const Duration(milliseconds: 8000),
        sendTimeout: const Duration(milliseconds: 8000),
        receiveTimeout: const Duration(milliseconds: 8000),
        headers: <String, dynamic>{
          "Content-Type": "application/json",
          "os": AppManager.instance.netOS,
          "userDevice": AppManager.instance.userDevice,
          "appVersion": AppManager.instance.packageInfo?.version,
          "requestChannel": AppManager.instance.requestChannel
        });

    this.options = options;

    interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
      final headers = Constants.header;
      // final token = await readToken();
      // if (token?.isNotEmpty ?? false) {
      //   headers[_tokenHeaderName] = 'bearer $token';
      // }
      options.headers.addAll(headers);
      options.baseUrl = Constants.mainDomain;

      final doNotToken =
          options.headers[Constants.doNotTokenHeaderKey] ?? false;

      if (doNotToken) {
        options.headers = options.headers..remove(_tokenHeaderName)..remove(
            Constants.doNotTokenHeaderKey);
      }

      handler.next(options);
    }));

    if (!Constants.inProduction) {
      // Local Log
      interceptors.add(
          PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            responseHeader: true,
            error: true,
            compact: true,
            maxWidth: 90,
          )
      );
    }

    httpClientAdapter = HttpClientAdapter();
  }

  static Dio getInstance() => AppDio._();
}
