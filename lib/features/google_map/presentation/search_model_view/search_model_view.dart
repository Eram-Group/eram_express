import 'dart:async';
import 'package:either_dart/either.dart';
import 'package:eram_express/app/navigation.dart';
import 'package:eram_express/features/google_map/domain/usecases/get_Coordinates_address_usecase.dart';
import 'package:eram_express/features/google_map/domain/usecases/get_search_result_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import 'search_model_view_state.dart';

class SearchViewController extends Cubit<SearchState> {
  final GetSearchResultUsecase _getSearchResultUsecase;
  final GetCoordinatesForAddresseUsecase _getLonglatPlaceUsecase;
  final TextEditingController searchController = TextEditingController();
  String? sessiontoken;
  Timer? debounce;
  SearchViewController(
      {required GetSearchResultUsecase getSearchResultUsecase,
      required GetCoordinatesForAddresseUsecase getLonglatPlaceUsecase})
      : _getSearchResultUsecase = getSearchResultUsecase,
        _getLonglatPlaceUsecase = getLonglatPlaceUsecase,
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

    if (query.isNotEmpty && query.trim().isNotEmpty) {
      final result = _getSearchResultUsecase.execute(query, sessiontoken!);
      result.fold((errorMessage) {emit(SearchStateError("faild to get places"));
      }, (placelist) 
      {
        placelist.isEmpty? emit(SearchStateEmpty()) : emit(SearchStateSuccess(placelist));
      }
      );
    } else {
      emit(SearchStateintial());
    }
  }

  void getCoordinatesForAddress(String address) {
    final result = _getLonglatPlaceUsecase.execute(address);

    result.fold((error) => emit(SearchStateError("faild to get places")),
        (data) {
      LatLng(data.lat!, data.long!);
      Navigator.pop(NavigationService.globalContext, LatLng(data.lat!, data.long!));
    });
  }

  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }
}
