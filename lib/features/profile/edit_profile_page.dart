import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/theme/colors.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Your Profile",
          style: TextStyle(
            fontFamily: 'inter_bold',
            fontSize: 20,
          ),
        ),
        backgroundColor: mainColor,
        foregroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  const CircleAvatar(
                    radius: 52,
                    backgroundImage: AssetImage("assets/profile.jpg"),
                  ),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: mainColor,
                    child: const Icon(Icons.edit, color: Colors.white, size: 18),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            buildLabel("Full Name"),
            const CustomTextField(
              hintText: "Esther Howard",
              icon: Icons.person,
            ),
            const SizedBox(height: 20),

            buildLabel("Phone Number"),
            Row(
              children: [
                const Expanded(
                  child: CustomTextField(
                    hintText: "603.555.0123",
                    icon: Icons.phone,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text("Change", style: TextStyle(color: mainColor)),
                ),
              ],
            ),
            const SizedBox(height: 20),

            buildLabel("Email"),
            const CustomTextField(
              hintText: "example@gmail.com",
              icon: Icons.email,
            ),
            const SizedBox(height: 20),

            buildLabel("Date of Birth"),
            const CustomTextField(
              hintText: "DD/MM/YY",
              icon: Icons.calendar_today,
            ),
            const SizedBox(height: 20),

            buildLabel("Gender"),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: null,
                  hint: const Text(
                    "Select Gender",
                    style: TextStyle(fontFamily: 'inter_medium'),
                  ),
                  isExpanded: true,
                  items: ["Male", "Female", "Other"].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (val) {
                    // Handle gender change
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

          ],
        ),
      ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                // Handle update logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Update Profile",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontFamily: 'inter_medium',
                ),
              ),
            ),
          ),
        ),

    );
  }

  Widget buildLabel(String label) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(
      label,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        fontFamily: 'inter_medium',
        color: Colors.black87,
      ),
    ),
  );
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData? icon;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: mainColor,
      style: const TextStyle(
        fontFamily: 'inter_medium',
        fontSize: 15,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        prefixIcon: icon != null
            ? Icon(icon, size: 20, color: Colors.grey[600])
            : null,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[500]),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: mainColor, width: 1.5),
        ),
      ),
    );
  }
}
