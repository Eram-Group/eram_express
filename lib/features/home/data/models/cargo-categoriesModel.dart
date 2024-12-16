import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'cargo-subcategoryModel.dart';

class CargoCategoryModel {
  final int id;
  final String nameAr;
  final String nameEn;
  final String image;
  final List<CargoSubCategoryModel> subcategory;
  CargoCategoryModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.image,
    required this.subcategory,
  });

  CargoCategoryModel copyWith({
    int? id,
    String? nameAr,
    String? nameEn,
    String? image,
    List<CargoSubCategoryModel>? subcategory,
  }) {
    return CargoCategoryModel(
      id: id ?? this.id,
      nameAr: nameAr ?? this.nameAr,
      nameEn: nameEn ?? this.nameEn,
      image: image ?? this.image,
      subcategory: subcategory ?? this.subcategory,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nameAr': nameAr,
      'nameEn': nameEn,
      'image': image,
      'subcategory': subcategory.map((x) => x.toMap()).toList(),
    };
  }

  factory CargoCategoryModel.fromMap(Map<String, dynamic> map) {
    return CargoCategoryModel(
      id: map['id']?.toInt() ?? 0,
      nameAr: map['nameAr'] ?? '',
      nameEn: map['nameEn'] ?? '',
      image: map['image'] ?? '',
      subcategory: List<CargoSubCategoryModel>.from(
          map['subcategories']?.map((x) => CargoSubCategoryModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CargoCategoryModel.fromJson(String source) =>
      CargoCategoryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CargoCategoryModel(id: $id, nameAr: $nameAr, nameEn: $nameEn, image: $image, subcategory: $subcategory)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CargoCategoryModel &&
        other.id == id &&
        other.nameAr == nameAr &&
        other.nameEn == nameEn &&
        other.image == image &&
        listEquals(other.subcategory, subcategory);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nameAr.hashCode ^
        nameEn.hashCode ^
        image.hashCode ^
        subcategory.hashCode;
  }
}
