import 'package:flutter/material.dart';

import '../../utils/theme/colors.dart';

class EmailTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final bool autoFocus;

  const EmailTextField({
    Key? key,
    required this.controller,
    this.hintText = 'Enter your Email Address',
    this.validator,
    this.onChanged,
    this.autoFocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: mainColor,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      autofocus: autoFocus,
      autofillHints: null,
      enableSuggestions: false,
      autocorrect: false,
      style: const TextStyle(
        fontSize: 14,
        fontFamily: 'inter_medium',
        color: grey_1A1C1E,
      ),
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 14,
          fontFamily: 'inter_medium',
          color: grey_C4CADA,
        ),
        border: InputBorder.none,
        errorText: validator != null ? validator!(controller.text) : null,
      ),
      onChanged: onChanged,
    );
  }
}
