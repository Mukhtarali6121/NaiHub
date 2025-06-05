import 'package:dio/dio.dart';
import 'package:nai_hub/utils/constants.dart';

class ApiClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Constants.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 30),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  static Future<Response> post(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    return await _dio.post(path, data: data);
  }

  static Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParams,
  }) async {
    return await _dio.get(path, queryParameters: queryParams);
  }
}
