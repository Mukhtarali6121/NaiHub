// registration_viewmodel.dart

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/ApiClient.dart';
import '../../models/registration_request.dart';

class RegistrationViewModel with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<Response<dynamic>> registerUser(RegistrationRequest request) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await ApiClient.post('register', data: request.toJson());
      print("RegisterViewModel Dio full response: $response");
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
