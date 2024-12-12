import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../../data/models/picking_locationModel.dart';


class BookingRequestFormData {
  final int? cargoSubcategory;
  final List<int> goods;
  final String bookingDate;
  final PickingLocationModel pickup;
  final PickingLocationModel destination;
  BookingRequestFormData({
    this.cargoSubcategory,
    required this.goods,
    required this.bookingDate,
    required this.pickup,
    required this.destination,
  });

 

  BookingRequestFormData copyWith({
    ValueGetter<int?>? cargoSubcategory,
    List<int>? goods,
    String? bookingDate,
    PickingLocationModel? pickup,
    PickingLocationModel? destination,
  }) {
    return BookingRequestFormData(
      cargoSubcategory: cargoSubcategory != null ? cargoSubcategory() : this.cargoSubcategory,
      goods: goods ?? this.goods,
      bookingDate: bookingDate ?? this.bookingDate,
      pickup: pickup ?? this.pickup,
      destination: destination ?? this.destination,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cargoSubcategory': cargoSubcategory,
      'goods': goods,
      'bookingDate': bookingDate,
      //'pickup': pickup.toMap(),
      //'destination': destination.toMap(),
      //this is only for temp
      "pickingLocation": {
        "type": "Point",
        "coordinates": [31.2357, 30.0444]
      },
      "destinationLocation": {
        "type": "Point",
        "coordinates": [31.1313, 29.9765]
      }
      
    };
  }

  factory BookingRequestFormData.fromMap(Map<String, dynamic> map) {
    return BookingRequestFormData(
      cargoSubcategory: map['cargoSubcategory']?.toInt(),
      goods: List<int>.from(map['goods']),
      bookingDate: map['bookingDate'] ?? '',
      pickup: PickingLocationModel.fromMap(map['pickup']),
      destination: PickingLocationModel.fromMap(map['destination']),
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingRequestFormData.fromJson(String source) => BookingRequestFormData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BookingRequestFormData(cargoSubcategory: $cargoSubcategory, goods: $goods, bookingDate: $bookingDate, pickup: $pickup, destination: $destination)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is BookingRequestFormData &&
      other.cargoSubcategory == cargoSubcategory &&
      listEquals(other.goods, goods) &&
      other.bookingDate == bookingDate &&
      other.pickup == pickup &&
      other.destination == destination;
  }

  @override
  int get hashCode {
    return cargoSubcategory.hashCode ^
      goods.hashCode ^
      bookingDate.hashCode ^
      pickup.hashCode ^
      destination.hashCode;
  }
}
