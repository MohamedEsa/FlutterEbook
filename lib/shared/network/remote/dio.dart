import 'package:dio/dio.dart';

class DioHelper {
  String apiKey = '';

  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://catalog.feedbooks.com/',
        receiveDataWhenStatusError: true,
      ),
    );
    dio.options.headers = {
      'Content-Type': 'application/json',
      "Access-Control-Allow-Origin": "*", // Required for CORS support to work
      "Access-Control-Allow-Credentials":
          true, // Required for cookies, authorization headers with HTTPS
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS"
    };
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('REQUEST:: ${options.uri} and Body::${options.data}');
          handler.next(options);
        },
        onResponse: (response, handler) {
          print(
              'RESPONSE:: Status code is: ${response.statusCode} response is: ${response.data}');
          handler.next(response);
        },
        onError: (e, handler) {
          print('ERROR::$e');
          handler.next(e);
        },
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    return await dio.get(url, queryParameters: query);
  }
}
