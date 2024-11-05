import 'package:either_dart/either.dart';
import 'package:eram_express/app/di.dart';
import 'package:eram_express/features/google_map/domain/usecases/get_place_details_usaecase.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/services/locationservice.dart';
import 'place_details_view_state.dart';

class PlaceDetailsViewModel extends Cubit<PlaceDetailsViewState> {
  final GetPlaceDetailsUsaecase _getPlaceDetailsUsaecase;
  PlaceDetailsViewModel({
    required GetPlaceDetailsUsaecase getPlaceDetailsUsaecase,
  })  : _getPlaceDetailsUsaecase = getPlaceDetailsUsaecase,
        super(PlaceDetailsloading()) {}

  void getplacedetails(String lat, String long) async {
    emit(PlaceDetailsloading());
    final result = await _getPlaceDetailsUsaecase.execute(lat, long);
    return result.fold((errorMessage) {
      emit(PlaceDetailerror(errorMessage));
    }, (placedetails) async
     {
      emit(PlaceDetailssuccess(placedetails[0]));
    });
  }
}
