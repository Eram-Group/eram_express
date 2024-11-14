import 'package:eram_express/features/booking/domain/usecases/create_booking_request_usecase.dart';

import 'package:eram_express/features/home/data/models/cargo-categoriesModel.dart';
import 'package:eram_express/features/home/domain/objects/booking_request_form_data.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../google_map/presentation/views/google_map_view.dart';
import '../../data/repositotys/home_repositoty_impl.dart';
import '../../modals/cargo_categories-modal.dart';
import '../../modals/cargo_subcategories-modal.dart';
import '../../modals/goods-modal.dart';
import '../../modals/pick_data-modal.dart';
import '../viewsmodel/cargo_categories_viewmodel.dart';
import '../viewsmodel/cargo_sub_category_view_model.dart';
import '../viewsmodel/good_view_model.dart';
import '../viewsmodel/picking_location_view_model.dart';
import 'ShippingFormState.dart';

class HomeViewController extends Cubit<HomeViewState> {
  final HomeRepositoryImpl _homerepo; //TODo convert it to Usecases
  final CreateBookingRequestUsecase _createBookingRequestUsecase;
  HomeViewController({
    required HomeRepositoryImpl homerepo,
    required CreateBookingRequestUsecase createBookingRequestUsecase,
  })  : _homerepo = homerepo,
        _createBookingRequestUsecase = createBookingRequestUsecase,
        super(HomeViewState());

  Future<void> cargoCategoryOnClicked(BuildContext context) async
   {
    emit(state.copyWith( isLoading: true,));
    _homerepo.getCargoCategories().then((result)
     {
      result.fold(
        (error) {
          emit(state.copyWith( isLoading: false, errorMessage: "Failed to get data"));
        },
        (data) {
          emit(state.copyWith(
            isLoading: false,
            cargoCategories: data.map((item)=>CargoCategoryViewModel.fromEntity(item)).toList(),
          ));
        },
      );
    });

    final selection = await showModalBottomSheet<CargoCategoryViewModel>(
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
            cargoSubCategories: data
                .map((item) => CargoSubCategoryViewModel.fromEntity(item))
                .toList(),
          ));
        },
      );
    });

    final selection = await showModalBottomSheet<CargoSubCategoryViewModel>(
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
    _homerepo.getGoods().then((result) {
      result.fold(
        (error) {
          emit(state.copyWith(
            isLoading: false, /*errorMessage: "error "*/
          )); //المفروض ابعت هنا error messgr
        },
        (data) {
          emit(state.copyWith(
            isLoading: false,
            goods: data.map((item)=>GoodViewModel.fromEntity(item)).toList(),
          ));
        },
      );
    });

    final selection = await showModalBottomSheet<List<GoodViewModel>>(
      context: context,
      builder: (context) => SelectGoodsModal(
        cubit: this,
      ),
    );

    if (selection != null) {
      displayGoodstype(selection, context);
    }
  }

  Future<void> PickClicked(BuildContext context) async {
    final result = await Navigator.of(context).pushNamed(GoogleMapView.route,
        arguments: GoogleMapViewArguments(initialAddress: state.pickup?.point));
    if (result is PickingLocationViewModel) 
    {
      emit(state.copyWith(pickup: result, filled: false));
    }
  }

  Future<void> destinationClicked(BuildContext context) async {
    final result = await Navigator.of(context).pushNamed(GoogleMapView.route,
        arguments: GoogleMapViewArguments(initialAddress: state.destination?.point));
    if (result is PickingLocationViewModel) {
      emit(state.copyWith(destination: result, filled: false));
    }
  }

  Future<void> createRequestlbuttonclick() async {
    // عملاها علشان اعمل validation
    if (state.selectGoodsString == null ||
        state.truckSize == null ||
        state.pickupDate == null ||
        state.pickup == null ||
        state.loadType == null ||
        state.destination == null) {
      emit(state.copyWith(filled: true));
    } 
    else 
    {
      List<int> goodids = [];
      state.selectGoods?.forEach((good) {
        goodids.add(good.id);
      });

      BookingRequestFormData formData = BookingRequestFormData(
          cargoVehicleSubcategoryId: state.truckSize?.id,
          goodIds: goodids,
          bookingDate: state.pickupDate!,
          pickup: state.pickup!,
          destination: state.destination!);

      final result = await  _createBookingRequestUsecase.execute(formData);
       result.fold((error)=> emit(RequestCreateError()),
       (data)=>emit(RequestCreateSuccess()));
    }
  }
  void displayGoodstype(
      List<GoodViewModel> selectiongoods, BuildContext context) {
    String goodsNames =
        selectiongoods.map((good) => good.nameEn).toList().join(', ');
    emit(state.copyWith(selectGoodsString: goodsNames, filled: false));
  }
  void toggleGoodSelection(GoodViewModel good) {
    if (state.selectGoods == null) {
      state.selectGoods = [];
    }
    if (state.selectGoods!.contains(good)) {
      state.selectGoods!.remove(good);
    } else {
      state.selectGoods!.add(good);
    }

    emit(state.copyWith(selectGoods: state.selectGoods));
  }

}
