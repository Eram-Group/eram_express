import 'package:eram_express/core/utils/logger.dart';
import 'package:eram_express/features/home/data/models/cargo-categoriesModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/cargo-subcategoryModel.dart';
import '../../data/repositotys/home_repositoty_impl.dart';
import '../../modals/cargo_categories-modal.dart';
import '../../modals/cargo_subcategories-modal.dart';
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
}


  /*
  Future<void> cargoCategoryOnClicked(BuildContext context) async {
    final CargoCategorys = await _homerepo.getCargoCategories();
    CargoCategorys.fold((error) {
      emit(ShippingFormErrorState(errorMessage: "error in build the cargo"));
    }, (data) async {
      final selection = await showModalBottomSheet(
        context: context,
        builder: (context) => SelectCargoCategoryModal(
          cargocategories: data,
          cubit: this,
        ),
      );
      print(selection);
      if (selection != null) {
        emit(state.copyWith(loadType: selection));
      }
    });
  }
*/
  /*
  Future<void> cargosubCategoryOnClicked(BuildContext context) async {
    final CargoCategorys = await _homerepo.getSubCargoCategories();
    CargoCategorys.fold(
        (error) => emit(
            ShippingFormErrorState(errorMessage: "error in build the cargo")),
        (data) async {
      final selection = await showModalBottomSheet(
        context: context,
        builder: (context) => SelectSubCargoCategoryModal(
          cargocategories: data,
          cubit: this,
        ),
      );
      print(selection);
      if (selection != null) {
        emit(state.copyWith(truckSize: selection));
      }
    });
  }
  */
