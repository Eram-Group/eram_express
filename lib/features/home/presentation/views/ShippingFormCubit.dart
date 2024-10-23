
import 'package:eram_express/features/home/data/models/cargo-categoriesModel.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/cargo-subcategoryModel.dart';
import '../../data/models/goods-typeModel.dart';

import '../../data/repositotys/home_repositoty_impl.dart';
import '../../modals/cargo_categories-modal.dart';
import '../../modals/cargo_subcategories-modal.dart';
import '../../modals/goods-modal.dart';
import '../../modals/pick_data-modal.dart';
import 'ShippingFormState.dart';

class ShippingFormCubit extends Cubit<ShippingFormState> {
  final HomeRepositoryImpl _homerepo;

  ShippingFormCubit({required HomeRepositoryImpl homerepo})
      : _homerepo = homerepo,
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
      emit(state.copyWith(loadType: selection));
    }
  }

  Future<void> PickdateOnClicked(BuildContext context) async {
    final selection = await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => PickDateBottomSheet());
    logger.debug(selection);
    if (selection != null) {
      emit(state.copyWith(pickupDate: selection));
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
      emit(state.copyWith(truckSize: selection));
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
      emit(state.copyWith(selectgoods: selection));
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
}
