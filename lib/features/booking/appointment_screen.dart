import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nai_hub/utils/theme/colors.dart';

class AppointmentScreen extends StatefulWidget {
  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  int selectedDateIndex = 0;
  int selectedTimeIndex = 0;
  int selectedSpecialistIndex = 0;

  List<Map<String, String>> get upcomingDays {
    return List.generate(15, (index) {
      final date = DateTime.now().add(Duration(days: index));
      return {
        'day': index == 0 ? 'Today' : DateFormat.E().format(date), // e.g., Mon
        'date': DateFormat('d MMM').format(date), // e.g., 30 May
      };
    });
  }

  final times = [
    '7:00 PM',
    '7:30 PM',
    '8:00 PM',
    '7:30 PM',
    '8:00 PM',
    '7:30 PM',
    '8:00 PM',
    '7:30 PM',
    '8:00 PM',
    '7:30 PM',
    '8:00 PM',
  ];
  List<Map<String, String>> specialists = [
    {
      'name': 'Ayesha Malik',
      'specialty': 'Hair Stylist',
      'image':
          'https://media.istockphoto.com/id/1301956338/photo/dermatologist-doctor-checking-woman-hair-for-dandruff.jpg?s=612x612&w=0&k=20&c=FXTTCfvKJRmmNfNyoWsDo8BdZlsgYvMLPD2O9emkUmc=',
    },
    {
      'name': 'Zara Khan',
      'specialty': 'Makeup Artist',
      'image':
          'https://media.istockphoto.com/id/1301956338/photo/dermatologist-doctor-checking-woman-hair-for-dandruff.jpg?s=612x612&w=0&k=20&c=FXTTCfvKJRmmNfNyoWsDo8BdZlsgYvMLPD2O9emkUmc=',
    },
    {
      'name': 'Sana Ali',
      'specialty': 'Nail Technician',
      'image':
          'https://media.istockphoto.com/id/1301956338/photo/dermatologist-doctor-checking-woman-hair-for-dandruff.jpg?s=612x612&w=0&k=20&c=FXTTCfvKJRmmNfNyoWsDo8BdZlsgYvMLPD2O9emkUmc=',
    },
    {
      'name': 'Hira Sheikh',
      'specialty': 'Facial Expert',
      'image':
          'https://media.istockphoto.com/id/1301956338/photo/dermatologist-doctor-checking-woman-hair-for-dandruff.jpg?s=612x612&w=0&k=20&c=FXTTCfvKJRmmNfNyoWsDo8BdZlsgYvMLPD2O9emkUmc=',
    },
    {
      'name': 'Mariam Raza',
      'specialty': 'Henna Artist',
      'image':
          'https://media.istockphoto.com/id/1301956338/photo/dermatologist-doctor-checking-woman-hair-for-dandruff.jpg?s=612x612&w=0&k=20&c=FXTTCfvKJRmmNfNyoWsDo8BdZlsgYvMLPD2O9emkUmc=',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        // <-- Add this line
        title: Text(
          'Book Appointment',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'inter_bold',
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Date",
              style: TextStyle(fontSize: 18, fontFamily: 'inter_bold'),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: upcomingDays.length,
                itemBuilder: (context, index) {
                  final isSelected = selectedDateIndex == index;
                  final day = upcomingDays[index]['day']!;
                  final date = upcomingDays[index]['date']!;
                  return GestureDetector(
                    onTap: () => setState(() => selectedDateIndex = index),
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? mainColor : Colors.white,
                        borderRadius: BorderRadius.circular(26),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            day,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                              fontFamily: 'inter_medium',
                              fontSize: isSelected ? 15 : 13,
                            ),
                          ),
                          Text(
                            date,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                              fontFamily: 'inter_semibold',
                              fontSize: isSelected ? 16 : 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Select Time",
              style: TextStyle(fontSize: 18, fontFamily: 'inter_bold'),
            ),
            SizedBox(height: 10),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 4,
              crossAxisSpacing: 5,
              mainAxisSpacing: 10,
              childAspectRatio: 1.8,
              // Adjust for button shape
              physics: NeverScrollableScrollPhysics(),
              // so it scrolls with the main page
              children: List.generate(times.length, (index) {
                final isSelected = selectedTimeIndex == index;
                return GestureDetector(
                  onTap: () => setState(() => selectedTimeIndex = index),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected ? mainColor : Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Text(
                      times[index],
                      style: TextStyle(
                        fontFamily: 'inter_semibold',
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 20),
            Text(
              "Select Specialist",
              style: TextStyle(fontSize: 18, fontFamily: 'inter_bold'),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 180, // Increased to fit text below image
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: specialists.length,
                separatorBuilder: (context, index) => SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final isSelected = selectedSpecialistIndex == index;
                  final specialist = specialists[index];

                  return GestureDetector(
                    onTap:
                        () => setState(() => selectedSpecialistIndex = index),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 100,
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: NetworkImage(specialist['image']!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            if (isSelected)
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: mainColor,
                                  ),
                                  padding: EdgeInsets.all(2),
                                  child: Icon(
                                    Icons.check,
                                    size: 22,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          specialist['name']!,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'inter_semibold',
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          _truncateText(specialist['specialty']!, 20),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontFamily: 'inter_medium',
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: mainColor,
            padding: EdgeInsets.symmetric(horizontal: 100, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: () {
            showBookingConfirmationDialog(context);
          },
          child: Text(
            "Book Appointment",
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'inter_bold',
              color: white,
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> showBookingConfirmationDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder:
          (_) => AlertDialog(
            backgroundColor: white,
            title: Text(
              "Confirm Booking",
              style: TextStyle(fontFamily: 'inter_bold', fontSize: 22),
            ),
            content: Text(
              "Do you want to book this appointment?",
              style: TextStyle(fontFamily: 'inter_medium', fontSize: 15),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                // return false on cancel
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    fontFamily: 'inter_medium',
                    fontSize: 15,
                    color: mainColor,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainColor, // Replace with your desired color
                ), // return true on confirm
                child: Text(
                  "Confirm",
                  style: TextStyle(
                    fontFamily: 'inter_bold',
                    fontSize: 15,
                    color: white,
                  ),
                ),
              ),
            ],
          ),
    );

    // If user dismisses the dialog by tapping outside, treat as cancel
    return result ?? false;
  }

  String _truncateText(String text, int maxLength) {
    return text.length <= maxLength
        ? text
        : '${text.substring(0, maxLength)}...';
  }
}
