// registration_request.dart
import '../../../../utils/constants.dart';

class RegistrationRequest {
  final String firstname;
  final String lastname;
  final String mobileNo;
  final String email;
  final String password;
  final int isClient;

  RegistrationRequest({
    required this.firstname,
    required this.lastname,
    required this.mobileNo,
    required this.email,
    required this.password,
    this.isClient = Constants.isClient,
  });

  Map<String, dynamic> toJson() => {
    'firstname': firstname,
    'lastname': lastname,
    'mobile': mobileNo,
    'email': email,
    'password': password,
    'isClient': isClient,
  };
}
