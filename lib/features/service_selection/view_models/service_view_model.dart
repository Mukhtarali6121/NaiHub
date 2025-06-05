// service_view_model.dart
import 'package:flutter/foundation.dart';

import '../models/service_model.dart';

class ServiceViewModel extends ChangeNotifier {
  List<ServiceCategory> _categories = [];

  List<ServiceCategory> get categories => _categories;

  ServiceViewModel() {
    // Load dummy data or fetch from API
    _loadDummyData();
  }

  void _loadDummyData() {
    _categories = [
      ServiceCategory(
        id: '1',
        name: 'Hair',
        subServices: [
          SubService(id: '1', name: 'Haircut', price: 25),
          SubService(id: '2', name: 'Coloring', price: 50),
        ],
      ),
      ServiceCategory(
        id: '2',
        name: 'Nails',
        subServices: [
          SubService(id: '3', name: 'Manicure', price: 20),
          SubService(id: '4', name: 'Pedicure', price: 25),
        ],
      ),
    ];
    notifyListeners();
  }

  void toggleCategory(String categoryId) {
    final index = _categories.indexWhere((c) => c.id == categoryId);
    _categories[index].isExpanded = !_categories[index].isExpanded;
    notifyListeners();
  }

  void toggleSubService(String categoryId, String subServiceId) {
    final category = _categories.firstWhere((c) => c.id == categoryId);
    final subService = category.subServices.firstWhere(
      (s) => s.id == subServiceId,
    );
    subService.isSelected = !subService.isSelected;
    notifyListeners();
  }

  double get totalPrice {
    double total = 0;
    for (var category in _categories) {
      total += category.subServices
          .where((s) => s.isSelected)
          .fold(0, (sum, item) => sum + item.price);
    }
    return total;
  }

  List<SubService> get selectedServices {
    return _categories
        .expand((category) => category.subServices)
        .where((service) => service.isSelected)
        .toList();
  }
}
