import 'package:equatable/equatable.dart';
import 'package:eram_express/features/google_map/data/models/placeModel.dart';

abstract class MarkerState extends Equatable {
  const MarkerState();

  @override
  List<Object> get props => [];
}

class MarkerInitial extends MarkerState {}
class Markerloading extends MarkerState {}

class MarkerComplete extends MarkerState {
  final PlaceModel place;

  const MarkerComplete(this.place);

  @override
  List<Object> get props => [place];
}
