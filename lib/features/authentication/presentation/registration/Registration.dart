import 'package:flutter/material.dart';
import 'package:nai_hub/features/authentication/presentation/signin/SignIn.dart';
import 'package:provider/provider.dart';

import '../../../../SalonForm.dart';
import '../../../../common/widgets/EmailTextField.dart';
import '../../../../utils/theme/colors.dart';
import '../../../home/HomeScreen.dart';
import '../../auth_handler.dart';
import '../../data/domain/use_cases/registration_view_model.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(22),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16),
                _buildTitle(),
                const SizedBox(height: 10),
                _buildSubtitle(),
                const SizedBox(height: 30),
                _buildLabel('Name'),
                const SizedBox(height: 6),
                _buildNameField(),
                const SizedBox(height: 16),
                _buildLabel('Mobile Number'),
                const SizedBox(height: 6),
                _buildMobileNumberField(),
                const SizedBox(height: 16),
                _buildLabel('Email'),
                const SizedBox(height: 6),
                _buildEmailField(),
                const SizedBox(height: 16),
                _buildLabel('Password'),
                const SizedBox(height: 6),
                _buildPasswordField(),
                const SizedBox(height: 16),
                _buildLabel('Confirm Password'),
                const SizedBox(height: 6),
                _buildConfirmPasswordField(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildTitle() {
    return const Center(
      child: Text(
        'Create Account',
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
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Text(
          'We’re excited to have you! Let’s create your account and dive in.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'inter_medium',
            color: darkGreyColor,
          ),
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

  Widget _buildNameField() {
    return _buildCard(
      TextField(
        controller: _nameController,
        cursorColor: mainColor,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        autofillHints: null,
        enableSuggestions: false,
        autocorrect: false,
        style: const TextStyle(
          fontSize: 14,
          fontFamily: 'inter_medium',
          color: grey_1A1C1E,
        ),
        decoration: const InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: 'Enter your Full name',
          hintStyle: TextStyle(
            fontSize: 14,
            fontFamily: 'inter_medium',
            color: grey_C4CADA,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildMobileNumberField() {
    return _buildCard(
      TextField(
        controller: _mobileNumberController,
        cursorColor: mainColor,
        keyboardType: TextInputType.number,
        maxLength: 10,
        textInputAction: TextInputAction.next,
        autofillHints: null,
        enableSuggestions: false,
        autocorrect: false,
        style: const TextStyle(
          fontSize: 14,
          fontFamily: 'inter_medium',
          color: grey_1A1C1E,
        ),
        decoration: const InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: 'Enter your Mobile Number',
          hintStyle: TextStyle(
            fontSize: 14,
            fontFamily: 'inter_medium',
            color: grey_C4CADA,
          ),
          border: InputBorder.none,
          counterText: "",
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
        onChanged: (value) {},
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
        textInputAction: TextInputAction.next,
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

  Widget _buildConfirmPasswordField() {
    return _buildCard(
      TextField(
        controller: _confirmPasswordController,
        obscureText: _obscureConfirmPassword,
        cursorColor: mainColor,
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.done,
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
              _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
              color: grey_C4CADA,
            ),
            onPressed: () {
              setState(() {
                _obscureConfirmPassword = !_obscureConfirmPassword;
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

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSignUpText(),
          const SizedBox(height: 8),
          Consumer<RegistrationViewModel>(
            builder: (context, viewModel, _) {
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    padding: const EdgeInsets.symmetric(vertical: 11),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => _handleRegistration(),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: 'inter_medium',
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          _buildTermsAndConditions(),
        ],
      ),
    );
  }

  Widget _buildTermsAndConditions() {
    return SizedBox(
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
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  // Widget buildBottomNavigationBar(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.fromLTRB(24, 0, 24, 10),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         _buildSignUpText(),
  //         const SizedBox(height: 8),
  //
  //         // Sign In Button
  //         SizedBox(
  //           width: double.infinity,
  //           child: ElevatedButton(
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: mainColor,
  //               padding: const EdgeInsets.symmetric(vertical: 11),
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(12),
  //               ),
  //             ),
  //             onPressed: viewModel.isLoading ? null : _handleRegistration,
  //             child: const Text(
  //               'Sign Up',
  //               style: TextStyle(
  //                 fontSize: 16,
  //                 color: Colors.white,
  //                 fontFamily: 'inter_medium',
  //               ),
  //             ),
  //           ),
  //         ),
  //         const SizedBox(height: 8),
  //         // Terms & Conditions
  //         SizedBox(
  //           width: double.infinity,
  //           child: Text.rich(
  //             TextSpan(
  //               text: 'By proceeding, I agree to ',
  //               style: const TextStyle(
  //                 fontSize: 14,
  //                 fontFamily: 'inter_medium',
  //                 color: grey_99A1B7,
  //               ),
  //               children: [
  //                 TextSpan(
  //                   text: 'T&C',
  //                   style: TextStyle(
  //                     fontSize: 14,
  //                     fontFamily: 'inter_medium',
  //                     color:
  //                         Theme.of(context).brightness == Brightness.dark
  //                             ? Colors.white
  //                             : mainColor,
  //                     decoration: TextDecoration.underline,
  //                     decorationColor:
  //                         Theme.of(context).brightness == Brightness.dark
  //                             ? Colors.white
  //                             : mainColor,
  //                     decorationStyle: TextDecorationStyle.solid,
  //                   ),
  //                 ),
  //                 const WidgetSpan(child: SizedBox(width: 4)),
  //                 TextSpan(
  //                   text: 'Privacy Policy',
  //                   style: TextStyle(
  //                     fontSize: 14,
  //                     fontFamily: 'inter_medium',
  //                     color:
  //                         Theme.of(context).brightness == Brightness.dark
  //                             ? Colors.white
  //                             : mainColor,
  //                     decoration: TextDecoration.underline,
  //                     decorationColor:
  //                         Theme.of(context).brightness == Brightness.dark
  //                             ? Colors.white
  //                             : mainColor,
  //                     decorationStyle: TextDecorationStyle.solid,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             textAlign: TextAlign.center,
  //           ),
  //         ),
  //         const SizedBox(height: 8),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildSignUpText() {
    return Center(
      child: GestureDetector(
        onTap: () {
          _navigateToSignInPage();
        },
        child: RichText(
          text: TextSpan(
            text: 'Already have an account? ',
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'inter_medium',
              color: grey_6C7278,
            ),
            children: [
              TextSpan(
                text: 'Sign In',
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

  void _navigateToSignInPage() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => SignIn(),
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

  void _handleRegistration() {
    AuthHandler.handleRegistration(
      context: context,
      nameController: _nameController,
      mobileController: _mobileNumberController,
      emailController: _emailController,
      passwordController: _passwordController,
      confirmPasswordController: _confirmPasswordController,
      navigateToAdminPage: _navigateToAdminPage,
      navigateToHomePage: _navigateToHomePage,
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
