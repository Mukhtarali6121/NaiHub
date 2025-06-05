import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nai_hub/features/authentication/presentation/signin/SignIn.dart';
import 'package:nai_hub/utils/theme/colors.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      image: 'assets/salon1.png',
      title: 'Discover Nearby Beauty Havens',
      description: 'Unlock the beauty secrets hidden in your neighbourhood!',
    ),
    OnboardingPage(
      image: 'assets/salon2.png',
      title: 'Effortless Appointments Bookings',
      description:
          'Pick your dream salon, choose your preferred date, and secure your spot in a few taps',
    ),
    OnboardingPage(
      image: 'assets/salon3.png',
      title: 'Expert Stylists',
      description:
          'Get services from certified professionals with years of experience',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return SingleOnboardingPage(page: _pages[index]);
            },
          ),

          // Skip Button
          Positioned(
            top: 40,
            right: 20,
            child: Visibility(
              visible: _currentPage != _pages.length - 1,
              child: TextButton(
                onPressed: () {
                  _navigateToHomePage();
                },
                child: Text(
                  'Skip',
                  style: TextStyle(
                    fontSize: 18,
                    color: mainColor,
                    fontFamily: 'inter_semibold',
                  ),
                ),
              ),
            ),
          ),

          // Dots Indicator
          Positioned(
            bottom: 110,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicator(),
            ),
          ),

          // Navigation Buttons
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Row(
              children: [
                // Back Button
                if (_currentPage > 0)
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: mainColor, width: 2.0),
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 24,
                      child: Center(
                        // ensures icon is centered
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: mainColor,
                            size: 22,
                          ),
                          // bigger size
                          padding: EdgeInsets.zero,
                          // remove default padding
                          constraints: BoxConstraints(),
                          // remove extra space around icon
                          onPressed: () {
                            _pageController.previousPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                // Spacer for non-last pages
                if (_currentPage < _pages.length - 1)
                  Expanded(child: Container()),

                // Continue/Next Button
                if (_currentPage == _pages.length - 1)
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      // This aligns the child to the right
                      child: Padding(
                        padding: EdgeInsets.only(right: 0),
                        // Add some right padding
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: mainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                          ),
                          onPressed: () {
                            _navigateToHomePage();
                          },
                          child: Text(
                            'Get Started',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontFamily: 'inter_semibold',
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: mainColor,
                    child: IconButton(
                      icon: Icon(Icons.arrow_forward, color: Colors.white),
                      onPressed: () {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < _pages.length; i++) {
      indicators.add(
        Container(
          width: 9.5,
          height: 9.5,
          margin: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == i ? mainColor : Colors.grey.withOpacity(0.4),
          ),
        ),
      );
    }
    return indicators;
  }

  void _navigateToHomePage() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => SignIn(),
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

class OnboardingPage {
  final String image;
  final String title;
  final String description;

  OnboardingPage({
    required this.image,
    required this.title,
    required this.description,
  });
}

class SingleOnboardingPage extends StatelessWidget {
  final OnboardingPage page;

  SingleOnboardingPage({required this.page});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/ic_vector_congratulation.svg",
            width: 250,
            height: 250,
          ),
          SizedBox(height: 40),
          Text(
            page.title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: black,
              fontFamily: "inter_bold",
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            page.description,
            style: TextStyle(
              fontSize: 16,
              color: darkGreyColor,
              fontFamily: "inter_medium",
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
