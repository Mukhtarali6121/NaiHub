import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/theme/colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontSize: 20, fontFamily: 'inter_semibold'),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            // User Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: SvgPicture.asset(
                        "assets/ic_vector_congratulation.svg",
                        width: 36, // Adjust to fit well inside the circle
                        height: 36,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Esther Howard',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'inter_semibold',
                            color: white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '1.5k Followers  |  235 Following',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'inter_semibold',
                            color: lightGreyColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 16,
                  ),
                ],
              ),
            ),

            // Menu Items
            const ProfileMenuItem(
              icon: Icons.person_outline,
              title: 'Your profile',
            ),
            const ProfileMenuItem(
              icon: Icons.credit_card_outlined,
              title: 'Payment Methods',
            ),
            const ProfileMenuItem(icon: Icons.favorite_border, title: 'Saved'),
            const ProfileMenuItem(
              icon: Icons.settings_outlined,
              title: 'Settings',
            ),
            const ProfileMenuItem(
              icon: Icons.compare_arrows_outlined,
              title: 'Transactions',
            ),
            const ProfileMenuItem(
              icon: Icons.help_outline,
              title: 'Help Center',
            ),
            const ProfileMenuItem(
              icon: Icons.lock_outline,
              title: 'Privacy Policy',
            ),
            const ProfileMenuItem(icon: Icons.logout, title: 'Log out'),
          ],
        ),
      ),
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const ProfileMenuItem({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: mainColor),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'inter_medium',
          color: black,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: mainColor),
      onTap: () {
        // Add navigation or action here
      },
    );
  }
}
