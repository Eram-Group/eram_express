import '../../data/models/cargo-categoriesModel.dart';
import '../../data/models/cargo-subcategoryModel.dart';
import '../../data/models/goods-typeModel.dart';
import '../../data/models/picking_locationModel.dart';

class HomeViewState {
  final PickingLocationModel? pickup;
  final PickingLocationModel? destination;
  final CargoCategoryModel? loadType;
  final CargoSubCategoryModel? truckSize;
  final String? pickupDate;
  List<GoodModel>? selectGoods;
  final String? selectGoodsString;
  final List<CargoSubCategoryModel>? cargoSubCategories;
  final List<CargoCategoryModel>? cargoCategories;
  final List<GoodModel>? goods;

  final String? errorMessage;
  
  HomeViewState({
    this.pickup,
    this.destination,
    this.loadType,
    this.truckSize,
    this.pickupDate,
    this.selectGoods,
    this.selectGoodsString,
    this.cargoSubCategories,
    this.cargoCategories,
    this.goods,
   
    this.errorMessage,
  });

  HomeViewState copyWith({
    final PickingLocationModel? pickup,
    final PickingLocationModel? destination,
    CargoCategoryModel? loadType,
    CargoSubCategoryModel? truckSize,
    List<GoodModel>? selectGoods,
    String? selectGoodsString,
    String? pickupDate,
    //bool? isLoading,
    List<CargoSubCategoryModel>? cargoSubCategories,
    List<CargoCategoryModel>? cargoCategories,
    List<GoodModel>? goods,
    String? errorMessage,
  }) {
    return HomeViewState(
      pickup: pickup ?? this.pickup,
      destination: destination ?? this.destination,
      loadType: loadType ?? this.loadType,
      truckSize: truckSize ?? this.truckSize,
      selectGoods: selectGoods ?? this.selectGoods,
      pickupDate: pickupDate ?? this.pickupDate,
      //isLoading: isLoading ?? this.isLoading,
      cargoSubCategories: cargoSubCategories ?? this.cargoSubCategories,
      cargoCategories: cargoCategories ?? this.cargoCategories,
      goods: goods ?? this.goods,
     
      selectGoodsString: selectGoodsString ?? this.selectGoodsString,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
class RequestCreateError extends HomeViewState
{
  RequestCreateError():
  super(
          pickup: null,
          destination: null,
          loadType: null,
          truckSize: null,
          pickupDate: null,
          selectGoods: null,
          selectGoodsString: null,
          //isLoading: false,
          cargoSubCategories: [],
          cargoCategories: [],
          goods: [],
          
          errorMessage: null,
        );

}
class RequestCreateSuccess extends HomeViewState {
  RequestCreateSuccess()
      : super(
          pickup: null,
          destination: null,
          loadType: null,
          truckSize: null,
          pickupDate: null,
          selectGoods: null,
          selectGoodsString: null,
          cargoSubCategories: [],
          cargoCategories: [],
          goods: [],
          errorMessage: null,
        );
}
