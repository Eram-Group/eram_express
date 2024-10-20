import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'matched_substring.dart';
import 'structured_formatting.dart';
import 'term.dart';

class Prediction extends Equatable {
	final String? description;
	final List<MatchedSubstring>? matchedSubstrings;
	final String? placeId;
	final String? reference;
	final StructuredFormatting? structuredFormatting;
	final List<Term>? terms;
	final List<String>? types;

	const Prediction({
		this.description, 
		this.matchedSubstrings, 
		this.placeId, 
		this.reference, 
		this.structuredFormatting, 
		this.terms, 
		this.types, 
	});

	factory Prediction.fromMap(Map<String, dynamic> data) => Prediction(
				description: data['description'] as String?,
        /*
				matchedSubstrings: (data['matched_substrings'] as List<dynamic>?)
						?.map((e) => MatchedSubstring.fromMap(e as Map<String, dynamic>))
						.toList(),
            */
				placeId: data['place_id'] as String?,
				reference: data['reference'] as String?,
				structuredFormatting: data['structured_formatting'] == null
						? null
						: StructuredFormatting.fromMap(data['structured_formatting'] as Map<String, dynamic>),
				terms: (data['terms'] as List<dynamic>?)
						?.map((e) => Term.fromMap(e as Map<String, dynamic>))
						.toList(),
				types: data['types'] as List<String>?,
			);

	Map<String, dynamic> toMap() => {
				'description': description,
				//'matched_substrings': matchedSubstrings?.map((e) => e.toMap()).toList(),
				'place_id': placeId,
				'reference': reference,
				'structured_formatting': structuredFormatting?.toMap(),
				'terms': terms?.map((e) => e.toMap()).toList(),
				'types': types,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Prediction].
	factory Prediction.fromJson(String data) {
		return Prediction.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [Prediction] to a JSON string.
	String toJson() => json.encode(toMap());

	Prediction copyWith({
		String? description,
		List<MatchedSubstring>? matchedSubstrings,
		String? placeId,
		String? reference,
		StructuredFormatting? structuredFormatting,
		List<Term>? terms,
		List<String>? types,
	}) {
		return Prediction(
			description: description ?? this.description,
			matchedSubstrings: matchedSubstrings ?? this.matchedSubstrings,
			placeId: placeId ?? this.placeId,
			reference: reference ?? this.reference,
			structuredFormatting: structuredFormatting ?? this.structuredFormatting,
			terms: terms ?? this.terms,
			types: types ?? this.types,
		);
	}

	@override
	bool get stringify => true;

	@override
	List<Object?> get props {
		return [
				description,
				matchedSubstrings,
				placeId,
				reference,
				structuredFormatting,
				terms,
				types,
		];
	}
}
