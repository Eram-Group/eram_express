import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:eram_express/app/navigation.dart';
import 'package:eram_express/features/google_map/data/repositories/google_map_repositiory.dart';
import 'package:eram_express/features/google_map/domain/services/locationservice.dart';
import 'package:eram_express/features/google_map/domain/usecases/get_longlat_place_usecase.dart';
import 'package:eram_express/features/google_map/domain/usecases/get_search_result_usecase.dart';
import 'package:eram_express/features/home/data/models/picking_locationModel.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import '../google_map_view.dart';
import 'search_model_view_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final GetSearchResultUsecase  _getSearchResultUsecase;
  final GetLonglatPlaceUsecase _getLonglatPlaceUsecase;
  //final Locationservice _locationservice;
  final TextEditingController searchController = TextEditingController();
  String? sessiontoken;
  Timer? debounce;

   SearchCubit({required  GetSearchResultUsecase  getSearchResultUsecase,
   required GetLonglatPlaceUsecase getLonglatPlaceUsecase
   
   })
      :_getSearchResultUsecase = getSearchResultUsecase,
      _getLonglatPlaceUsecase=getLonglatPlaceUsecase,
        super(SearchStateintial()) {
    searchController.addListener(() {
      if (debounce?.isActive ?? false) {
        debounce?.cancel();
      }
      debounce = Timer(const Duration(milliseconds: 500), () {
        sessiontoken ??= const Uuid().v4();

        updateSearchQuery(searchController.text);
      });
    });
  }

  void updateSearchQuery(String query) {
    //emit(SearchStateLoading());
    logger.debug(query);

    if (query.isNotEmpty && query.trim().isNotEmpty) {
      final result = _getSearchResultUsecase.execute(query, sessiontoken!);
      result.fold((errorMessage) {
        emit(SearchStateError("faild to get places"));
      }, (placelist) {
        if (placelist.isEmpty) {
          emit(SearchStateEmpty());
        }
        emit(SearchStateSuccess(placelist));
      });
    } else {
      emit(SearchStateintial());
    }
  }

  void getlonglat(String address) {
    final result = _getLonglatPlaceUsecase.execute(address);

    result.fold(
        (error) => emit(SearchStateError("faild to get places")),

        (data) {
           
           LatLng(data.lat!, data.long!);
           Navigator.pop(NavigationService.globalContext,LatLng(data.lat!, data.long!) );});
        
  }

  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }
}





