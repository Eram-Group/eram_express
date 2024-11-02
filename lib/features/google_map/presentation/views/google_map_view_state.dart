import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MarkerState extends Equatable {
  const MarkerState();

  @override
  List<Object> get props => [];
}

class MarkerInitial extends MarkerState {}

class Markerloading extends MarkerState {}

class MarkerUpdated extends MarkerState {
  final Set<Marker> markers;
  final bool inside;

  const MarkerUpdated(this.markers,
      {this.inside = true}); // Use named parameter for clarity

  @override
  List<Object> get props => [markers, inside];
}



