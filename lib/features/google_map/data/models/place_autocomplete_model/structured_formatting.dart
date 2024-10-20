import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'main_text_matched_substring.dart';

class StructuredFormatting extends Equatable {
	final String? mainText;
	final List<MainTextMatchedSubstring>? mainTextMatchedSubstrings;
	final String? secondaryText;

	const StructuredFormatting({
		this.mainText, 
		this.mainTextMatchedSubstrings, 
		this.secondaryText, 
	});

	factory StructuredFormatting.fromMap(Map<String, dynamic> data) {
		return StructuredFormatting(
			mainText: data['main_text'] as String?,
			mainTextMatchedSubstrings: (data['main_text_matched_substrings'] as List<dynamic>?)
						?.map((e) => MainTextMatchedSubstring.fromMap(e as Map<String, dynamic>))
						.toList(),
			secondaryText: data['secondary_text'] as String?,
		);
	}



	Map<String, dynamic> toMap() => {
				'main_text': mainText,
				'main_text_matched_substrings': mainTextMatchedSubstrings?.map((e) => e.toMap()).toList(),
				'secondary_text': secondaryText,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [StructuredFormatting].
	factory StructuredFormatting.fromJson(String data) {
		return StructuredFormatting.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [StructuredFormatting] to a JSON string.
	String toJson() => json.encode(toMap());

	StructuredFormatting copyWith({
		String? mainText,
		List<MainTextMatchedSubstring>? mainTextMatchedSubstrings,
		String? secondaryText,
	}) {
		return StructuredFormatting(
			mainText: mainText ?? this.mainText,
			mainTextMatchedSubstrings: mainTextMatchedSubstrings ?? this.mainTextMatchedSubstrings,
			secondaryText: secondaryText ?? this.secondaryText,
		);
	}

	@override
	bool get stringify => true;

	@override
	List<Object?> get props {
		return [
				mainText,
				mainTextMatchedSubstrings,
				secondaryText,
		];
	}
}
