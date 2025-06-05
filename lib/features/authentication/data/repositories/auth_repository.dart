import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nai_hub/common/api_response.dart';

import '../models/registration_request.dart';

class AuthRepository {
  Future<ApiResponse> register(RegistrationRequest request) async {
    const url = 'http://www.naihub.in/api/register';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(request.toJson()),
    );

    if (response.statusCode == 200) {
      print('Raw response body: ${response.body}');
      return ApiResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to register: ${response.reasonPhrase}');
    }
  }
}
