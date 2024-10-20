import 'dart:convert';

import 'package:equatable/equatable.dart';

class Term extends Equatable {
	final int? offset;
	final String? value;

	const Term({this.offset, this.value});

	factory Term.fromMap(Map<String, dynamic> data) => Term(
				offset: data['offset'] as int?,
				value: data['value'] as String?,
			);

	Map<String, dynamic> toMap() => {
				'offset': offset,
				'value': value,
			};

  
	factory Term.fromJson(String data)
  {
		return Term.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  
	String toJson() => json.encode(toMap());
	Term copyWith({
		int? offset,
		String? value,
	}) {
		return Term(
			offset: offset ?? this.offset,
			value: value ?? this.value,
		);
	}

	@override
	bool get stringify => true;
	@override
	List<Object?> get props => [offset, value];
}
