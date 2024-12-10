
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

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
    this.long,
    this.lat,
    this.countryCode,
  });

  PlaceDetailsModel copyWith({
    String? placeId,
    String? formattedAddress,
    List<AddressComponent>? addressComponents,
    ValueGetter<double?>? long,
    ValueGetter<double?>? lat,
    ValueGetter<String?>? countryCode,
  }) {
    return PlaceDetailsModel(
      placeId: placeId ?? this.placeId,
      formattedAddress: formattedAddress ?? this.formattedAddress,
      addressComponents: addressComponents ?? this.addressComponents,
      long: long != null ? long() : this.long,
      lat: lat != null ? lat() : this.lat,
      countryCode: countryCode != null ? countryCode() : this.countryCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'placeId': placeId,
      'formattedAddress': formattedAddress,
      'addressComponents': addressComponents.map((x) => x.toMap()).toList(),
      'long': long,
      'lat': lat,
      'countryCode': countryCode,
    };
  }

    
  factory PlaceDetailsModel.fromMap(Map<String, dynamic> map) {
     var componentsFromMap = map['address_components'] as List;
    List<AddressComponent> addressComponentsList = componentsFromMap
        .map((component) => AddressComponent.fromJson(component)) .toList();
    return PlaceDetailsModel(
      placeId: map['placeId'] ?? '',
      addressComponents: addressComponentsList,
     formattedAddress:_getFormattedAddressWithoutPlusCode(addressComponentsList),
    lat: map["geometry"]["location"]["lat"],
      long: map["geometry"]["location"]["lng"],
      countryCode: _getCountryCode(map),
    );
    
  }

  String toJson() => json.encode(toMap());

  factory PlaceDetailsModel.fromJson(String source) => PlaceDetailsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PlaceDetailsModel(placeId: $placeId, formattedAddress: $formattedAddress, addressComponents: $addressComponents, long: $long, lat: $lat, countryCode: $countryCode)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PlaceDetailsModel &&
      other.placeId == placeId &&
      other.formattedAddress == formattedAddress &&
      listEquals(other.addressComponents, addressComponents) &&
      other.long == long &&
      other.lat == lat &&
      other.countryCode == countryCode;
  }

  @override
  int get hashCode {
    return placeId.hashCode ^
      formattedAddress.hashCode ^
      addressComponents.hashCode ^
      long.hashCode ^
      lat.hashCode ^
      countryCode.hashCode;
  }
  
}


String _getFormattedAddressWithoutPlusCode(List<AddressComponent> components) {
  return components
      .where((component) => !(component.types.contains('plus_code')))
      .map((component) => component.longName)
      .join(', ');
}

String? _getCountryCode(Map<String, dynamic> map) {
  var country = map['address_components']?.firstWhere(
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
