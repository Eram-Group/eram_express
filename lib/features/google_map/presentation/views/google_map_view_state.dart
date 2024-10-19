import 'package:equatable/equatable.dart';
import 'package:eram_express/features/google_map/data/models/placeModel.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  MarkerUpdated(this.markers);
    @override
  List<Object> get props => [markers];

}

class CameraPositionUpdated extends MarkerState {
  final CameraPosition position;
  CameraPositionUpdated(this.position);
}
class MarkerComplete extends MarkerState {
  //final PlaceModel place;

  const MarkerComplete();

  @override
  List<Object> get props => [];
}
