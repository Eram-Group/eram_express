import 'package:eram_express/features/booking/data/repositories/BookingRepository%20.dart';
import 'package:eram_express/features/home/presentation/objects/booking_request_form_data.dart';
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
        super(HomeViewState());

  Future<void> cargoCategoryOnClicked(BuildContext context) async {
    // emit(state.copyWith(isLoading: true,));
    _homeRepository.getHome().then((result) {
      try {
        emit(state.copyWith(cargoCategories: result.categories));
      } catch (e) {
        emit(state.copyWith(errorMessage: "Failed to get data"));
      }
    });

    final selection = await showModalBottomSheet<CargoCategoryModel>(
      context: context,
      builder: (context) => SelectCargoCategoryModal(
        cubit: this,
      ),
    );

    if (selection != null) {
      emit(state.copyWith(
        loadType: selection,
      ));
    }
  }

  Future<void> pickdateOnClicked(BuildContext context) async {
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
    try {
      // ايه الفرق بينها وبين لو عملت
      //.then?
      final result = await _homeRepository.getSubCargoCategories();
      emit(state.copyWith(cargoSubCategories: result));
      final selection = await showModalBottomSheet<CargoSubCategoryModel>(
        context: context,
        builder: (context) => SelectSubCargoCategoryModal(
          cubit: this,
        ),
      );
      if (selection != null) {
        emit(state.copyWith(truckSize: selection));
      }
    } catch (e) {}
  }

  Future<void> goodsOnClicked(BuildContext context) async {
    try {
      final result = await _homeRepository.getGoods();
      emit(state.copyWith(goods: result));

      final selection = await showModalBottomSheet<List<GoodModel>>(
        context: context,
        builder: (context) => SelectGoodsModal(
          cubit: this,
        ),
      );

      if (selection != null) {
        displayGoodstype(selection, context);
      }
    } catch (e) {
      emit(state.copyWith(
        errorMessage: "Error in getting Goods",
      ));
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
        state.pickup == null ||
        state.loadType == null ||
        state.destination == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> createRequestButtonClick() async {
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
    try {
      final result = await _bookingRepository.bookingRequest(formData);
      emit(RequestCreateSuccess());
    } catch (e) {
      emit(RequestCreateError());
    }
  }

  void displayGoodstype(List<GoodModel> selectiongoods, BuildContext context) {
    String goodsNames =
        selectiongoods.map((good) => good.nameEn).toList().join(', ');
    emit(state.copyWith(
      selectGoodsString: goodsNames,
    ));
  }

  void toggleGoodSelection(GoodModel good) {
    state.selectGoods ??= [];
    final existingGood = state.selectGoods!.firstWhere(
      (selectedGood) => selectedGood.id == good.id,
      orElse: () => GoodModel(
        id: -1,
        nameAr: 'Unknown',
        nameEn: 'Unknown',
        image: '',
      ),
    );
    if (existingGood.id != -1) {
      state.selectGoods!.remove(existingGood);
    } else {
      state.selectGoods!.add(good);
    }
    emit(state.copyWith(selectGoods: state.selectGoods));
  }
}
