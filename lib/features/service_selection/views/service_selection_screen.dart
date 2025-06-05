// service_selection_screen.dart
import 'package:flutter/material.dart';
import 'package:nai_hub/utils/theme/colors.dart';
import 'package:provider/provider.dart';

import '../models/service_model.dart';
import '../view_models/service_view_model.dart';

class ServiceSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ServiceViewModel(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              _buildActionButton(),
              Expanded(child: _CategoryList()),
              _BottomSummary(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Back button on the left
        CircleAvatar(
          backgroundColor: mainColor,
          child: Icon(Icons.arrow_back, color: Colors.black),
        ),

        // Share and Favorite on the right
        Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.share, color: Colors.black),
            ),
            SizedBox(width: 8), // spacing between icons
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.favorite_border, color: Colors.black),
            ),
          ],
        ),
      ],
    );
  }
}

class _CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ServiceViewModel>(context);
    return ListView.builder(
      itemCount: vm.categories.length,
      itemBuilder: (context, index) {
        final category = vm.categories[index];
        return _CategoryItem(category: category);
      },
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final ServiceCategory category;

  const _CategoryItem({required this.category});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ServiceViewModel>(context);
    return Column(
      children: [
        ListTile(
          title: Text(category.name),
          trailing: Icon(
            category.isExpanded ? Icons.expand_less : Icons.expand_more,
          ),
          onTap: () => vm.toggleCategory(category.id),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: category.isExpanded ? category.subServices.length * 60.0 : 0,
          child: ListView.builder(
            itemCount: category.subServices.length,
            itemBuilder: (context, index) {
              final service = category.subServices[index];
              return _SubServiceItem(service: service, categoryId: category.id);
            },
          ),
        ),
      ],
    );
  }
}

class _SubServiceItem extends StatelessWidget {
  final SubService service;
  final String categoryId;

  const _SubServiceItem({required this.service, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ServiceViewModel>(context);
    return CheckboxListTile(
      title: Text(service.name),
      subtitle: Text('\$${service.price.toStringAsFixed(2)}'),
      value: service.isSelected,
      onChanged: (value) => vm.toggleSubService(categoryId, service.id),
    );
  }
}

class _BottomSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ServiceViewModel>(context);
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Selected Services: ${vm.selectedServices.length}'),
              Text('Total: \$${vm.totalPrice.toStringAsFixed(2)}'),
            ],
          ),
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: vm.selectedServices.isEmpty ? null : () {},
              child: Text('Book Now'),
            ),
          ),
        ],
      ),
    );
  }
}
