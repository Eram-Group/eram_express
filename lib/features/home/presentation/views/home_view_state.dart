import 'package:equatable/equatable.dart';

import '../../data/models/cargo-categoriesModel.dart';
import '../../data/models/cargo-subcategoryModel.dart';
import '../../data/models/goods-typeModel.dart';

class HomeViewState extends Equatable {
  final List<CargoCategoryModel> cargoCategoryList;
  final List<CargoSubCategoryModel> cargoSubCategoryList;
  final CargoSubCategoryModel? selectedCargo;
  final List<GoodModel> goodList;

  const HomeViewState({
    this.cargoCategoryList = const [],
    this.cargoSubCategoryList = const [],
    this.goodList = const [],
    this.selectedCargo,
  });

  @override
  List<Object?> get props => [
        cargoCategoryList,
        cargoSubCategoryList,
        selectedCargo,
        goodList,
      ];

//question

      // مش المفروض ان qutable  
      //تسمح ليا بحوار ال كوبي ده ؟
  HomeViewState copyWith({
    List<CargoCategoryModel>? cargoCategoryList,
    List<CargoSubCategoryModel>? cargoSubCategoryList,
    CargoSubCategoryModel? selectedCargo,
    List<GoodModel>? goodList,
  }) {
    return HomeViewState(
      cargoCategoryList: cargoCategoryList ?? this.cargoCategoryList,
      cargoSubCategoryList: cargoSubCategoryList ?? this.cargoSubCategoryList,
      selectedCargo: selectedCargo ?? this.selectedCargo,
      goodList: goodList ?? this.goodList,
    );
  }
}
