import 'dart:convert';


class SupportTypeModel {
  final String value;
  final String label;
  SupportTypeModel({
    required this.value,
    required this.label,
  });


 

  SupportTypeModel copyWith({
    String? value,
    String? label,
  }) {
    return SupportTypeModel(
      value: value ?? this.value,
      label: label ?? this.label,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'label': label,
    };
  }

  factory SupportTypeModel.fromMap(Map<String, dynamic> map) {
    return SupportTypeModel(
      value: map['value'] ?? '',
      label: map['label'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SupportTypeModel.fromJson(String source) => SupportTypeModel.fromMap(json.decode(source));

  @override
  String toString() => 'SupportTypeModel(value: $value, label: $label)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SupportTypeModel &&
      other.value == value &&
      other.label == label;
  }

  @override
  int get hashCode => value.hashCode ^ label.hashCode;
}
