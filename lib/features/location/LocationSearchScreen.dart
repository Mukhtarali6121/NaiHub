import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:nai_hub/features/location/LocationListTile.dart';
import 'package:nai_hub/features/location/PlacesAutocompleteResponse.dart';
import 'package:nai_hub/features/location/autocomplete_predicitons.dart';
import 'package:nai_hub/utils/network_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/theme/colors.dart';

class LocationSearchScreen extends StatefulWidget {
  @override
  _LocationSearchScreenState createState() => _LocationSearchScreenState();
}

class _LocationSearchScreenState extends State<LocationSearchScreen> {
  TextEditingController _searchController = TextEditingController();
  String searchText = "Golden Avenue";
  String? _currentAddress;
  Position? _currentPosition;
  bool isLoading = false;
  List<AutocompletePrediction> placePredicitons = [];
  Timer? _debounce;

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(Duration(milliseconds: 500), () {
      if (query.isNotEmpty) {
        placeAutoComplete(query);
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          placePredicitons.clear();
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  void clearSearch() {
    setState(() {
      searchText = '';
      _searchController.clear();
    });
  }

  void useCurrentLocation() {
    print("Using current location...");
  }

  void onSelectSearchResult() {
    print("Selected: Golden Avenue");
  }

  Widget _buildToolbar() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: _circleIcon(Icons.arrow_back, Colors.grey.shade300),
        ),
        Expanded(
          child: Center(
            child: GestureDetector(
              onTap: () {},
              child: Text(
                "Enter Your Location",
                style: TextStyle(fontSize: 20, fontFamily: 'inter_semibold'),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0,
          child: _circleIcon(Icons.arrow_back, Colors.transparent),
        ),
      ],
    );
  }

  Widget _circleIcon(IconData icon, Color borderColor) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor),
      ),
      child: Icon(icon, size: 20),
    );
  }

  Widget _buildCurrentLocationTile() {
    return GestureDetector(
      onTap: _onLocationTap,
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/ic_vector_location_arrow.svg",
            width: 18,
            height: 18,
          ),
          SizedBox(width: 14),
          Text(
            "Use my current location",
            style: TextStyle(fontSize: 18, fontFamily: 'inter_semibold'),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResultSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "SEARCH RESULT",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontFamily: 'inter_semibold',
          ),
        ),
        SizedBox(height: 12),
        Expanded(
          child: ListView.builder(
            itemCount: placePredicitons.length,
            itemBuilder: (context, index) {
              final location = placePredicitons[index].description!;
              final prediction = placePredicitons[index];

              final title =
                  prediction.structuredFormatting?.mainText ??
                  prediction.description ??
                  '';
              final description =
                  prediction.structuredFormatting?.secondaryText ?? '';

              return LocationListTile(
                title: title,
                description: description,
                press: (selectedLocation) {
                  // Do something with selectedLocation
                  print("User selected: $selectedLocation");
                  final selectedPrediction =
                      placePredicitons[index]; // ✅ Fixed here
                  fetchPlaceDetails(
                    selectedPrediction.placeId!,
                  ); // Now it works
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            isLoading = true;
          });
          _onSearchChanged(value);
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Search Location",
          hintStyle: TextStyle(
            fontSize: 16,
            fontFamily: 'inter_medium',
            color: grey_C4CADA,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 8, right: 4),
            child: SvgPicture.asset(
              "assets/ic_vector_search.svg",
              width: 20,
              height: 20,
            ),
          ),
          prefixIconConstraints: BoxConstraints(minWidth: 36, minHeight: 36),
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 14),
          suffixIcon:
              isLoading
                  ? Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(mainColor),
                      ),
                    ),
                  )
                  : IconButton(
                    icon: Icon(Icons.close, color: mainColor),
                    onPressed: () {
                      setState(() {
                        _searchController.clear();
                        placePredicitons.clear();
                      });
                    },
                  ),
        ),
      ),
    );
  }

  Future<void> _onLocationTap() async {
    await _getCurrentPosition();
  }

  Future<void> _getCurrentPosition() async {
    if (!await _handleLocationPermission()) return;

    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() => _currentPosition = position);
      print("Current Position: $_currentPosition");
      await _getAddressFromLatLng(position);
    } catch (e) {
      debugPrint('Error getting current position: $e');
    }
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    try {
      final address = await _getAddressFromGoogleAPI(
        position,
        "AIzaSyAkgDjrJaStX5_ZratE9tQHbdWO0Znmwe8",
      );

      if (address != null) {
        setState(() => _currentAddress = address);
        print("Google Address: $_currentAddress");
      } else {
        final placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        if (placemarks.isNotEmpty) {
          final place = placemarks[0];
          final fallbackAddress =
              '${place.name}, ${place.street}, ${place.subLocality}, ${place.locality}, '
              '${place.postalCode}, ${place.country}';
          setState(() => _currentAddress = fallbackAddress);
          print("Fallback Address: $_currentAddress");
        }
      }
    } catch (e) {
      debugPrint('Error in reverse geocoding: $e');
    }
  }

  Future<String?> _getAddressFromGoogleAPI(
    Position position,
    String apiKey,
  ) async {
    try {
      final url = Uri.parse(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$apiKey",
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK') {
          return data['results'][0]['formatted_address'];
        }
      }
    } catch (e) {
      debugPrint("Google API error: $e");
    }
    return null;
  }

  Future<bool> _handleLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Location permission is denied')),
        );
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location permissions are permanently denied')),
      );
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildToolbar(),
              SizedBox(height: 20),
              _buildSearchBar(),
              SizedBox(height: 24),
              _buildCurrentLocationTile(),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 8),
              if (placePredicitons.isNotEmpty)
                Expanded(child: _buildSearchResultSection()),
            ],
          ),
        ),
      ),
    );
  }

  void placeAutoComplete(String query) async {
    Uri uri = Uri.https(
      "maps.googleapis.com",
      'maps/api/place/autocomplete/json',
      {
        "input": query,
        "key": "AIzaSyAkgDjrJaStX5_ZratE9tQHbdWO0Znmwe8",
        "components": "country:in|country:fr",
        // Optional: restrict to countries
      },
    );

    String? response = await NetworkUtility.fetchUrl(uri);
    if (response != null) {
      PlacesAutocompleteResponse result =
          PlacesAutocompleteResponse.parseAutocompleteResult(response);
      if (result.predictions != null) {
        setState(() {
          placePredicitons = result.predictions!;
        });
      }
    }
  }

  Future<void> fetchPlaceDetails(String placeId) async {
    final Uri uri = Uri.https(
      "maps.googleapis.com",
      "maps/api/place/details/json",
      {
        "place_id": placeId,
        "key": "AIzaSyAkgDjrJaStX5_ZratE9tQHbdWO0Znmwe8",
        // your API key
        "fields": "formatted_address,geometry",
        // you can add more fields if needed
      },
    );

    final response = await NetworkUtility.fetchUrl(uri);
    if (response != null) {
      final data = json.decode(response);

      if (data['status'] == 'OK') {
        final result = data['result'];
        final formattedAddress = result['formatted_address'];
        final lat = result['geometry']['location']['lat'];
        final lng = result['geometry']['location']['lng'];

        print("Address: $formattedAddress");
        print("Latitude: $lat");
        print("Longitude: $lng");

        // Save to SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('location', placeId);
        await prefs.setDouble('latitude', lat);
        await prefs.setDouble('longitude', lng);
      } else {
        print("Error fetching place details: ${data['status']}");
      }
    }
  }
}
