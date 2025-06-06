import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nai_hub/utils/theme/colors.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<String> displayedSalons = [];

  final List<String> allSalons = [
    'Salon Luxe',
    'Beauty Bar',
    'NaiHub',
    'Hair Craze',
    'The Hair Lab',
    'Style Studio',
    'Glamour Point',
  ];
  List<String> filteredSalons = [];

  List<String> categories = ['All', 'Salon', 'Spa', 'Nail', 'Massage'];
  String selectedCategory = 'All';

  Map<String, List<String>> categorySalons = {
    'Salon': ['Salon Luxe', 'Hair Craze', 'Style Studio', 'The Hair Lab'],
    'Spa': ['Beauty Bar'],
    'Nail': ['Glamour Point'],
    'Massage': [],
    'All': [
      'Salon Luxe',
      'Beauty Bar',
      'NaiHub',
      'Hair Craze',
      'The Hair Lab',
      'Style Studio',
      'Glamour Point',
    ],
  };

  @override
  void initState() {
    super.initState();
    filteredSalons = allSalons;
    _searchController.addListener(_onSearchChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) => _startListAnimation());
  }

  void _startListAnimation() async {
    displayedSalons.clear();
    for (int i = 0; i < filteredSalons.length; i++) {
      await Future.delayed(Duration(milliseconds: 100));
      displayedSalons.add(filteredSalons[i]);
      _listKey.currentState?.insertItem(displayedSalons.length - 1);
    }
  }

  void _onSearchChanged() {
    String query = _searchController.text.trim().toLowerCase();
    List<String> categoryFiltered =
        selectedCategory == 'All'
            ? allSalons
            : categorySalons[selectedCategory] ?? [];

    List<String> results =
        categoryFiltered
            .where((salon) => salon.toLowerCase().contains(query))
            .toList();

    setState(() {
      filteredSalons = results;
    });

    _startListAnimation();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            // Header with Search Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 24,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        autofocus: true,
                        cursorColor: mainColor,
                        decoration: InputDecoration(
                          hintText: 'Search salons',
                          hintStyle: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 16,
                            fontFamily: 'inter_medium',
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 12, right: 8),
                            child: SvgPicture.asset(
                              "assets/ic_vector_search.svg",
                              width: 25,
                              height: 25,
                            ),
                          ),
                          prefixIconConstraints: const BoxConstraints(
                            minWidth: 32,
                            minHeight: 32,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 14,
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'inter_semibold',
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                height: 36,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelected = selectedCategory == category;

                    return ChoiceChip(
                      label: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontFamily:
                              isSelected ? 'inter_bold' : 'inter_medium',
                        ),
                      ),
                      selected: isSelected,
                      onSelected: (_) {
                        setState(() {
                          selectedCategory = category;
                          _onSearchChanged();
                        });
                      },
                      selectedColor: mainColor,
                      backgroundColor: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Result Count or Placeholder
            if (_searchController.text.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${filteredSalons.length} result(s) found",
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ),
              ),

            const SizedBox(height: 4),

            // Results List
            Expanded(
              child:
                  filteredSalons.isNotEmpty
                      ? ListView.builder(
                        itemCount: filteredSalons.length,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        itemBuilder: (context, index) {
                          final salon = filteredSalons[index];
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.only(bottom: 14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              leading: CircleAvatar(
                                radius: 24,
                                backgroundColor: lightColor,
                                child: Icon(
                                  Icons.storefront_rounded,
                                  color: mainColor,
                                  size: 24,
                                ),
                              ),
                              title: Text(
                                salon,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'inter_medium',
                                  color: Colors.black87,
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Wrap(
                                  spacing: 6,
                                  runSpacing: -4,
                                  children: [
                                    _buildTag("Salon"),
                                    _buildTag("Hair"),
                                    _buildTag("4.5 ★"),
                                  ],
                                ),
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 18,
                                color: Colors.grey[400],
                              ),
                              onTap: () {
                                // Handle salon tap
                              },
                            ),
                          );
                        },
                      )
                      : Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.search_off_rounded,
                              size: 60,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'No salons found',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontFamily: 'inter_medium',
          color: Colors.grey[700],
        ),
      ),
    );
  }
}
