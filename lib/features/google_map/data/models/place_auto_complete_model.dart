

import 'package:equatable/equatable.dart';

class PlaceAutocompleteModel extends Equatable {
  final String description;
  final String placeId;

  const PlaceAutocompleteModel({required this.description, required this.placeId});

  factory PlaceAutocompleteModel.fromjson(Map<String, dynamic> data) {
    return PlaceAutocompleteModel(
      description: data['description'] as String,
      placeId: data['place_id'] as String,
    );
  }



  @override
  List<Object?> get props => [description, placeId];
  @override
  bool get stringify => true;
}