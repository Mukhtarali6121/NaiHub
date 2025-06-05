import 'package:flutter/material.dart';

import 'BookingCard.dart';

class BookingListView extends StatelessWidget {
  final String tabType;

  BookingListView({required this.tabType});

  @override
  Widget build(BuildContext context) {
    // Replace with real data based on tabType
    final mockData = [
      {
        'date': 'Aug 25, 2024 - 10:00 AM',
        'title': 'Glamour Haven',
        'address': 'G8502 Preston Rd. Inglewood',
        'serviceId': '#HR452SA54',
        'image': 'assets/salon_1.jpg',
        'remind': true,
      },
    ];

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: mockData.length,
      itemBuilder: (context, index) {
        return BookingCard(
          data: mockData[index],
          tabType: tabType,
          remind: true,
          onRemindChanged: (bool value) {},
        );
      },
    );
  }
}
