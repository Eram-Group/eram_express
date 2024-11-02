import 'dart:math';

import 'address_components_model.dart';

class PlaceDetailsModel {
  String placeId;
  String formattedAddress;
  List<AddressComponent> addressComponents;
  double? long;
  double? lat;
  String? CounrtyCode;
  PlaceDetailsModel({
    required this.placeId,
    required this.formattedAddress,
    required this.addressComponents,
    this.lat,
    this.long,
    this.CounrtyCode,
  });

  factory PlaceDetailsModel.fromJson(Map<String, dynamic> json) {
    var componentsFromJson = json['address_components'] as List;
    List<AddressComponent> addressComponentsList = componentsFromJson
        .map((component) => AddressComponent.fromJson(component))
        .toList();

    return PlaceDetailsModel(
      placeId: json['place_id'] ?? '',
      formattedAddress: json['formatted_address'] ?? '',
      addressComponents: addressComponentsList,
      lat: json["geometry"]["location"]["lat"],
      long: json["geometry"]["location"]["lng"],
      CounrtyCode: getCountryCode(json),
    );
  }
}

String? getCountryCode(Map<String, dynamic> json) {
  var country = json['address_components']?.firstWhere(
    (component) {
      if (component['types'] is List) {
        return (component['types'] as List).contains('country');
          }
      return false;
    },
    orElse: () => null, // إذا لم نجد أي عنصر، نعيد null
  );

 
  if (country != null) {
    String countryCode = country['short_name'];
    return countryCode;
  } else {
    return null; 
  }
}
