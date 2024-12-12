import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:eram_express/features/booking/data/models/bid_model.dart';

import '../../../customer/data/models/customer_model.dart';
import '../../../home/data/models/cargo-subcategoryModel.dart';
import '../../../home/data/models/goods-typeModel.dart';
import '../../../home/data/models/picking_locationModel.dart';

class BookingRequestModel {
  final int id;
  final String status;
  final String bookingDate;
  final DateTime createdAt;
  final List<GoodModel> goods;
  final CargoSubCategoryModel cargoSubcategory;
  final CustomerModel customer;
  final PickingLocationModel pickingLocation;
  final PickingLocationModel destinationLocation;
  final List<BidModel> bids;
  BookingRequestModel({
    required this.id,
    required this.status,
    required this.bookingDate,
    required this.createdAt,
    required this.goods,
    required this.cargoSubcategory,
    required this.customer,
    required this.pickingLocation,
    required this.destinationLocation,
    required this.bids,
  });

  BookingRequestModel copyWith({
    int? id,
    String? status,
    String? bookingDate,
    DateTime? createdAt,
    List<GoodModel>? goods,
    CargoSubCategoryModel? cargoSubcategory,
    CustomerModel? customer,
    PickingLocationModel? pickingLocation,
    PickingLocationModel? destinationLocation,
    List<BidModel>? bids,
  }) {
    return BookingRequestModel(
      id: id ?? this.id,
      status: status ?? this.status,
      bookingDate: bookingDate ?? this.bookingDate,
      createdAt: createdAt ?? this.createdAt,
      goods: goods ?? this.goods,
      cargoSubcategory: cargoSubcategory ?? this.cargoSubcategory,
      customer: customer ?? this.customer,
      pickingLocation: pickingLocation ?? this.pickingLocation,
      destinationLocation: destinationLocation ?? this.destinationLocation,
      bids: bids ?? this.bids,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status,
      'bookingDate': bookingDate,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'goods': goods.map((x) => x.toMap()).toList(),
      'cargoSubcategory': cargoSubcategory.toMap(),
      'customer': customer.toMap(),
      'pickingLocation': pickingLocation.toMap(),
      'destinationLocation': destinationLocation.toMap(),
      'bids': bids.map((x) => x.toMap()).toList(),
    };
  }

  factory BookingRequestModel.fromMap(Map<String, dynamic> map) {
    Map<String, dynamic> pickingLocationMap = {
      'location': map['pickingLocation'],
      'location_text': map['pickingLocationText'],
    };
    Map<String, dynamic> destinationLocationMap = {
      'location': map['destinationLocation'],
      'location_text': map['destinationLocationText'],
    };

    return BookingRequestModel(
      id: map['id'],
      status: map['status'] ?? '',
      bookingDate: map['bookingDate'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
      goods:
          List<GoodModel>.from(map['goods']?.map((x) => GoodModel.fromMap(x))),
      cargoSubcategory: CargoSubCategoryModel.fromMap(map['cargoSubcategory']),
      customer: CustomerModel.fromMap(map['customer']),
      pickingLocation: PickingLocationModel.fromMap(pickingLocationMap),
      destinationLocation: PickingLocationModel.fromMap(destinationLocationMap),
      bids: List<BidModel>.from(map['bids']?.map((x) => BidModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingRequestModel.fromJson(String source) =>
      BookingRequestModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BookingRequestModel(id: $id, status: $status, bookingDate: $bookingDate, createdAt: $createdAt, goods: $goods, cargoSubcategory: $cargoSubcategory, customer: $customer, pickingLocation: $pickingLocation, destinationLocation: $destinationLocation, bids: $bids)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BookingRequestModel &&
        other.id == id &&
        other.status == status &&
        other.bookingDate == bookingDate &&
        other.createdAt == createdAt &&
        listEquals(other.goods, goods) &&
        other.cargoSubcategory == cargoSubcategory &&
        other.customer == customer &&
        other.pickingLocation == pickingLocation &&
        other.destinationLocation == destinationLocation &&
        listEquals(other.bids, bids);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        status.hashCode ^
        bookingDate.hashCode ^
        createdAt.hashCode ^
        goods.hashCode ^
        cargoSubcategory.hashCode ^
        customer.hashCode ^
        pickingLocation.hashCode ^
        destinationLocation.hashCode ^
        bids.hashCode;
  }
}
