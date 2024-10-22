import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/models/addressmodels/place_details_model.dart';

abstract class MarkerState extends Equatable {
  const MarkerState();

  @override
  List<Object> get props => [];
}

class MarkerInitial extends MarkerState {}
class Markerloading extends MarkerState {}
class MarkerUpdated extends MarkerState  
{
  final Set<Marker>markers;
  const MarkerUpdated(this.markers);
    @override
  List<Object> get props => [markers];

}

class MarkerComplete extends MarkerState {
  //final PlaceModel place;

  const MarkerComplete();

  @override
  List<Object> get props => [];
}

class PlaceDetailsloading extends MarkerState {}
class PlaceDetailssuccess extends MarkerState 
{
  PlaceDetailsModel placedetails;
  PlaceDetailssuccess(this.placedetails);

}
class PlaceDetailerror extends MarkerState {
  String errormessege;
  PlaceDetailerror(this.errormessege);


}
