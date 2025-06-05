// Login_request.dart
import '../../../../utils/constants.dart';

class LoginRequest {
  final String email;
  final String password;
  final int isClient;

  LoginRequest({
    required this.email,
    required this.password,
    this.isClient = Constants.isClient,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'isClient': isClient,
  };
}
