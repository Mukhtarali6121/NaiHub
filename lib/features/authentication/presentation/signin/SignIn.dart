import 'package:flutter/material.dart';
import 'package:nai_hub/SalonForm.dart';
import 'package:nai_hub/features/authentication/presentation/registration/Registration.dart';
import 'package:nai_hub/features/home/HomeScreen.dart';
import 'package:nai_hub/utils/theme/colors.dart';

import '../../../../common/widgets/EmailTextField.dart';
import '../../auth_handler.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(22),
          child: Column(
            children: [
              const SizedBox(height: 38),
              _buildTitle(),
              const SizedBox(height: 10),
              _buildSubtitle(),
              const SizedBox(height: 50),
              _buildLabel('Email'),
              const SizedBox(height: 8),
              _buildEmailField(),
              const SizedBox(height: 16),
              _buildLabel('Password'),
              const SizedBox(height: 8),
              _buildPasswordField(),
              const SizedBox(height: 12),
              _buildForgotPassword('Forgot Password?'),
              const SizedBox(height: 50),
              _buildSignUpText(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }

  Widget _buildTitle() {
    return const Center(
      child: Text(
        'Sign In',
        style: TextStyle(
          fontSize: 27,
          fontFamily: 'inter_semibold',
          color: black,
        ),
      ),
    );
  }

  Widget _buildSubtitle() {
    return const Center(
      child: Text(
        'Hi! Welcome back, you\'ve been missed',
        style: TextStyle(
          fontSize: 14,
          fontFamily: 'inter_medium',
          color: darkGreyColor,
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        ' $text',
        style: const TextStyle(
          fontSize: 15,
          fontFamily: 'inter_medium',
          color: black,
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return _buildCard(
      EmailTextField(
        controller: _emailController,
        validator: (value) {
          return null;
          /*
          if (value == null || value.isEmpty) {
            return 'Please enter your email';
          }
          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
            return 'Please enter a valid email';
          }
          return null;*/
        },
        onChanged: (value) {
          // Handle text changes if needed
        },
      ),
    );
  }

  Widget _buildPasswordField() {
    return _buildCard(
      TextField(
        controller: _passwordController,
        obscureText: _obscurePassword,
        cursorColor: mainColor,
        keyboardType: TextInputType.visiblePassword,
        style: const TextStyle(
          fontSize: 14,
          fontFamily: 'inter_medium',
          color: grey_1A1C1E,
        ),
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: 'Enter your password',
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 12,
          ),
          hintStyle: const TextStyle(
            fontSize: 14,
            fontFamily: 'inter_medium',
            color: grey_C4CADA,
          ),
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword ? Icons.visibility_off : Icons.visibility,
              color: grey_C4CADA,
            ),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(Widget child) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: grey_EDF1F3, width: 1.5),
      ),
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.zero,
        child: Row(children: [Expanded(child: child)]),
      ),
    );
  }

  Widget _buildForgotPassword(String text) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        ' $text',
        style: const TextStyle(
          fontSize: 14,
          fontFamily: 'inter_medium',
          color: mainColor,
          decoration: TextDecoration.underline,
          decorationColor: mainColor,
        ),
      ),
    );
  }

  Widget buildBottomNavigationBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: mainColor,
                padding: const EdgeInsets.symmetric(vertical: 11),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                AuthHandler.handleLogin(
                  context: context,
                  emailController: _emailController,
                  passwordController: _passwordController,
                  navigateToAdminPage: _navigateToAdminPage,
                  navigateToHomePage: _navigateToHomePage,
                );
              },
              child: const Text(
                'Sign in',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontFamily: 'inter_medium',
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Terms & Conditions
          SizedBox(
            width: double.infinity,
            child: Text.rich(
              TextSpan(
                text: 'By proceeding, I agree to ',
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'inter_medium',
                  color: grey_99A1B7,
                ),
                children: [
                  TextSpan(
                    text: 'T&C',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'inter_medium',
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : mainColor,
                      decoration: TextDecoration.underline,
                      decorationColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : mainColor,
                      decorationStyle: TextDecorationStyle.solid,
                    ),
                  ),
                  const WidgetSpan(child: SizedBox(width: 4)),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'inter_medium',
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : mainColor,
                      decoration: TextDecoration.underline,
                      decorationColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : mainColor,
                      decorationStyle: TextDecorationStyle.solid,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpText() {
    return Center(
      child: GestureDetector(
        onTap: () {
          _navigateToSignUpPage();
        },
        child: RichText(
          text: TextSpan(
            text: 'Didn\'t have an account? ',
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'inter_medium',
              color: grey_6C7278,
            ),
            children: [
              TextSpan(
                text: 'Sign Up',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'inter_medium',
                  color: mainColor,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToSignUpPage() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => Registration(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(1.0, 0.0);
          var end = Offset.zero;
          var curve = Curves.ease;

          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }

  void _navigateToAdminPage() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => SalonForm(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(1.0, 0.0);
          var end = Offset.zero;
          var curve = Curves.ease;

          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }

  void _navigateToHomePage() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(1.0, 0.0);
          var end = Offset.zero;
          var curve = Curves.ease;

          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }
}
