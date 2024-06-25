import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '/core/network/api_constance.dart';

class DioLogger {
  static Dio getDio() {
    Dio dio = Dio();

    dio.options.baseUrl = ApiConstance.baseUrl;

    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Basic QVBQOjl2Q2chaE0yJFliTg==',
    };
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        request: true,
        compact: true,
        error: true,
        responseHeader: true,
        logPrint: (object) {
          debugPrint(object.toString());
        },
      ),
    );
    return dio;
  }
}
