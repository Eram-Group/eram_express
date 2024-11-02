import 'package:equatable/equatable.dart';

import '../../../data/models/addressmodels/place_details_model.dart';

class PlaceDetailsViewState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class PlaceDetailsloading extends PlaceDetailsViewState {
  List<Object> get props => [];
}

class PlaceDetailssuccess extends PlaceDetailsViewState {
  PlaceDetailsModel placedetails;
  PlaceDetailssuccess(this.placedetails);
  @override
  List<Object> get props => [placedetails];
}
class PlaceDetaisOutsideboundries extends PlaceDetailsViewState
{
     List<Object> get props => [];
}
class PlaceDetailerror extends PlaceDetailsViewState {
  String errormessege;
  PlaceDetailerror(this.errormessege);
}
