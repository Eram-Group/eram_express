import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'prediction.dart';

class PlaceAutocompleteModel extends Equatable 
{
	final List<Prediction>? predictions;
	const PlaceAutocompleteModel({this.predictions});

	factory PlaceAutocompleteModel.fromMap(Map<String, dynamic> data) 
  {
		return PlaceAutocompleteModel
    (
			predictions: (data['predictions'] as List<dynamic>?)
						?.map((e) => Prediction.fromMap(e as Map<String, dynamic>))
						.toList(),
		);
	}
	Map<String, dynamic> toMap() => 
  {
				'predictions': predictions?.map((e) => e.toMap()).toList(),
			
	};


	factory PlaceAutocompleteModel.fromJson(String data) {
		return PlaceAutocompleteModel.fromMap(json.decode(data) as Map<String, dynamic>);
	}
 
	String toJson() => json.encode(toMap());

	PlaceAutocompleteModel copyWith({
		List<Prediction>? predictions,
		String? status,
	}) {
		return PlaceAutocompleteModel(
			predictions: predictions ?? this.predictions,
	
		);
	}

	@override
	bool get stringify => true;

	@override
	List<Object?> get props => [predictions,];
}
