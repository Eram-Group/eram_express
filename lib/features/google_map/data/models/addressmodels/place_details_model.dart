
import 'address_components_model.dart';
class PlaceDetailsModel 
{
  String placeId;
  String formattedAddress;
  List<AddressComponent> addressComponents;

  PlaceDetailsModel({
    required this.placeId,
    required this.formattedAddress,
    required this.addressComponents,
  });

  factory PlaceDetailsModel.fromJson(Map<String, dynamic> json)
   {
    var componentsFromJson = json['address_components'] as List;
    List<AddressComponent> addressComponentsList = componentsFromJson
        .map((component) => AddressComponent.fromJson(component))
        .toList();

    return PlaceDetailsModel(
      placeId: json['place_id'] ?? '',
      formattedAddress: json['formatted_address'] ?? '',
      addressComponents: addressComponentsList,
    );
  }
}
