import '../../data/models/cargo-categoriesModel.dart';
import '../../data/models/cargo-subcategoryModel.dart';

class ShippingFormState {
  final String? pickup;
  final String? destination;
  final CargoCategoryModel? loadType;
  final CargoSubCategoryModel? truckSize;
  final String? pickupDate;
  final bool isLoading;
  final List<CargoSubCategoryModel>? cargoSubCategories;
  final List<CargoCategoryModel>? cargoCategories;

  ShippingFormState({
    this.pickup,
    this.destination,
    this.loadType,
    this.truckSize,
    this.pickupDate,
    this.isLoading = false,
    this.cargoSubCategories,
    this.cargoCategories,
  });

  ShippingFormState copyWith({
    String? pickup,
    String? destination,
    CargoCategoryModel? loadType,
    CargoSubCategoryModel? truckSize,
    String? pickupDate,
    bool? isLoading,
    List<CargoSubCategoryModel>? cargoSubCategories,
    List<CargoCategoryModel>? cargoCategories,
  }) {
    return ShippingFormState(
        pickup: pickup ?? this.pickup,
        destination: destination ?? this.destination,
        loadType: loadType ?? this.loadType,
        truckSize: truckSize ?? this.truckSize,
        pickupDate: pickupDate ?? this.pickupDate,
        isLoading: isLoading ?? this.isLoading,
        cargoSubCategories: cargoSubCategories ?? this.cargoSubCategories,
        cargoCategories: cargoCategories ?? this.cargoCategories);
  }
}
