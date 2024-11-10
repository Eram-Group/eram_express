import 'package:eram_express/features/booking/data/models/bid_model.dart';
import 'package:eram_express/features/booking/domain/Entities/booking_request_entity.dart';
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

  factory BookingRequestModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> pickingLocationJson = {
      'location': json['picking_location'],
      'location_text': json['picking_location_text'],
    };
    Map<String, dynamic> destinationLocationJson = {
      'location': json['destination_location'],
      'location_text': json['destination_location_text'],
    };
    return BookingRequestModel(
      id: json['id'],
      status: json['status'],
      bookingDate: json['booking_date'],
      createdAt: DateTime.parse(json['created_at']),
      goods: (json['goods'] as List).map((e) => GoodModel.fromJson(e)).toList(),
      cargoSubcategory:
          CargoSubCategoryModel.fromJson(json['cargo_subcategory']),
      customer: CustomerModel.fromJson(json['customer']),
      pickingLocation: PickingLocationModel.fromJson(pickingLocationJson),
      destinationLocation:
          PickingLocationModel.fromJson(destinationLocationJson),
      bids: (json["bids"] as List)
          .map((item) => BidModel.fromJson(item))
          .toList(),
    );
  }

  BookingRequestEntity toEntity() {
    return BookingRequestEntity(
      id: this.id,
      status: this.status,
      bookingDate: this.bookingDate,
      pickingLocation: pickingLocation.toEntity(this.pickingLocation),
      destinationLocation:
          destinationLocation.toEntity(this.destinationLocation),
    );
  }
}
