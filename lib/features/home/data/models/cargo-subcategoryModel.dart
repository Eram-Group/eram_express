import 'dart:convert';

import 'package:flutter/widgets.dart';

class CargoSubCategoryModel {
  final int id;
  final int? category;
  final String nameAr;
  final String nameEn;
  final String capacity;
  final String image;
  CargoSubCategoryModel({
    required this.id,
    this.category,
    required this.nameAr,
    required this.nameEn,
    required this.capacity,
    required this.image,
  });

  CargoSubCategoryModel copyWith({
    int? id,
    ValueGetter<int?>? category,
    String? nameAr,
    String? nameEn,
    String? capacity,
    String? image,
  }) {
    return CargoSubCategoryModel(
      id: id ?? this.id,
      category: category != null ? category() : this.category,
      nameAr: nameAr ?? this.nameAr,
      nameEn: nameEn ?? this.nameEn,
      capacity: capacity ?? this.capacity,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'nameAr': nameAr,
      'nameEn': nameEn,
      'capacity': capacity,
      'image': image,
    };
  }

  factory CargoSubCategoryModel.fromMap(Map<String, dynamic> map) {
    return CargoSubCategoryModel(
      id: map['id']?.toInt() ?? 0,
      category: map['category']?.toInt(),
      nameAr: map['nameAr'] ?? '',
      nameEn: map['nameEn'] ?? '',
      capacity: map['capacity'] ?? '',
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CargoSubCategoryModel.fromJson(String source) => CargoSubCategoryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CargoSubCategoryModel(id: $id, category: $category, nameAr: $nameAr, nameEn: $nameEn, capacity: $capacity, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CargoSubCategoryModel &&
      other.id == id &&
      other.category == category &&
      other.nameAr == nameAr &&
      other.nameEn == nameEn &&
      other.capacity == capacity &&
      other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      category.hashCode ^
      nameAr.hashCode ^
      nameEn.hashCode ^
      capacity.hashCode ^
      image.hashCode;
  }
}
