

import 'dart:convert';

import 'package:equatable/equatable.dart';

class PlaceAutocompleteModel  {
  final String description;
  final String placeId;
  PlaceAutocompleteModel({
    required this.description,
    required this.placeId,
  });
  



  PlaceAutocompleteModel copyWith({
    String? description,
    String? placeId,
  }) {
    return PlaceAutocompleteModel(
      description: description ?? this.description,
      placeId: placeId ?? this.placeId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'placeId': placeId,
    };
  }

  factory PlaceAutocompleteModel.fromMap(Map<String, dynamic> map) {
    return PlaceAutocompleteModel(
      description: map['description'] as String,
      placeId: map['place_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaceAutocompleteModel.fromJson(String source) => PlaceAutocompleteModel.fromMap(json.decode(source));

  @override
  String toString() => 'PlaceAutocompleteModel(description: $description, placeId: $placeId)';

}


