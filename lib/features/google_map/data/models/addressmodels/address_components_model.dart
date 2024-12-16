import 'dart:convert';

import 'package:flutter/foundation.dart';

class AddressComponent {
  final String longName;
  final String shortName;
  final List<String> types;
  AddressComponent({
    required this.longName,
    required this.shortName,
    required this.types,
  });

  

  AddressComponent copyWith({
    String? longName,
    String? shortName,
    List<String>? types,
  }) {
    return AddressComponent(
      longName: longName ?? this.longName,
      shortName: shortName ?? this.shortName,
      types: types ?? this.types,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'longName': longName,
      'shortName': shortName,
      'types': types,
    };
  }


  factory AddressComponent.fromMap(Map<String, dynamic> map) {
    return AddressComponent(
      longName: map['long_name'],
      shortName: map['short_name'],
      types: List<String>.from(map['types']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressComponent.fromJson(String source) => AddressComponent.fromMap(json.decode(source));

  @override
  String toString() => 'AddressComponent(longName: $longName, shortName: $shortName, types: $types)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AddressComponent &&
      other.longName == longName &&
      other.shortName == shortName &&
      listEquals(other.types, types);
  }

  @override
  int get hashCode => longName.hashCode ^ shortName.hashCode ^ types.hashCode;
}
