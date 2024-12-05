import 'package:equatable/equatable.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/models/addressmodels/place_details_model.dart';


enum GoogleMapViewStatus {
  initial,
  loading,
  updated,
  error,
  placeDetailsLoaded,
  placeDetailsLoading,
  placeDetailsError,
}

extension GoogleMapViewStateX on GoogleMapViewState {
  bool get isInitial => status == GoogleMapViewStatus.initial;
  bool get isLoading => status == GoogleMapViewStatus.loading;
  bool get isLoaded => status == GoogleMapViewStatus.updated;
  bool get isError => status == GoogleMapViewStatus.error;
  bool get isEmpty => status == GoogleMapViewStatus.placeDetailsError;
  bool get isPlaceDetailsLoaded => status == GoogleMapViewStatus.placeDetailsLoaded;
  bool get isPlaceDetailsLoading => status == GoogleMapViewStatus.placeDetailsLoading;
  bool get isPlaceDetailsError =>status == GoogleMapViewStatus.placeDetailsError;
}

class GoogleMapViewState extends Equatable {
  final GoogleMapViewStatus status;
  final Set<Marker>? markers;
  final String? errorMessage;
  final PlaceDetailsModel? placeDetails; 

  const GoogleMapViewState({
    required this.status,
    this.markers,
    this.errorMessage, 
    this.placeDetails,
  });

  @override
  List<Object?> get props =>[markers];
}







/*
class PlaceDetailsLoaded extends GoogleMapViewState {
  final  PlaceDetailsModel placeDetails;
  const PlaceDetailsLoaded(this.placeDetails);
  @override
  List<Object> get props => [placeDetails];
}

class PlaceDetailsError extends GoogleMapViewState {
  final String errorMessage;
  PlaceDetailsError(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
*/