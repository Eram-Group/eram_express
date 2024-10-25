import 'package:either_dart/either.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/services/locationservice.dart';
import 'place_details_view_state.dart';

class PlaceDetailsViewModel extends Cubit<PlaceDetailsViewState> {
  final Locationservice _locationService;
  PlaceDetailsViewModel({
    required Locationservice locationService,
  })  : _locationService = locationService,
        super(PlaceDetailsloading()) {}

  void getplacedetails(String lat, String long) {
    emit(PlaceDetailsloading());
    final result = _locationService.getplacedetailsresult(lat, long);
    result.fold((errorMessage) {
     
      emit(PlaceDetailerror("faild to get places"));
    }, (placedetails) {
      logger.debug("State placeeeeeeee: ${placedetails[0].formattedAddress}");
      emit(PlaceDetailssuccess(placedetails[0]));
    });
  }
}
