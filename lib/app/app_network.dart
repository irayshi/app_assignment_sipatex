import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AppNetwork {
  final Dio dio;
  AppNetwork({Dio? dio})
    : dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: BaseUrl.fakestoreapi,
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
            ),
          ) {
    this.dio.interceptors.add(
      PrettyDioLogger(requestBody: true, responseBody: true, compact: true),
    );
  }
}

abstract class BaseUrl {
  static const dummyjson = 'https://dummyjson.com';
  static const jsonplaceholder = 'https://jsonplaceholder.typicode.com';
  static const fakestoreapi = 'https://fakestoreapi.com';
}
