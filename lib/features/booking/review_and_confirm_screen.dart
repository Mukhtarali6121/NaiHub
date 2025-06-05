import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nai_hub/utils/theme/colors.dart';
import 'package:provider/provider.dart';

import '../SalonDetails/salon_details_screen.dart';
import '../cart/presentation/cart_provider.dart';
import '../coupon_code/presentation/coupon_code_page.dart';

class ReviewAndConfirmScreen extends StatefulWidget {
  const ReviewAndConfirmScreen({super.key});

  @override
  State<ReviewAndConfirmScreen> createState() => _ReviewAndConfirmScreenState();
}

class _ReviewAndConfirmScreenState extends State<ReviewAndConfirmScreen> {
  String? bookingNote;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final cartItems = cart.items;

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        // <-- Add this line
        title: Text(
          'Review and Confirm',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'inter_bold',
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Salon Information
            _buildSalonInfoCard(darkTextColor, lightTextColor, cartItems),
            const SizedBox(height: 16),

            _buildBookingNotes(),
            const SizedBox(height: 16),
            _buildCouponCode(context),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(mainColor, darkTextColor,cartItems),
    );
  }

  Widget _buildSalonInfoCard(
    Color darkTextColor,
    Color lightTextColor,
    List<CartItem> cartItems,
  ) {
    return Card(
      color: white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Joni Signature Salon and Aesthetic Wellness',
                              style: TextStyle(
                                color: darkTextColor,
                                fontFamily: 'inter_bold',
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'No: 4/11, Ezhil Nagar Main Road, Ezhil Nagar, Selaiyur, Tambaram, Chennai, Tamil Nadu, India, 600073',
                              style: TextStyle(
                                color: lightTextColor,
                                fontSize: 14,
                                fontFamily: 'inter_medium',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Optional spacing between text and image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          'https://via.placeholder.com/60x60.png?text=JONI',
                          width: 55,
                          height: 55,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) => Container(
                                width: 55,
                                height: 55,
                                color: Colors.grey[300],
                                child: const Icon(
                                  Icons.business,
                                  color: Colors.grey,
                                ),
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            buildSectionDivider(),
            _buildDateTimeCard(darkTextColor, lightTextColor,cartItems),
            buildSectionDivider(),
            _buildStaffPreferenceCard(darkTextColor, lightTextColor),
            buildSectionDivider(),
            _buildServiceDetailsCard(darkTextColor, lightTextColor, cartItems),
          ],
        ),
      ),
    );
  }

  Widget _buildDateTimeCard(Color darkTextColor, Color lightTextColor, List<CartItem> cartItems) {

    final int totalDurationMinutes = cartItems.fold(
      0,
          (sum, item) => sum + item.service.durationMinutes,
    );

// Format it to "1h 30m" style
    String getFormattedDuration(int minutes) {
      final int hours = minutes ~/ 60;
      final int remainingMinutes = minutes % 60;

      if (hours > 0 && remainingMinutes > 0) {
        return '${hours}h ${remainingMinutes}m';
      } else if (hours > 0) {
        return '${hours}h';
      } else {
        return '${remainingMinutes}m';
      }
    }

    final String durationText = '${getFormattedDuration(totalDurationMinutes)} duration';



    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '03 Jun 2025 at 05:30 pm',
          style: TextStyle(
            color: darkTextColor,
            fontFamily: 'inter_bold',
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '$durationText, ends at 06:30 pm',
          style: TextStyle(
            color: lightTextColor,
            fontSize: 16,
            fontFamily: 'inter_semibold',
          ),
        ),
      ],
    );
  }

  void _showBookingNoteDialog() {
    final TextEditingController _controller = TextEditingController(
      text: bookingNote ?? '',
    );
    final _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            'Add Booking Note',
            style: TextStyle(fontFamily: 'inter_bold', fontSize: 25),
          ),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    'Add a note for the specialist if you have any special requests.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      fontFamily: 'inter_medium',
                    ),
                  ),
                ),
                TextFormField(
                  controller: _controller,
                  maxLines: 3,
                  maxLength: 100,
                  textInputAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.sentences,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a note';
                    }
                    return null;
                  },
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'inter_semibold',
                    color: Colors.grey[800],
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter your note...',
                    border: const OutlineInputBorder(),
                    counterText: '',
                    // hides "0/100"
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontFamily: 'inter_medium',
                      color: grey_C4CADA,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: mainColor, width: 2),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 12,
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      bookingNote = _controller.text.trim();
                    });
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  'DONE',
                  style: TextStyle(fontFamily: 'inter_bold', color: white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBookingNotes() {
    return Card(
      color: white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () => _showBookingNoteDialog(),
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/ic_vector_booking_note.svg",
                width: 22,
                height: 22,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  bookingNote?.isEmpty ?? true
                      ? 'Add Booking Notes'
                      : bookingNote!,
                  style: TextStyle(
                    color:
                        bookingNote?.isEmpty ?? true
                            ? mainColor
                            : darkTextColor,
                    fontSize: bookingNote?.isEmpty ?? true ? 17 : 12,
                    fontFamily: 'inter_bold',
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 2,
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.grey[600], size: 18),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStaffPreferenceCard(Color darkTextColor, Color lightTextColor) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Staff Name',
              style: TextStyle(
                color: darkTextColor,
                fontSize: 15,
                fontFamily: 'inter_medium',
              ),
            ),
            Text(
              'No Preference',
              style: TextStyle(
                color: darkTextColor,
                fontFamily: 'inter_bold',
                fontSize: 15,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildServiceDetailsCard(
    Color darkTextColor,
    Color lightTextColor,
    List<CartItem> cartItems,
  ) {
    return Column(
      children: [
        ListView.builder(
          itemCount: cartItems.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final service = cartItems[index].service;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          service.name,
                          style: TextStyle(
                            color: darkTextColor,
                            fontFamily: 'inter_bold',
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "${service.durationMinutes.toString()} mins",
                          style: TextStyle(
                            color: lightTextColor,
                            fontFamily: 'inter_medium',
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '₹${service.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: darkTextColor,
                      fontFamily: 'inter_bold',
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(width: 8), // Some space before the icon
                  IconButton(
                    icon: Icon(Icons.delete, color: mainColor),
                    onPressed: () {
                      showDeleteConfirmationDialog(
                        context: context,
                        onDelete: () {
                          Provider.of<CartProvider>(context, listen: false)
                              .removeFromCart(service);
                        },
                      );
                    },
                  ),
                ],
              ),

            );
          },
        ),
        buildSectionDivider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Amount',
              style: TextStyle(
                color: mainColor,
                fontSize: 16,
                fontFamily: 'inter_semibold',
              ),
            ),
            Text(
              '₹${cartItems.fold(0.0, (sum, item) => sum + item.service.price).toStringAsFixed(2)}',
              style: TextStyle(
                color: darkTextColor,
                fontSize: 15,
                fontFamily: 'inter_bold',
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Price Breakdown',
              style: TextStyle(color: darkTextColor, fontSize: 15),
            ),
            Icon(Icons.keyboard_arrow_down, color: lightTextColor),
          ],
        ),
        buildSectionDivider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Price',
              style: TextStyle(
                color: mainColor,
                fontSize: 16,
                fontFamily: 'inter_semibold',
              ),
            ),
            Text(
              '₹${cartItems.fold(0.0, (sum, item) => sum + item.service.price).toStringAsFixed(2)}',
              style: TextStyle(
                color: darkTextColor,
                fontSize: 15,
                fontFamily: 'inter_bold',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildSectionDivider() {
    return const Column(
      children: [
        SizedBox(height: 10),
        Divider(color: Color(0xFFE0E0E0), thickness: 1), // Colors.grey[300]
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildCouponCode(BuildContext context) {
    return Card(
      color: white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          // Navigation logic
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EnterCouponCodePage()),
          );
        },
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/ic_vector_coupon_code.svg",
                width: 22,
                height: 22,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Enter Coupon Code',
                  style: TextStyle(
                    color: mainColor,
                    fontSize: 17,
                    fontFamily: 'inter_bold',
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.grey[600], size: 18),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar(Color colorPrimary, Color darkTextColor, List<CartItem> cartItems) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, -3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Amount',
                style: TextStyle(
                  color: darkTextColor.withOpacity(0.8),
                  fontFamily: 'inter_medium',
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '₹${cartItems.fold(0.0, (sum, item) => sum + item.service.price).toStringAsFixed(2)}',
                style: TextStyle(
                  color: darkTextColor,
                  fontFamily: 'inter_semibold',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              // Handle Book Now
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: colorPrimary,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'BOOK NOW',
              style: TextStyle(
                fontFamily: 'inter_bold',
                color: white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showDeleteConfirmationDialog({
    required BuildContext context,
    required VoidCallback onDelete,
  }) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: white,
          title: const Text(
            'Remove Service',
            style: TextStyle(
              fontFamily: 'inter_bold',
              fontSize: 18,
            ),
          ),
          content: const Text(
            'Are you sure you want to remove this service from the cart?',
            style: TextStyle(
              fontFamily: 'inter_medium',
              fontSize: 16,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close the dialog
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: mainColor,
                  fontFamily: 'inter_medium',
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                onDelete();
                Navigator.of(dialogContext).pop(); // Close the dialog
              },
              style: TextButton.styleFrom(
                backgroundColor: mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
              child: const Text(
                'Delete',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'inter_bold',
                ),
              ),
            ),
          ],
        );
      },
    );
  }


}

class Service {
  final String name;
  final String duration;
  final double price;

  Service({required this.name, required this.duration, required this.price});
}
