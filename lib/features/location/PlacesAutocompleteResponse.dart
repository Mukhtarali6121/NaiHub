import 'dart:convert';

import 'autocomplete_predicitons.dart';

class PlacesAutocompleteResponse {
  final String? status;
  final List<AutocompletePrediction>? predictions;

  PlacesAutocompleteResponse({this.status, this.predictions});

  factory PlacesAutocompleteResponse.fromJson(Map<String, dynamic> json) {
    return PlacesAutocompleteResponse(
      status: json['status'] as String?,
      predictions:
          json['predictions'] != null
              ? json['predictions']
                  .map<AutocompletePrediction>(
                    (json) => AutocompletePrediction.fromJson(json),
                  )
                  .toList()
              : null,
    );
  }

  static PlacesAutocompleteResponse parseAutocompleteResult(
    String responseBody,
  ) {
    final parsed = json.decode(responseBody).cast<String, dynamic>();

    return PlacesAutocompleteResponse.fromJson(parsed);
  }
}
