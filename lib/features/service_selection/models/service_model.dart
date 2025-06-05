// service_model.dart
class ServiceCategory {
  final String id;
  final String name;
  final List<SubService> subServices;
  bool isExpanded;

  ServiceCategory({
    required this.id,
    required this.name,
    required this.subServices,
    this.isExpanded = false,
  });
}

class SubService {
  final String id;
  final String name;
  final double price;
  bool isSelected;

  SubService({
    required this.id,
    required this.name,
    required this.price,
    this.isSelected = false,
  });
}
