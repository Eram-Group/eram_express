import 'cargo-categoriesModel.dart';
import 'goods-typeModel.dart';


class HomeModel {
  final List<CargoCategoryModel> categories;
  final List<GoodModel> goods;
  //final List<BookingRequestModel>booking;

  HomeModel({
    required this.categories,
    required this.goods,
    //required this.booking,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
  
    return HomeModel(
      categories: (json["categories"] as List)
          .map((category) => CargoCategoryModel.fromJson(category))
          .toList(),
      goods: (json["supported_goods_types"] as List)
          .map((good) => GoodModel.fromJson(good))
          .toList(),
    //booking: (json[])
    );
    
  }
  
 String toString() {
    return 'HomeModel(categories: $categories)';

}
}

