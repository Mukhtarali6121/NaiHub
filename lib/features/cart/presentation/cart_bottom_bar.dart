import 'package:flutter/material.dart';
import 'package:nai_hub/features/booking/review_and_confirm_screen.dart';
import 'package:provider/provider.dart';

import '../../../utils/theme/colors.dart';
import 'cart_provider.dart';

class CartBottomBar extends StatelessWidget {
  const CartBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    if (cart.itemCount == 0) return const SizedBox();

    print("cartItem --> ${cart.items}");
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(0, -4), // Negative dy to cast shadow upwards
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${cart.itemCount} item(s) items added',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'inter_bold',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _navigateToSignUpPage(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: mainColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'View Cart',
              style: TextStyle(fontSize: 14,
                fontFamily: 'inter_bold',
              ),
            ),
          ),
        ],
      ),
    );
    ;
  }

  void _navigateToSignUpPage(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => ReviewAndConfirmScreen(),
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
