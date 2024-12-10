import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'cargo-categoriesModel.dart';
import 'goods-typeModel.dart';

class HomeModel {
  final List<CargoCategoryModel> categories;
  final List<GoodModel> goods;
  HomeModel({
    required this.categories,
    required this.goods,
  });

  HomeModel copyWith({
    List<CargoCategoryModel>? categories,
    List<GoodModel>? goods,
  }) {
    return HomeModel(
      categories: categories ?? this.categories,
      goods: goods ?? this.goods,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'categories': categories.map((x) => x.toMap()).toList(),
      'goods': goods.map((x) => x.toMap()).toList(),
    };
  }

  factory HomeModel.fromMap(Map<String, dynamic> map) {
    return HomeModel(
      categories: List<CargoCategoryModel>.from(
          map['categories']?.map((x) => CargoCategoryModel.fromMap(x))),
      goods: List<GoodModel>.from(
          map['supportedGoodsTypes']?.map((x) => GoodModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeModel.fromJson(String source) =>
      HomeModel.fromMap(json.decode(source));

  @override
  String toString() => 'HomeModel(categories: $categories, goods: $goods)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeModel &&
        listEquals(other.categories, categories) &&
        listEquals(other.goods, goods);
  }

  @override
  int get hashCode => categories.hashCode ^ goods.hashCode;
}
