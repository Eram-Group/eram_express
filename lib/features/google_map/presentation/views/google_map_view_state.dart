import 'package:equatable/equatable.dart';
import 'package:eram_express/features/google_map/domain/Entities/address_entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/models/addressmodels/place_details_model.dart';

abstract class GoogleMapViewState extends Equatable {
  const GoogleMapViewState();
  @override
  List<Object> get props => [];
}

class GoogleMapViewStateInitial extends GoogleMapViewState {}

class GoogleMapViewStateloading extends GoogleMapViewState {}

class GoogleMapViewStateUpdated extends GoogleMapViewState {
  final Set<Marker> markers;
  const GoogleMapViewStateUpdated(
    this.markers,
  );
  @override
  List<Object> get props => [markers];
}

class GoogleMapViewStateError extends GoogleMapViewState {
  final String errormessege;
  const GoogleMapViewStateError(this.errormessege);
  List<Object> get props => [errormessege];
}

class PlaceDetailsLoadingState extends GoogleMapViewState {
  List<Object> get props => [];
}

class PlaceDetailsLoaded extends GoogleMapViewState {
  final AddressEntity placeDetails;
  PlaceDetailsLoaded(this.placeDetails);
  @override
  List<Object> get props => [placeDetails];
}

class PlaceDetailsError extends GoogleMapViewState {
  final String errorMessage;
  PlaceDetailsError(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
