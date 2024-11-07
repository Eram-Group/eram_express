import 'dart:math';

import 'address_components_model.dart';

class PlaceDetailsModel {
  String placeId;
  String formattedAddress;
  List<AddressComponent> addressComponents;
  double? long;
  double? lat;
  String? countryCode;

  PlaceDetailsModel({
    required this.placeId,
    required this.formattedAddress,
    required this.addressComponents,
    this.lat,
    this.long,
    this.countryCode,
  });

  factory PlaceDetailsModel.fromJson(Map<String, dynamic> json) {
    var componentsFromJson = json['address_components'] as List;
    List<AddressComponent> addressComponentsList = componentsFromJson
        .map((component) => AddressComponent.fromJson(component))
        .toList();

    return PlaceDetailsModel(
      placeId: json['place_id'] ?? '',
      formattedAddress:_getFormattedAddressWithoutPlusCode(addressComponentsList),
      addressComponents: addressComponentsList,
      lat: json["geometry"]["location"]["lat"],
      long: json["geometry"]["location"]["lng"],
      countryCode: _getCountryCode(json),
    );
  }
}

String _getFormattedAddressWithoutPlusCode(List<AddressComponent> components) {
  return components
      .where((component) => !(component.types.contains('plus_code')))
      .map((component) => component.longName)
      .join(', ');
}

String? _getCountryCode(Map<String, dynamic> json) {
  var country = json['address_components']?.firstWhere(
    (component) {
      if (component['types'] is List) {
        return (component['types'] as List).contains('country');
      }
      return false;
    },
    orElse: () => null,
  );

  if (country != null) {
    return country['short_name'];
  }
  return null;
}
