import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LocationListTile extends StatelessWidget {
  const LocationListTile({
    Key? key,
    required this.title,
    required this.description,
    required this.press,
  }) : super(key: key);

  final String title;
  final String description;
  final void Function(String) press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        press(title);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                "assets/ic_vector_location_arrow.svg",
                width: 15,
                height: 15,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  title,
                  style: TextStyle(fontFamily: 'inter_semibold', fontSize: 17),
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
              fontFamily: 'inter_medium',
            ),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 18),
        ],
      ),
    );
  }
}
