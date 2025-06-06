import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nai_hub/features/SalonDetails/salon_details_screen.dart';
import 'package:nai_hub/features/home/search_page.dart';
import 'package:nai_hub/features/location/LocationSearchScreen.dart';
import 'package:nai_hub/utils/theme/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Map<String, dynamic>> services = [
    {'icon': Icons.content_cut, 'label': 'Haircuts'},
    {'icon': Icons.brush, 'label': 'Make Up'},
    {'icon': Icons.electric_bike, 'label': 'Shaving'},
    {'icon': Icons.spa, 'label': 'Massage'},
    {'icon': Icons.hail_rounded, 'label': 'Hair Dry'},
  ];

  final List<Map<String, dynamic>> salons = [
    {
      'name': 'Glam Studio',
      'location': 'New York, USA',
      'rating': 4.8,
      'image': 'assets/salon_1.jpg',
    },
    {
      'name': 'Beauty Bliss',
      'location': 'Los Angeles, USA',
      'rating': 4.5,
      'image': 'assets/salon_2.jpg',
    },
    {
      'name': 'Luxury Look',
      'location': 'Chicago, USA',
      'rating': 4.7,
      'image': 'assets/salon_3.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTopRow(),
                SizedBox(height: 16),
                _buildSearchAndFilter(),
                SizedBox(height: 30),
                buildServicesSection(services, () {
                  print("See All clicked!");
                  // Navigate to all services page
                }),

                _buildTopRatedSalon(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildServicesSection(
    List<Map<String, dynamic>> services,
    VoidCallback onSeeAllTap,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Services",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'inter_semibold',
                color: grey_181a19,
              ),
            ),
            GestureDetector(
              onTap: onSeeAllTap,
              child: Text(
                "See All",
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'inter_medium',
                  color: mainColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: services.length,
            itemBuilder: (context, index) {
              final item = services[index];
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: grey_f5dfdf,
                      child: Icon(item['icon'], color: Colors.black, size: 25),
                    ),
                    SizedBox(height: 8),
                    Text(
                      item['label'],
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'inter_medium',
                        color: darkGreyColor,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTopRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_buildLocationInfo(), _buildNotificationIcon()],
    );
  }

  Widget _buildLocationInfo() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Location',
              style: TextStyle(
                fontFamily: 'inter_regular',
                fontSize: 16,
                color: grey_959695,
              ),
            ),
            Row(
              children: [
                SvgPicture.asset(
                  "assets/ic_vector_explore_active.svg",
                  width: 20,
                  height: 20,
                ),
                SizedBox(width: 4),
                GestureDetector(
                  onTap: () {
                    _navigateToNextPage();
                  },
                  child: Row(
                    children: [
                      Text(
                        'New York, USA',
                        style: TextStyle(
                          fontFamily: 'inter_semibold',
                          fontSize: 16,
                          color: grey_181a19,
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down, color: grey_181a19),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNotificationIcon() {
    return Stack(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey.shade200,
          child: Icon(Icons.notifications_none, color: Colors.black),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: mainColor, shape: BoxShape.circle),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchAndFilter() {
    return SizedBox(
      height: 42,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 300),
                    pageBuilder: (_, __, ___) => SearchPage(),
                    // your second page
                    transitionsBuilder: (_, animation, __, child) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(1, 0), // from right to left
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: AbsorbPointer(
                child: TextField(
                  readOnly: true,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'inter_medium',
                    color: grey_1A1C1E,
                  ),
                  decoration: InputDecoration(
                    // [same decoration as yours]
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 4),
                      child: SvgPicture.asset(
                        "assets/ic_vector_search.svg",
                        width: 20,
                        height: 20,
                      ),
                    ),
                    prefixIconConstraints: BoxConstraints(
                      minWidth: 36,
                      minHeight: 36,
                    ),
                    hintText: "Find your favorite salon",
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontFamily: 'inter_medium',
                      color: grey_C4CADA,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 8,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: mainColor, width: 1),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: SvgPicture.asset(
                "assets/ic_vector_filter.svg",
                width: 18,
                height: 18,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopRatedSalon() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Top Rated Salons',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                // Handle See All
              },
              child: Text('See All', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),

        // Horizontal list of cards
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: salons.length,
            itemBuilder: (context, index) {
              final salon = salons[index];
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: GestureDetector(
                  onTap: () {
                    _navigateToDetailsPage();
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: 180,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Image.asset(
                                salon['image'],
                                width: 180,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.white70,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.favorite_border,
                                    size: 18,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 8,
                                left: 8,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                        size: 16,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        salon['rating'].toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  salon['name'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.grey,
                                      size: 14,
                                    ),
                                    SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        salon['location'],
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _navigateToNextPage() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder:
            (context, animation, secondaryAnimation) => LocationSearchScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(1.0, 0.0);
          var end = Offset.zero;
          var curve = Curves.ease;

          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadSavedLocation(); // call the async function
  }

  Future<void> loadSavedLocation() async {
    final prefs = await SharedPreferences.getInstance();
    final location = prefs.getString(
      'formatted_address',
    ); // or 'location' if you saved with that key
    final latitude = prefs.getDouble('latitude');
    final longitude = prefs.getDouble('longitude');

    print("Saved Address: $location");
    print("Saved Latitude: $latitude");
    print("Saved Longitude: $longitude");
  }

  void _navigateToDetailsPage() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder:
            (context, animation, secondaryAnimation) => SalonDetailsScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(1.0, 0.0);
          var end = Offset.zero;
          var curve = Curves.ease;

          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }
}
