import 'package:flutter/material.dart';
import 'package:nai_hub/utils/theme/colors.dart';

import 'BookingListView.dart';

class BookingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: white,
        body: Column(
          children: [
            SizedBox(height: 40), // for status bar spacing
            _buildToolbar(context),
            TabBar(
              labelColor: Colors.black,
              indicatorColor: Colors.red,
              labelStyle: TextStyle(fontFamily: 'inter_medium', fontSize: 16),
              tabs: [
                Tab(text: 'Upcoming'),
                Tab(text: 'Completed'),
                Tab(text: 'Cancelled'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  BookingListView(tabType: 'upcoming'),
                  BookingListView(tabType: 'completed'),
                  BookingListView(tabType: 'cancelled'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolbar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Text(
                "Bookings",
                style: TextStyle(fontSize: 20, fontFamily: 'inter_semibold'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
