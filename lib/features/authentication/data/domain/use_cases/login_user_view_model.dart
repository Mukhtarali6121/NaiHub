import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nai_hub/utils/ApiClient.dart';

import '../../models/login_request.dart';

class LoginViewModel with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<Response<dynamic>> loginUser(LoginRequest request) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await ApiClient.post('login', data: request.toJson());
      print("LoginViewModel Dio full response: $response");
      return response; // Return full raw response here
    } on DioException catch (e) {
      String errorMessage = e.response?.data['message'] ?? e.message;
      print("DioException: $errorMessage");

      return e.response!; // Return the error response
    } catch (e) {
      print("Generic Exception: $e");
      // Similarly, throw or handle error as you see fit
      throw e;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
