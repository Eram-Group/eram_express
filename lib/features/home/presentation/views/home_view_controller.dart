import 'package:eram_express/features/booking/data/repositories/BookingRepository%20.dart';
import 'package:eram_express/features/home/presentation/objects/booking_request_form_data.dart';
import 'package:eram_express_shared/core/api/server_expection.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../google_map/presentation/views/google_map_view.dart';
import '../../data/models/cargo-categoriesModel.dart';
import '../../data/models/cargo-subcategoryModel.dart';
import '../../data/models/goods-typeModel.dart';
import '../../data/models/picking_locationModel.dart';
import '../../data/repositotys/home_repository.dart';
import '../modals/cargo_categories-modal.dart';
import '../modals/cargo_subcategories-modal.dart';
import '../modals/goods-modal.dart';
import '../modals/pick_data-modal.dart';
import 'home_view_state.dart';

class HomeViewController extends Cubit<HomeViewState> {
  final HomeRepository _homeRepository;
  final BookingRepository _bookingRepository;
  HomeViewController({
    required HomeRepository homeRepo,
    required BookingRepository bookingRepository,
  })  : _homeRepository = homeRepo,
        _bookingRepository = bookingRepository,
        super(HomeViewState(status: HomeBookingRequestStatus.initial)) {
    initialHomeData();
  }

  Future<void> initialHomeData() async {
    try {
      final result = await _homeRepository.getHome();
      emit(state.copyWith(homeModel: result));
    } catch (e) {
      state.copyWith(errorMessage: "Failed to get data");
    }
  }

  Future<void> cargoCategoryOnClicked(BuildContext context) async {
    final selection = await showModalBottomSheet<CargoCategoryModel>(
      context: context,
      builder: (context) => SelectCargoCategoryModal(
        cubit: this,
      ),
    );
    if (selection != null) {
      emit(state.copyWith(loadType: selection, isValidateLoadType: true));
    }
  }

  Future<void> pickDateOnClicked(BuildContext context) async {
    final selection = await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => const PickDateBottomSheet());
    logger.debug(selection);
    if (selection != null) {
      emit(state.copyWith(
        pickupDate: selection,
      ));
    }
  }

  Future<void> cargoSubCategoryOnClicked(BuildContext context) async {
    if (state.loadType != null) {
      final selection = await showModalBottomSheet<CargoSubCategoryModel>(
        context: context,
        builder: (context) => SelectSubCargoCategoryModal(
          cubit: this,
        ),
      );
      if (selection != null) {
        emit(state.copyWith(truckSize: selection));
      }
    } else {
      emit(state.copyWith(isValidateLoadType: false));
    }
  }

  Future<void> goodsOnClicked(BuildContext context) async {
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

  Future<void> pickClicked(BuildContext context) async {
    final result = await Navigator.of(context).pushNamed(GoogleMapView.route,
        arguments: GoogleMapViewArguments(initialAddress: state.pickup?.point));
    if (result is PickingLocationModel) {
      emit(state.copyWith(pickup: result));
    }
  }

  Future<void> destinationClicked(BuildContext context) async {
    final result = await Navigator.of(context).pushNamed(GoogleMapView.route,
        arguments:
            GoogleMapViewArguments(initialAddress: state.destination?.point));
    if (result is PickingLocationModel) {
      emit(state.copyWith(
        destination: result,
      ));
    }
  }

  bool enabledSubmitButton() {
    if (state.selectGoodsString == null ||
            state.truckSize == null ||
            state.pickupDate == null ||
            //state.pickup == null ||
            state.loadType == null
        //state.destination == null
        ) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> createRequestButtonClick() async {
    List<int> goodIds = [];
    state.selectGoods?.forEach((good) {
      goodIds.add(good.id);
    });

    BookingRequestFormData formData = BookingRequestFormData(
        cargoSubcategory: state.truckSize?.id,
        goods: goodIds,
        bookingDate: state.pickupDate!,
        pickup: state.pickup!,
        destination: state.destination!);
    try {
      await _bookingRepository.bookingRequest(formData);
      emit(state.copyWith(
        status: HomeBookingRequestStatus.requestCreateSuccess,
        pickup: null,
        destination: null,
        loadType: null,
        truckSize: null,
        pickupDate: null,
        selectGoods: null,
        selectGoodsString: null,
        errorMessage: null,
      ));
    } on ServerException catch (e) {
      //emit(state)
      emit(state.copyWith(
        status: HomeBookingRequestStatus.requestCreateError,
        //errorMessage: e.errors[0].code  ask backend to make it accept the language."
      ));
    }
  }

  void displayGoodstype(List<GoodModel> selectionGoods, BuildContext context) {
    String goodsNames =
        selectionGoods.map((good) => good.nameEn).toList().join(', ');
    emit(state.copyWith(
      selectGoodsString: goodsNames,
    ));
  }

  void toggleGoodSelection(GoodModel good) {
    final selectGoods = state.selectGoods ?? [];
    if (selectGoods.contains(good)) {
      selectGoods.remove(good);
    } else {
      selectGoods.add(good);
    }
    emit(state.copyWith(selectGoods: selectGoods));
  }
}
