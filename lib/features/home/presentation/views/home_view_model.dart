
import 'package:eram_express/features/home/domain/services/home_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositotys/home_repositoty_impl.dart';
import '../../modals/cargo_categories-modal.dart';
import 'home_view_state.dart';

class HomeViewModel extends Cubit<HomeViewState> {
  final HomeRepositoryImpl _homerepo;
  HomeViewModel({
    required HomeRepositoryImpl homerepo,
  })  : _homerepo = homerepo, 
        super(HomeViewState());


  Future<void> _cargoCategoryOnClicked(BuildContext context) async {
    if (state.cargoCategoryList == null)
       _homerepo.getCargoCategories();
  
  //هنعملها wrap ب
  //selector علشان نعرف ايه هو الي  هيبقي اخضر وايه هو الي هيبقي ابيض
    final selection = await showModalBottomSheet(
      context: context,
      builder: (context) => SelectCargoCategoryModal(
        //cargocategories: state.cargoCategoryList,
      ),
    );

    if (selection != null) 
    {
      emit(state.copyWith(selectedCargo:selection));
    }
  }
}
