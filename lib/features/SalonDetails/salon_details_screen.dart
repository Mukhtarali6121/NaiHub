import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nai_hub/features/SalonDetails/review_tab.dart';
import 'package:nai_hub/features/SalonDetails/services_tab.dart';
import 'package:provider/provider.dart';

import '../../utils/theme/colors.dart';
import '../cart/presentation/cart_bottom_bar.dart';
import '../cart/presentation/cart_provider.dart';
import 'about_us_tab.dart';

class SalonDetailsScreen extends StatefulWidget {
  const SalonDetailsScreen({super.key});

  @override
  State<SalonDetailsScreen> createState() => _SalonDetailsScreenState();
}

class _SalonDetailsScreenState extends State<SalonDetailsScreen> {
  bool _expanded = false;
  final List<String> days = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  final String openTime = "10:00 am";
  final String closeTime = "08:30 pm";

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    print("cart in details -> $cart");

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImageWithActionButtons(),
                  _buildInfoCardWithRating(),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar:
            cart.itemCount > 0
                ? const CartBottomBar()
                : null, // Show only if there are items in the cart
      ),
    );
  }

  Widget _buildTabs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 48,
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: TabBar(
            dividerColor: Colors.transparent,
            // <- Prevent line between tabs (for newer versions)
            indicator: BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.circular(30),
            ),
            labelColor: Colors.white,
            unselectedLabelColor: mainColor,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'inter_medium',
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'inter_medium',
            ),
            tabs: const [
              Tab(text: 'Services'),
              Tab(text: 'Review'),
              Tab(text: 'About Us'),
            ],
          ),
        ),
        SizedBox(
          height: 1000,
          child: TabBarView(
            children: const [ServicesTab(), ReviewTab(), AboutUsTab()],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard() {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      elevation: 0,
      margin: EdgeInsets.zero,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              _buildSalonName(),
              _buildDivider(),
              _buildLocationRow(),
              const SizedBox(height: 4),
              _buildButton(),
              const SizedBox(height: 16),
              _buildTiming(),
              const SizedBox(height: 16),
              _buildDivider(),
              _buildTabs(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTiming() {
    return Column(
      children: [
        InkWell(
          onTap: () => setState(() => _expanded = !_expanded),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/ic_vector_clock.svg",
                width: 20,
                height: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'Open Now',
                style: TextStyle(
                  color: Colors.green,
                  fontFamily: 'inter_medium',
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '$openTime to $closeTime',
                style: TextStyle(fontFamily: 'inter_medium', fontSize: 14),
              ),
              const Spacer(),
              Icon(
                _expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              ),
            ],
          ),
        ),
        AnimatedCrossFade(
          firstChild: Container(),
          secondChild: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Column(
              children:
                  days
                      .map(
                        (day) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: Text(
                                  day,
                                  style: const TextStyle(
                                    fontFamily: 'inter_medium',
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Text(
                                '$openTime to $closeTime',
                                style: TextStyle(
                                  fontFamily: 'inter_medium',
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),
          crossFadeState:
              _expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
      ],
    );
  }

  Widget _buildButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 3),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.location_on, color: grey_6C7278),
              label: Text(
                'Get Direction',
                style: TextStyle(
                  fontFamily: 'inter_semibold',
                  fontSize: 14,
                  color: grey_6C7278,
                ),
              ),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.grey[200],
                padding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          const SizedBox(width: 30),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.phone, color: grey_6C7278),
              label: Text(
                'Contact Store',
                style: TextStyle(
                  fontFamily: 'inter_semibold',
                  fontSize: 14,
                  color: grey_6C7278,
                ),
              ),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.grey[200],
                padding: const EdgeInsets.symmetric(vertical: 3),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSalonName() {
    return const Text(
      'Glamour Haven',
      style: TextStyle(fontSize: 20, fontFamily: 'inter_bold'),
    );
  }

  Widget _buildDivider() {
    return Divider(color: Colors.grey[300]);
  }

  Widget _buildLocationRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/ic_vector_explore_active.svg",
          width: 20,
          height: 20,
        ),
        const SizedBox(width: 4),
        const Expanded(
          child: Text(
            '8502 Preston Rd. Inglewood, Maine 98380',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14,
              fontFamily: 'inter_medium',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCardWithRating() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Transform.translate(
          offset: const Offset(0, -15),
          child: _buildInfoCard(),
        ),
        _buildRatingBadge(),
      ],
    );
  }

  Widget _buildRatingBadge() {
    return Positioned(
      top: -27,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star, color: Colors.white, size: 16),
              SizedBox(width: 4),
              Text(
                '4.8 (1k+ Review)',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageWithActionButtons() {
    return Stack(
      children: [
        SizedBox(
          height: 230,
          width: double.infinity,
          child: Image.asset('assets/salon_1.jpg', fit: BoxFit.cover),
        ),
        Positioned(top: 40, left: 16, right: 16, child: _buildActionButton()),
      ],
    );
  }

  Widget _buildActionButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
        Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.share, color: Colors.black),
            ),
            const SizedBox(width: 8),
            const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.favorite_border, color: Colors.black),
            ),
          ],
        ),
      ],
    );
  }
}
enum SalonView { reviews, services }

class ReviewModel {
  final String name;
  final String review;
  final int rating;
  final String? imageUrl;

  ReviewModel({
    required this.name,
    required this.review,
    required this.rating,
    this.imageUrl,
  });
}

class ServiceItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final int durationMinutes;

  ServiceItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.durationMinutes,
  });
}

class ServiceCategory {
  final String id;
  final String name;
  final List<ServiceItem> items;
  bool isExpanded = false;

  ServiceCategory({
    required this.id,
    required this.name,
    required this.items,
    this.isExpanded = false,
  });
}

class CartItem {
  final ServiceItem service;
  int quantity = 1;

  CartItem({required this.service, this.quantity = 1});

  // Override toString
  @override
  String toString() {
    return 'CartItem(service: ${service.name}, price: ₹${service.price})';
  }
}

