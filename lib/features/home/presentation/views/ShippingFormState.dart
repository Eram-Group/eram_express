import 'package:eram_express/features/home/data/models/picking_locationModel.dart';

import '../../data/models/cargo-categoriesModel.dart';
import '../../data/models/cargo-subcategoryModel.dart';
import '../../data/models/goods-typeModel.dart';

class ShippingFormState {
  final PickingLocationModel? pickup;
  final PickingLocationModel? destination;
  final CargoCategoryModel? loadType;
  final CargoSubCategoryModel? truckSize;
  final String? pickupDate;
  List<GoodModel>? selectgoods;
  final String? selectgoodsString;
  final bool isLoading;
  final List<CargoSubCategoryModel>? cargoSubCategories;
  final List<CargoCategoryModel>? cargoCategories;
  final List<GoodModel>? goods;
  ShippingFormState({
    this.pickup,
    this.destination,
    this.loadType,
    this.truckSize,
    this.pickupDate,
    this.selectgoods,
    this.selectgoodsString,
    this.isLoading = false,
    this.cargoSubCategories,
    this.cargoCategories,
    this.goods,
  });

  ShippingFormState copyWith({
    final PickingLocationModel? pickup,
    final PickingLocationModel? destination,
    CargoCategoryModel? loadType,
    CargoSubCategoryModel? truckSize,
    List<GoodModel>? selectgoods,
    String? selectgoodsString,
    String? pickupDate,
    bool? isLoading,
    List<CargoSubCategoryModel>? cargoSubCategories,
    List<CargoCategoryModel>? cargoCategories,
    List<GoodModel>? goods,
  }) {
    return ShippingFormState(
        pickup: pickup ?? this.pickup,
        destination: destination ?? this.destination,
        loadType: loadType ?? this.loadType,
        truckSize: truckSize ?? this.truckSize,
        selectgoods: selectgoods ?? this.selectgoods,
        pickupDate: pickupDate ?? this.pickupDate,
        isLoading: isLoading ?? this.isLoading,
        cargoSubCategories: cargoSubCategories ?? this.cargoSubCategories,
        cargoCategories: cargoCategories ?? this.cargoCategories,
        goods: goods ?? this.goods,
        selectgoodsString: selectgoodsString ?? this.selectgoodsString);
  }
}
