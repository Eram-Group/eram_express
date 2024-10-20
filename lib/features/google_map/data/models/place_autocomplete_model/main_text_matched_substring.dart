import 'dart:convert';

import 'package:equatable/equatable.dart';

class MainTextMatchedSubstring extends Equatable {
	final int? length;
	final int? offset;

	const MainTextMatchedSubstring({this.length, this.offset});

	factory MainTextMatchedSubstring.fromMap(Map<String, dynamic> data) {
		return MainTextMatchedSubstring(
			length: data['length'] as int?,
			offset: data['offset'] as int?,
		);
	}



	Map<String, dynamic> toMap() => {
				'length': length,
				'offset': offset,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MainTextMatchedSubstring].
	factory MainTextMatchedSubstring.fromJson(String data) {
		return MainTextMatchedSubstring.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [MainTextMatchedSubstring] to a JSON string.
	String toJson() => json.encode(toMap());

	MainTextMatchedSubstring copyWith({
		int? length,
		int? offset,
	}) {
		return MainTextMatchedSubstring(
			length: length ?? this.length,
			offset: offset ?? this.offset,
		);
	}

	@override
	bool get stringify => true;

	@override
	List<Object?> get props => [length, offset];
}
