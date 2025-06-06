import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/theme/colors.dart';

class BookingCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final String tabType;
  final bool remind;
  final ValueChanged<bool> onRemindChanged;

  BookingCard({
    required this.data,
    required this.tabType,
    required this.remind,
    required this.onRemindChanged,
  });

  @override
  Widget build(BuildContext context) {
    bool isUpcoming = tabType == 'upcoming';
    bool isCancelled = tabType == 'cancelled';

    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: lightGreyColor,
          width: 1,
        ),
      ),
      child: Card(
        color: white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      data['date'],
                      style: TextStyle(
                        fontFamily: 'inter_semibold',
                        fontSize: 13,
                        color: black_050700,
                      ),
                    ),
                  ),
                  if (isUpcoming)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Remind me",
                          style: TextStyle(
                            fontFamily: 'inter_semibold',
                            fontSize: 12,
                            color: grey_676763,
                          ),
                        ),
                        SizedBox(width: 4),
                        SizedBox(
                          width: 30,
                          height: 8,
                          child: Transform.scale(
                            scale: 0.55,
                            child: Switch(
                              value: remind,
                              onChanged: onRemindChanged,
                              activeColor: mainColor,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              SizedBox(height: 5),

              Divider(),
              SizedBox(height: 5),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12), // rounded square
                    child: Container(
                      alignment: Alignment.center,
                      constraints: const BoxConstraints(
                        maxWidth: 70,
                        maxHeight: 70,
                      ),
                      child: Image.asset(
                        data['image'],
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['title'],
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'inter_semibold',
                          ),
                        ),
                        SizedBox(height: 3),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/ic_vector_explore_active.svg",
                              width: 14,
                              height: 14,
                            ),
                            SizedBox(width: 2),
                            Text(
                              data['address'],
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'inter_medium',
                                color: grey_818282,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 3),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Service ID : ',
                                style: TextStyle(
                                  color: grey_818282,
                                  fontSize: 12,
                                  fontFamily: 'inter_medium',
                                ),
                              ),
                              TextSpan(
                                text: '${data['serviceId']}',
                                style: TextStyle(
                                  color: mainColor,
                                  fontSize: 12,
                                  fontFamily: 'inter_semibold',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  if (isUpcoming)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: mainColor),
                          foregroundColor: mainColor,
                        ),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontFamily: 'inter_bold',
                            color: mainColor,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  if (isCancelled)
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainColor,
                        ),
                        child: Text(
                          "Re-Book",
                          style: TextStyle(
                            fontFamily: 'inter_bold',
                            color: white,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  if (!isCancelled) ...[
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainColor,
                        ),
                        child: Text(
                          "View E-Receipt",
                          style: TextStyle(
                            fontFamily: 'inter_bold',
                            color: white,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
