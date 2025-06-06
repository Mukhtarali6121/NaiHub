import 'package:flutter/material.dart';
import 'package:nai_hub/features/SalonDetails/salon_details_screen.dart';
import 'package:provider/provider.dart';

import '../../utils/theme/colors.dart';
import '../cart/presentation/cart_provider.dart';

class ServicesTab extends StatefulWidget {
  const ServicesTab({super.key});

  @override
  State<ServicesTab> createState() => _ServicesTabState();
}

class _ServicesTabState extends State<ServicesTab> {
  List<ServiceCategory> _serviceCategories = [];
  final List<CartItem> _cartItems = [];
  final numbers = List.generate(11, (index) => index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              key: const ValueKey('services'),
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildServiceMenu(),
                const SizedBox(height: 80),
              ],
            ),
          ),
          // if (cart.itemCount > 0)
          //   Align(
          //     alignment: Alignment.bottomCenter,
          //     child: const CartBottomBar(),
          //   ),
        ],
      ),
    );
  }

  Widget _buildServiceMenu() {
    if (_serviceCategories.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          'No services available.',
          style: TextStyle(fontFamily: 'inter_bold', fontSize: 18),
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: _serviceCategories.length,
      itemBuilder: (context, index) {
        final category = _serviceCategories[index];
        return Column(
          children: [
            Card(
              color: Colors.white,
              elevation: 0,
              margin: const EdgeInsets.symmetric(
                horizontal: 0.0,
                vertical: 0.0,
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent,
                  listTileTheme: const ListTileThemeData(
                    contentPadding: EdgeInsets.symmetric(horizontal: 0.0), // remove horizontal padding
                  ),
                ),
                child: ExpansionTile(
                  key: PageStorageKey(category.id),
                  title: Text(
                    category.name,
                    style: const TextStyle(
                      fontFamily: 'inter_semibold',
                      fontSize: 19,
                    ),
                  ),
                  initiallyExpanded: true,
                  children:
                      category.items
                          .map((item) => _buildServiceItemTile(item))
                          .toList(),
                  childrenPadding: const EdgeInsets.only(bottom: 8.0),
                  collapsedIconColor: mainColor,
                  iconColor: mainColor,
                ),
              ),
            ),
            Divider(),
          ],
        );
      },
    );
  }

  void _loadServiceCategories() {
    _serviceCategories = [
      ServiceCategory(
        id: 'cat1',
        name: 'Facial Treatments',
        items: [
          ServiceItem(
            id: 's1',
            name: 'Classic Clean Up',
            description: 'Deep cleansing and exfoliation.',
            price: 45.00,
            durationMinutes: 45,
          ),
          ServiceItem(
            id: 's2',
            name: 'Tan Removal Facial',
            description: 'Brightens and removes tan.',
            price: 60.00,
            durationMinutes: 60,
          ),
          ServiceItem(
            id: 's3',
            name: 'Skin Brightening Facial',
            description: 'For a radiant glow.',
            price: 75.00,
            durationMinutes: 75,
          ),
          ServiceItem(
            id: 's4',
            name: 'Oxy Facial',
            description: 'Infuses oxygen for hydration.',
            price: 90.00,
            durationMinutes: 60,
          ),
        ],
      ),
      ServiceCategory(
        id: 'cat2',
        name: 'Hair Care',
        items: [
          ServiceItem(
            id: 's5',
            name: 'Haircut & Style',
            description: 'Professional cut and styling.',
            price: 50.00,
            durationMinutes: 60,
          ),
          ServiceItem(
            id: 's6',
            name: 'Deep Conditioning Spa',
            description: 'Nourishes and revitalizes hair.',
            price: 65.00,
            durationMinutes: 70,
          ),
          ServiceItem(
            id: 's7',
            name: 'Global Hair Color',
            description: 'Full head color application.',
            price: 120.00,
            durationMinutes: 120,
          ),
        ],
      ),
      ServiceCategory(
        id: 'cat3',
        name: 'Manicure & Pedicure',
        items: [
          ServiceItem(
            id: 's8',
            name: 'Classic Manicure',
            description: 'Nail shaping, cuticle care, polish.',
            price: 30.00,
            durationMinutes: 45,
          ),
          ServiceItem(
            id: 's9',
            name: 'Spa Pedicure',
            description: 'Relaxing foot soak, scrub, massage.',
            price: 45.00,
            durationMinutes: 60,
          ),
        ],
      ),
    ];
    _serviceCategories.sort((a, b) => a.name.compareTo(b.name));
  }

  Widget _buildServiceItemTile(ServiceItem item) {
    final cartProvider = Provider.of<CartProvider>(context);
    final inCart = cartProvider.isInCart(item);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 5.0,
        vertical: 4.0,
      ),
      title: Text(
        item.name,
        style: const TextStyle(fontFamily: 'inter_semibold', fontSize: 16),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.description,
            style: TextStyle(
              color: Colors.grey[600],
              fontFamily: 'inter_regular',
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '\₹${item.price.toStringAsFixed(2)}  •  ${item.durationMinutes} min',
            style: TextStyle(color: mainColor, fontFamily: 'inter_medium'),
          ),
        ],
      ),
      trailing: ElevatedButton.icon(
        icon:
            inCart
                ? const Icon(
                  Icons.check_circle_outline,
                  size: 18,
                  color: Colors.white,
                )
                : const Icon(Icons.add, color: Colors.white),
        label: Text(
          inCart ? 'Added' : 'Add',
          style: TextStyle(
            color: Colors.white,
            fontFamily: inCart ? 'inter_medium' : 'inter_bold',
            fontSize: inCart ? 14 : 16,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: inCart ? Colors.grey[400] : mainColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          textStyle: const TextStyle(fontSize: 13),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        onPressed: () {
          if (inCart) {
            cartProvider.removeFromCart(item);
          } else {
            cartProvider.addToCart(item);
          }
        },
      ),
      onTap: () {
        // Show service details if needed
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _loadServiceCategories();
  }
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
}
