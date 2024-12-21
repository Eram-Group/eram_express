import 'dart:convert';

import 'package:equatable/equatable.dart';

class GoodModel {
  final int id;
  final String nameAr;
  final String nameEn;
  final String image;
  GoodModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.image,
  });

  GoodModel copyWith({
    int? id,
    String? nameAr,
    String? nameEn,
    String? image,
  }) {
    return GoodModel(
      id: id ?? this.id,
      nameAr: nameAr ?? this.nameAr,
      nameEn: nameEn ?? this.nameEn,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nameAr': nameAr,
      'nameEn': nameEn,
      'image': image,
    };
  }

  factory GoodModel.fromMap(Map<String, dynamic> map) {
    return GoodModel(
      id: map['id']?.toInt() ?? 0,
      nameAr: map['nameAr'] ?? '',
      nameEn: map['nameEn'] ?? '',
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory GoodModel.fromJson(String source) => GoodModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GoodModel(id: $id, nameAr: $nameAr, nameEn: $nameEn, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is GoodModel &&
      other.id == id &&
      other.nameAr == nameAr &&
      other.nameEn == nameEn &&
      other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      nameAr.hashCode ^
      nameEn.hashCode ^
      image.hashCode;
  }
}
