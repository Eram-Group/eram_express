import 'package:eram_express/features/booking/domain/services/booking_service.dart';
import 'package:eram_express/features/customer/domain/services/customer_service.dart';
import 'package:eram_express/features/home/data/models/cargo-categoriesModel.dart';
import 'package:eram_express/features/home/domain/objects/booking_request_form_data.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../i18n/domain/locale_cubit.dart';
import '../../../google_map/presentation/google_map_view.dart';
import '../../data/models/cargo-subcategoryModel.dart';
import '../../data/models/goods-typeModel.dart';

import '../../data/models/picking_locationModel.dart';
import '../../data/repositotys/home_repositoty_impl.dart';
import '../../modals/cargo_categories-modal.dart';
import '../../modals/cargo_subcategories-modal.dart';
import '../../modals/goods-modal.dart';
import '../../modals/pick_data-modal.dart';
import 'ShippingFormState.dart';

class ShippingFormCubit extends Cubit<ShippingFormState> {
  final HomeRepositoryImpl _homerepo;
  final BookingService _bookingService;

  ShippingFormCubit({
    required HomeRepositoryImpl homerepo,
    required BookingService bookingService,
  })  : _homerepo = homerepo,
        _bookingService = bookingService,
        super(ShippingFormState());

  Future<void> cargoCategoryOnClicked(BuildContext context) async {
    emit(state.copyWith(
      isLoading: true,
    ));

    _homerepo.getCargoCategories().then((result) {
      result.fold(
        (error) {
          emit(state.copyWith(
            isLoading: false, /*//errorMessage: "error ", */
          ));
        },
        (data) {
          emit(state.copyWith(
            isLoading: false,
            cargoCategories: data,
          ));
        },
      );
    });

    final selection = await showModalBottomSheet<CargoCategoryModel>(
      context: context,
      builder: (context) => SelectCargoCategoryModal(
        cubit: this,
      ),
    );

    if (selection != null) {
      emit(state.copyWith(loadType: selection, filled: false));
    }
  }

  Future<void> PickdateOnClicked(BuildContext context) async {
    final selection = await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => PickDateBottomSheet());
    logger.debug(selection);
    if (selection != null) {
      emit(state.copyWith(pickupDate: selection, filled: false));
    }
  }

  Future<void> cargosubCategoryOnClicked(BuildContext context) async {
    emit(state.copyWith(
      isLoading: true,
    ));
    _homerepo.getSubCargoCategories().then((result) {
      result.fold(
        (error) {
          emit(state.copyWith(
            isLoading: false, /*errorMessage: "error "*/
          )); //المفروض ابعت هنا error messgr
        },
        (data) {
          emit(state.copyWith(
            isLoading: false,
            cargoSubCategories: data,
          ));
        },
      );
    });

    final selection = await showModalBottomSheet<CargoSubCategoryModel>(
      context: context,
      builder: (context) => SelectSubCargoCategoryModal(
        cubit: this,
      ),
    );
    if (selection != null) {
      emit(state.copyWith(truckSize: selection, filled: false));
    }
  }

  Future<void> GoodsOnClicked(BuildContext context) async {
    emit(state.copyWith(
      isLoading: true,
    ));
    _homerepo.getgoods().then((result) {
      result.fold(
        (error) {
          emit(state.copyWith(
            isLoading: false, /*errorMessage: "error "*/
          )); //المفروض ابعت هنا error messgr
        },
        (data) {
          emit(state.copyWith(
            isLoading: false,
            goods: data,
          ));
        },
      );
    });

    final selection = await showModalBottomSheet<List<GoodModel>>(
      context: context,
      builder: (context) => SelectGoodsModal(
        cubit: this,
      ),
    );

    if (selection != null) {
      displayGoodstype(selection, context);
    }
  }

  void toggleGoodSelection(GoodModel good) {
    if (state.selectgoods == null) {
      state.selectgoods = [];
    }

    if (state.selectgoods!.contains(good)) {
      logger.debug("loll");
      state.selectgoods!.remove(good);
    } else {
      logger.debug("messagellllllllll");
      state.selectgoods!.add(good);
    }

    emit(state.copyWith(selectgoods: state.selectgoods));
  }

  void displayGoodstype(List<GoodModel> selectiongoods, BuildContext context) {
    //final currentLocale = context.watch<LocaleCubit>().state;
    //logger.debug("state: ${currentLocale.languageCode}");
    // currentLocale.languageCode == 'ar' ? good.nameAr :
    String goodsNames =
        selectiongoods.map((good) => good.nameEn).toList().join(', ');
    logger.debug(goodsNames);
    emit(state.copyWith(selectgoodsString: goodsNames, filled: false));
  }

  Future<void> PickClicked(BuildContext context) async {
    final result = await Navigator.of(context).pushNamed(GoogleMapView.route,
        arguments: GoogleMapViewArguments(initialAddress: state.pickup?.point));
    if (result is PickingLocationModel) {
      emit(state.copyWith(pickup: result, filled: false));
    }
  }

  Future<void> destinationClicked(BuildContext context) async {
    final result = await Navigator.of(context).pushNamed(GoogleMapView.route,
        arguments:
            GoogleMapViewArguments(initialAddress: state.destination?.point));
    if (result is PickingLocationModel) {
      emit(state.copyWith(destination: result, filled: false));
    }
  }

  void createRequestlbuttonclick() {
    if (state.selectgoodsString == null ||
        state.truckSize == null ||
        state.pickupDate == null ||
        state.pickup == null ||
        state.loadType == null ||
        state.destination == null) {
      logger.debug("clickkk done");
      emit(state.copyWith(filled: true));
    } else 
    {
    List<int> goodids = [];  
            state.selectgoods?.forEach((good) {
    goodids.add(good.id);  
});

    BookingRequestFormData formData=BookingRequestFormData(cargoVehicleSubcategoryId: state.truckSize?.id, goodIds:goodids, bookingDate: state.pickupDate!, pickup:state.pickup!, destination: state.destination!);
    final result= _bookingService.bookingRequest(formData);
    }
  }




}
