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

 bool matching =true;
 Future<bool> getplacedetails(String lat, String long) async {
    emit(PlaceDetailsloading());

    // Await the result of the asynchronous call to get placedetails
    final result = await _locationService.getplacedetailsresult(lat, long);

    return result.fold((errorMessage) {
      emit(PlaceDetailerror(
          "failed to get places")); // Corrected "faild" to "failed"
      return false; // Return false in case of error
    }, (placedetails) async {
       bool matching = await countryMatch(placedetails[0]
          .CounrtyCode); 
      logger.debug("State placeeeeeeee: ${placedetails[0].CounrtyCode}");
      logger.debug("State placeeeeeeee2: $matching");
      matching?
      emit(PlaceDetailssuccess(placedetails[0])):emit(PlaceDetaisOutsideboundries());
      return matching; 
    });
  }

  Future<bool> countryMatch(String? CounrtyCode) async {
    String UserCounrtyCode = await _locationService.getCustomerCountry();
    if (CounrtyCode == UserCounrtyCode)
      return true;
    else
      return false;
  }
}
