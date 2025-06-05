import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/custom_toast.dart';
import '../../utils/constants.dart';
import 'data/domain/use_cases/login_user_view_model.dart';
import 'data/domain/use_cases/registration_view_model.dart';
import 'data/models/login_request.dart';
import 'data/models/registration_request.dart';

class AuthHandler {
  static void handleLogin({
    required BuildContext context,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required VoidCallback navigateToAdminPage,
    required VoidCallback navigateToHomePage,
  }) {
    final viewModel = context.read<LoginViewModel>();

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      CustomToast.showError(
        context: context,
        title: 'Please enter a valid email address',
      );
      return;
    }

    if (password.length < 6) {
      CustomToast.showError(
        context: context,
        title: 'Password must be at least 6 characters long',
      );
      return;
    }

    final request = LoginRequest(email: email, password: password);

    viewModel
        .loginUser(request)
        .then((response) {
          final responseBody = response.data as Map<String, dynamic>;

          final statusCode = responseBody['status_code'] ?? '';
          final message = responseBody['message'] ?? '';
          final data = responseBody['data'];
          print("data :-----=: $data");

          if (statusCode == "200") {
            if (Constants.isClient == 0) {
              navigateToAdminPage();
            } else {
              navigateToHomePage();
            }
            _saveUserData(data);
          } else {
            switch (message.toLowerCase()) {
              case 'user not found':
                CustomToast.showError(
                  context: context,
                  title: "User not found. Kindly register.",
                );
                break;

              case 'invalid password':
                CustomToast.showError(
                  context: context,
                  title: "Invalid Password.",
                );
                break;

              default:
                CustomToast.showError(context: context, title: message);
            }
          }
        })
        .catchError((error) {
          CustomToast.showError(
            context: context,
            title: 'An unexpected error occurred: $error',
          );
        });
  }

  static void handleRegistration({
    required BuildContext context,
    required TextEditingController nameController,
    required TextEditingController mobileController,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController confirmPasswordController,
    required VoidCallback navigateToAdminPage,
    required VoidCallback navigateToHomePage,
  }) {
    final viewModel = context.read<RegistrationViewModel>();

    final name = nameController.text.trim();
    final mobile = mobileController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (!name.contains(' ') || name.split(' ').length < 2) {
      CustomToast.showError(
        context: context,
        title: 'Please enter your full name',
      );
      return;
    }

    final mobileRegex = RegExp(r'^[5-9][0-9]{9}$');
    if (!mobileRegex.hasMatch(mobile)) {
      CustomToast.showError(
        context: context,
        title: 'Enter a valid mobile number',
      );
      return;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      CustomToast.showError(
        context: context,
        title: 'Please enter a valid email address',
      );
      return;
    }

    if (password.length < 6) {
      CustomToast.showError(
        context: context,
        title: 'Password must be at least 6 characters long',
      );
      return;
    }

    if (password != confirmPassword) {
      CustomToast.showError(context: context, title: 'Passwords do not match');
      return;
    }

    final nameParts = name.split(' ');
    final request = RegistrationRequest(
      firstname: nameParts.first,
      lastname: nameParts.sublist(1).join(' '),
      mobileNo: mobile,
      email: email,
      password: password,
    );

    viewModel
        .registerUser(request)
        .then((response) {
          final responseBody = response.data;
          if (responseBody is! Map<String, dynamic>) {
            CustomToast.showError(
              context: context,
              title: 'Unexpected response format.',
            );
            return;
          }

          final statusCode = responseBody['status_code'] ?? '';
          final message = responseBody['message'] ?? '';
          final data = responseBody['data'];

          if (statusCode == "200") {
            // On successful registration, automatically login user
            handleLogin(
              context: context,
              emailController: emailController,
              passwordController: passwordController,
              navigateToAdminPage: navigateToAdminPage,
              navigateToHomePage: navigateToHomePage,
            );
          } else {
            switch (message.toLowerCase()) {
              case 'user already register':
                CustomToast.showError(
                  context: context,
                  title: "You're already registered. Please sign in.",
                );
                break;

              case 'invalid password':
                CustomToast.showError(
                  context: context,
                  title: "Invalid Password.",
                );
                break;

              default:
                CustomToast.showError(context: context, title: message);
            }
          }
        })
        .catchError((error) {
          CustomToast.showError(
            context: context,
            title: 'An unexpected error occurred: $error',
          );
        });
  }

  static Future<void> _saveUserData(dynamic data) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(data);
    await prefs.setString('userData', jsonString);
    print("User data saved to SharedPreferences.");
  }
}
