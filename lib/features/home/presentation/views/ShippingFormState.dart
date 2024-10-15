import '../../data/models/cargo-categoriesModel.dart';
import '../../data/models/cargo-subcategoryModel.dart';
import '../../data/models/goods-typeModel.dart';

class ShippingFormState {
  final String? pickup;
  final String? destination;
  final CargoCategoryModel? loadType;
  final CargoSubCategoryModel? truckSize;
  final String? pickupDate;
  final GoodModel? selectgood;
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
    this.selectgood,
    this.isLoading = false,
    this.cargoSubCategories,
    this.cargoCategories,
    this.goods,
  });

  ShippingFormState copyWith({
    String? pickup,
    String? destination,
    CargoCategoryModel? loadType,
    CargoSubCategoryModel? truckSize,
    GoodModel? selectgood,
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
      selectgood: selectgood ?? this.selectgood,
      pickupDate: pickupDate ?? this.pickupDate,
      isLoading: isLoading ?? this.isLoading,
      cargoSubCategories: cargoSubCategories ?? this.cargoSubCategories,
      cargoCategories: cargoCategories ?? this.cargoCategories,
      goods: goods ?? this.goods,
    );
  }
}
