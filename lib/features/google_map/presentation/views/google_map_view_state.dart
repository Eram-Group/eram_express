
import 'package:flutter/foundation.dart';
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
  bool get isPlaceDetailsLoaded =>
      status == GoogleMapViewStatus.placeDetailsLoaded;
  bool get isPlaceDetailsLoading =>
      status == GoogleMapViewStatus.placeDetailsLoading;
  bool get isPlaceDetailsError =>
      status == GoogleMapViewStatus.placeDetailsError;
}

class GoogleMapViewState {
  final GoogleMapViewStatus status;
  final Set<Marker>? markers;
  final String? errorMessage;
  final PlaceDetailsModel? placeDetails;
  GoogleMapViewState({
    required this.status,
    this.markers,
    this.errorMessage,
    this.placeDetails,
  });

  GoogleMapViewState copyWith({
    GoogleMapViewStatus? status,
    Set<Marker>? markers,
    String? errorMessage,
   PlaceDetailsModel? placeDetails,
  }) {
    return GoogleMapViewState(
      status: status ?? this.status,
      markers: markers ?? this.markers,
      errorMessage: errorMessage ?? this.errorMessage,
      placeDetails: placeDetails ?? this.placeDetails,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GoogleMapViewState &&
        other.status == status &&
        setEquals(other.markers, markers) &&
        other.errorMessage == errorMessage &&
        other.placeDetails == placeDetails;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        markers.hashCode ^
        errorMessage.hashCode ^
        placeDetails.hashCode;
  }
}
