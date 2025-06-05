import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nai_hub/features/booking/BookingScreen.dart';
import 'package:nai_hub/features/home/Explore.dart';
import 'package:nai_hub/features/home/Home.dart';
import 'package:nai_hub/features/profile/profile_page.dart';
import 'package:nai_hub/utils/theme/colors.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Home(),
    Explore(),
    BookingScreen(),
    ProfilePage(),
  ];

  final List<Map<String, dynamic>> _navItems = [
    {
      'label': 'Home',
      'activeIcon': 'assets/ic_vector_home.svg',
      'inactiveIcon': 'assets/ic_vector_home_inactive.svg',
    },
    {
      'label': 'Explore',
      'activeIcon': 'assets/ic_vector_explore_active.svg',
      'inactiveIcon': 'assets/ic_vector_explore_inactive.svg',
    },
    {
      'label': 'Bookings',
      'activeIcon': 'assets/ic_vector_calendar_active.svg',
      'inactiveIcon': 'assets/ic_vector_calendar_inactive.svg',
    },
    {
      'label': 'Profile',
      'activeIcon': 'assets/ic_vector_profile_active.svg',
      'inactiveIcon': 'assets/ic_vector_profile_inactive.svg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 50)],
        ),
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: _selectedIndex,
            onTap: (index) => setState(() => _selectedIndex = index),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: mainColor,
            unselectedItemColor: Colors.grey[600],
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedLabelStyle: TextStyle(
              fontSize: 13,
              fontFamily: 'font_medium', // Replace with actual font family
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 12,
              fontFamily: 'font_semibold', // Replace with actual font family
            ),
            items: List.generate(_navItems.length, (index) {
              final isSelected = _selectedIndex == index;
              return BottomNavigationBarItem(
                label: _navItems[index]['label'],
                icon: Column(
                  children: [
                    if (isSelected)
                      Container(
                        width: 16,
                        height: 8,
                        margin: EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(8),
                            top: Radius.circular(0),
                          ),
                        ),
                      )
                    else
                      SizedBox(height: 8),
                    SvgPicture.asset(
                      isSelected
                          ? _navItems[index]['activeIcon']
                          : _navItems[index]['inactiveIcon'],
                      height: 24,
                      width: 24,
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
