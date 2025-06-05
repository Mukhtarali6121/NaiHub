import 'package:flutter/material.dart';

import '../../SalonDetails/salon_details_screen.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addToCart(ServiceItem service) {
    if (!_items.any((item) => item.service.id == service.id)) {
      _items.add(CartItem(service: service));
      notifyListeners();
    }
  }

  void removeFromCart(ServiceItem service) {
    _items.removeWhere((item) => item.service.id == service.id);
    notifyListeners();
  }

  bool isInCart(ServiceItem service) {
    return _items.any((item) => item.service.id == service.id);
  }

  double get totalAmount {
    return _items.fold(0.0, (sum, item) => sum + item.service.price);
  }

  int get itemCount => _items.length;

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
  @override
  String toString() {
    return 'CartProvider(items: ${_items.map((e) => e.service.name).toList()})';
  }

}
