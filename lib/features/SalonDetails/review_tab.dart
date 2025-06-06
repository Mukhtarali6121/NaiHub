import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/theme/colors.dart';

class ReviewTab extends StatefulWidget {
  const ReviewTab({super.key});

  @override
  State<ReviewTab> createState() => _ReviewTabState();
}

class _ReviewTabState extends State<ReviewTab> {
  final TextEditingController _searchController = TextEditingController();

  late List<bool> expandedStates;

  final List<ReviewModel> reviews = [
    ReviewModel(
      name: "Harish Natarajan",
      review:
          "Hands down the best luxury salon!\nNot sure where to start - right from answering all queries patiently",
      rating: 5,
      imageUrl:
          "https://unsplash.com/photos/closeup-photography-of-woman-smiling-mEZ3PoFGs_k",
    ),
    ReviewModel(
      name: "swe guru",
      review:
          "Heads-up for an amazing luxury Beauty salon experience!! 😄 Galleria10 is wonderful! I have been getting",
      rating: 5,
      imageUrl: null,
    ),
    ReviewModel(
      name: "swe guru",
      review:
          "Heads-up for an amazing luxury Beauty salon experience!! 😄 Galleria10 is wonderful! I have been getting",
      rating: 5,
      imageUrl: null,
    ),
    ReviewModel(
      name: "swe guru",
      review:
          "Heads-up for an amazing luxury Beauty salon experience!! 😄 Galleria10 is wonderful! I have been getting",
      rating: 5,
      imageUrl: null,
    ),
    ReviewModel(
      name: "swe guru",
      review:
          "Heads-up for an amazing luxury Beauty salon experience!! 😄 Galleria10 is wonderful! I have been getting",
      rating: 5,
      imageUrl: null,
    ),
    ReviewModel(
      name: "Jinsu",
      review:
          "It was a great service from Grace(pedicure), Salomi(hair coloring) and Wasim(Keratin Treatment). The",
      rating: 5,
      imageUrl: "https://via.placeholder.com/150",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        key: const ValueKey('reviews'),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_buildReviewsTitle(), _buildAddReviewButton()],
          ),
          const SizedBox(height: 0),
          _buildSearchBar(),
          // const SizedBox(height: 12),
          // _buildFilterChips(),
          const SizedBox(height: 4),
          _buildReviewsList(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintStyle: const TextStyle(
          fontSize: 16,
          fontFamily: 'inter_medium',
          color: grey_C4CADA,
        ),
        hintText: 'Search in reviews',
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0), // Adjust as needed
          child: SvgPicture.asset(
            "assets/ic_vector_search.svg",
            width: 16,
            height: 16,
            fit: BoxFit.contain,
          ),
        ),
        prefixIconConstraints: BoxConstraints(minWidth: 40, minHeight: 40),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: mainColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: mainColor, width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      ),
      onChanged: (query) {
        // TODO: Filter reviews list
      },
    );
  }

  Widget _buildAddReviewButton() {
    return TextButton.icon(
      onPressed: () {},
      icon: SvgPicture.asset(
        "assets/ic_vector_edit.svg",
        width: 21,
        height: 21,
      ),

      label: const Text(
        'add review',
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'inter_medium',
          color: mainColor,
        ),
      ),
    );
  }

  Widget _buildReviewsTitle() {
    return const Text(
      'Reviews',
      style: TextStyle(fontFamily: 'inter_bold', fontSize: 22),
    );
  }

  Widget _buildReviewsList() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          return buildReviewItem(
            reviews[index],
            index: index,
            showDivider: index != reviews.length - 1,
          );
        },
      ),
    );
  }

  Widget buildReviewItem(
    ReviewModel review, {
    required int index,
    bool showDivider = true,
  }) {
    final maxLength = 100;
    final isLongText = review.review.length > maxLength;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  review.imageUrl != null
                      ? CircleAvatar(
                        backgroundImage: NetworkImage(review.imageUrl!),
                      )
                      : CircleAvatar(child: Text(review.name[0].toUpperCase())),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.name,
                        style: const TextStyle(
                          fontFamily: 'inter_bold',
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        children: [
                          ...List.generate(
                            review.rating,
                            (index) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 14,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "${review.rating}",
                            style: const TextStyle(
                              fontFamily: 'inter_medium',
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap:
                    isLongText
                        ? () {
                          setState(() {
                            expandedStates[index] = !expandedStates[index];
                          });
                        }
                        : null,
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                    children: [
                      TextSpan(
                        text:
                            expandedStates[index]
                                ? review.review
                                : (isLongText
                                    ? '${review.review.substring(0, maxLength)}...'
                                    : review.review),
                        style: const TextStyle(
                          fontFamily: 'inter_medium',
                          fontSize: 12.5,
                          color: grey_676763
                        ),
                      ),
                      if (isLongText)
                        TextSpan(
                          text:
                              expandedStates[index]
                                  ? ' Show less'
                                  : ' Show more',
                          style: TextStyle(
                            color: mainColor,
                            fontSize: 12.5,
                            fontFamily: 'inter_semibold',
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider()
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    expandedStates = List.filled(reviews.length, false);
  }
}

class ReviewModel {
  final String name;
  final String review;
  final int rating;
  final String? imageUrl;

  ReviewModel({
    required this.name,
    required this.review,
    required this.rating,
    this.imageUrl,
  });
}
