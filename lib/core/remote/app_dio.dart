import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:native_flutter_proxy/native_proxy_reader.dart';
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

    //https://medium.com/@melkia.med.taki/how-to-use-tls-ssl-in-flutter-with-dio-15eda4f80baf
    // ByteData clientCertificate = await rootBundle.load("assets/certificates/cert.pem");
    // ByteData privateKey = await rootBundle.load("assets/certificates/Key.pem");
    // ByteData rootCACertificate = await rootBundle.load("assets/certificates/ca.pem");

    NativeProxyReader.proxySetting.then((value) => null);

    httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        // final SecurityContext sContext = SecurityContext();
        // scontext.setTrustedCertificatesBytes(rootCACertificate.buffer.asUint8List());
        // scontext.usePrivateKeyBytes(privateKey.buffer.asUint8List());
        // scontext.useCertificateChainBytes(clientCertificate.buffer.asUint8List());
        // HttpClient client = HttpClient(context: sContext);

        final client = HttpClient();
        // client.findProxy = (url) {
        //
        //
        // }

        return client;
      }
    );
  }

  static Dio getInstance() => AppDio._();
}
