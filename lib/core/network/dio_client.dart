import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:math/core/network/check_token_interceptor.dart';

class DioClient {
  late final Dio _dio;

  DioClient({CheckTokenInterceptor? checkTokenInterceptor})
    : _dio = Dio(
        BaseOptions(
          baseUrl: dotenv.get('BASE_URL'),
          headers: {'Accept': 'application/json'},
          responseType: ResponseType.json,
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      ) {
    if (checkTokenInterceptor != null) {
      _dio.interceptors.add(checkTokenInterceptor);
    }
  }

  void addInterceptor(CheckTokenInterceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }

  // POST
  Future<Response> post({
    required String url,
    dynamic data,
    Options? options,
  }) async {
    try {
      final res = await _dio.post(url, data: data, options: options);
      return res;
    } on DioException {
      rethrow;
    }
  }

  // PUT
  Future<Response> put({
    required String url,
    Map<String, dynamic>? data,
  }) async {
    try {
      final res = await _dio.put(url, data: data);
      return res;
    } on DioException {
      rethrow;
    }
  }

  // GET
  Future<Response> get({required String url}) async {
    try {
      final res = await _dio.get(url);
      return res;
    } on DioException {
      rethrow;
    }
  }

  //DELETE
  Future<Response> delete({
    required String url,
    Map<String, dynamic>? data,
    Options? options,
  }) async {
    try {
      final res = await _dio.delete(url, data: data, options: options);
      return res;
    } on DioException {
      rethrow;
    }
  }
}
