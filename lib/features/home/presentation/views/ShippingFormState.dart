import '../viewsmodel/cargo_categories_viewmodel.dart';
import '../viewsmodel/cargo_sub_category_view_model.dart';
import '../viewsmodel/good_view_model.dart';
import '../viewsmodel/picking_location_view_model.dart';

class HomeViewState {
  final PickingLocationViewModel? pickup;
  final PickingLocationViewModel? destination;
  final CargoCategoryViewModel? loadType;
  final CargoSubCategoryViewModel? truckSize;
  final String? pickupDate;
  List<GoodViewModel>? selectGoods;
  final String? selectGoodsString;
  final bool isLoading;
  final List<CargoSubCategoryViewModel>? cargoSubCategories;
  final List<CargoCategoryViewModel>? cargoCategories;
  final List<GoodViewModel>? goods;
  final bool filled;
  final String? errorMessage;

  HomeViewState({
    this.pickup,
    this.destination,
    this.loadType,
    this.truckSize,
    this.pickupDate,
    this.selectGoods,
    this.selectGoodsString,
    this.isLoading = false,
    this.cargoSubCategories,
    this.cargoCategories,
    this.goods,
    this.filled = false,
    this.errorMessage,
  });

  HomeViewState copyWith({
    final PickingLocationViewModel? pickup,
    final PickingLocationViewModel? destination,
    CargoCategoryViewModel? loadType,
    CargoSubCategoryViewModel? truckSize,
    List<GoodViewModel>? selectGoods,
    String? selectGoodsString,
    String? pickupDate,
    bool? isLoading,
    List<CargoSubCategoryViewModel>? cargoSubCategories,
    List<CargoCategoryViewModel>? cargoCategories,
    List<GoodViewModel>? goods,
    bool? filled,
    String? errorMessage,
  }) {
    return HomeViewState(
      pickup: pickup ?? this.pickup,
      destination: destination ?? this.destination,
      loadType: loadType ?? this.loadType,
      truckSize: truckSize ?? this.truckSize,
      selectGoods: selectGoods ?? this.selectGoods,
      pickupDate: pickupDate ?? this.pickupDate,
      isLoading: isLoading ?? this.isLoading,
      cargoSubCategories: cargoSubCategories ?? this.cargoSubCategories,
      cargoCategories: cargoCategories ?? this.cargoCategories,
      goods: goods ?? this.goods,
      filled: filled ?? this.filled,
      selectGoodsString: selectGoodsString ?? this.selectGoodsString,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
