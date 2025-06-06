import 'package:flutter/material.dart';
import 'package:nai_hub/features/SalonDetails/salon_details_screen.dart';
import 'package:nai_hub/features/authentication/presentation/signin/SignIn.dart';
import 'package:nai_hub/features/booking/appointment_screen.dart';
import 'package:nai_hub/features/booking/review_and_confirm_screen.dart';
import 'package:nai_hub/features/home/HomeScreen.dart';
import 'package:provider/provider.dart';

import 'features/authentication/data/domain/use_cases/login_user_view_model.dart';
import 'features/authentication/data/domain/use_cases/registration_view_model.dart';
import 'features/cart/presentation/cart_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RegistrationViewModel()),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nai Hub',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
