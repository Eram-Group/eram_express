import 'package:eram_express/features/home/data/models/home-Model.dart';
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
  final HomeModel? homeModel;
  final String? errorMessage;
  final bool? isValidateLoadType;

  HomeViewState({
    this.pickup,
    this.destination,
    this.loadType,
    this.truckSize,
    this.pickupDate,
    this.selectGoods,
    this.selectGoodsString,
    this.homeModel,
    this.errorMessage,
    this.isValidateLoadType = true,
  });

  HomeViewState copyWith(
      {final PickingLocationModel? pickup,
      final PickingLocationModel? destination,
      CargoCategoryModel? loadType,
      CargoSubCategoryModel? truckSize,
      List<GoodModel>? selectGoods,
      String? selectGoodsString,
      String? pickupDate,
      HomeModel? homeModel,
      List<CargoSubCategoryModel>? cargoSubCategories,
      List<CargoCategoryModel>? cargoCategories,
      List<GoodModel>? goods,
      String? errorMessage,
      bool? isValidateLoadType}) {
    return HomeViewState(
      pickup: pickup ?? this.pickup,
      destination: destination ?? this.destination,
      loadType: loadType ?? this.loadType,
      truckSize: truckSize ?? this.truckSize,
      selectGoods: selectGoods ?? this.selectGoods,
      pickupDate: pickupDate ?? this.pickupDate,
      homeModel: homeModel ?? this.homeModel,
      selectGoodsString: selectGoodsString ?? this.selectGoodsString,
      errorMessage: errorMessage ?? this.errorMessage,
      isValidateLoadType: isValidateLoadType ?? this.isValidateLoadType,
    );
  }
}

class RequestCreateError extends HomeViewState {
  RequestCreateError()
      : super(
          pickup: null,
          destination: null,
          loadType: null,
          truckSize: null,
          pickupDate: null,
          selectGoods: null,
          selectGoodsString: null,
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
          errorMessage: null,
        );
}
