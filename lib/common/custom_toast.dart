import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class CustomToast {
  /// Show a success toast
  static void showSuccess({
    required BuildContext context,
    String title = 'Success!',
    Duration duration = const Duration(seconds: 3),
    Alignment alignment = Alignment.bottomCenter,
  }) {
    toastification.show(
      context: context,
      type: ToastificationType.success,
      autoCloseDuration: duration,
      title: Text(title),
      description: null,
      primaryColor: Colors.white,
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
      alignment: alignment,
      showIcon: true,
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 16,
          offset: Offset(0, 16),
          spreadRadius: 0,
        ),
      ],
      dragToClose: true,
    );
  }

  /// Show an error toast
  static void showError({
    required BuildContext context,
    String title = 'Something went wrong!',
    Duration duration = const Duration(seconds: 3),
    Alignment alignment = Alignment.bottomCenter,
  }) {
    toastification.show(
      context: context,
      type: ToastificationType.error,
      autoCloseDuration: duration,
      title: Text(title),
      description: null,
      primaryColor: Colors.white,
      backgroundColor: Colors.red,
      foregroundColor: Colors.white,
      alignment: alignment,
      showIcon: true,
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 16,
          offset: Offset(0, 16),
          spreadRadius: 0,
        ),
      ],
      dragToClose: true,
    );
  }
}
