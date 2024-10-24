import 'package:either_dart/either.dart';
import 'package:eram_express/features/google_map/data/repositories/google_map_repositiory.dart';
import 'package:eram_express/features/google_map/domain/services/locationservice.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'search_model_view_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final Locationservice _locationservice;
  final TextEditingController searchController = TextEditingController();

  SearchCubit({required Locationservice locationservice})
      : _locationservice = locationservice,
        super(SearchStateintial()) {
    searchController.addListener(() {
      updateSearchQuery(searchController.text);
    });
  }

  void updateSearchQuery(String query) {
    //emit(SearchStateLoading());
    logger.debug(query);
    if (query.isNotEmpty && query.trim().isNotEmpty) {
      final result = _locationservice.getsearchresult(query);
      result.fold((errorMessage) {
        emit(SearchStateError("faild to get places"));
      }, (placelist) {
        if (placelist.isEmpty) {
          emit(SearchStateEmpty());
        }
        emit(SearchStateSuccess(placelist));
      });
    } 
    else
     {
      emit(SearchStateintial());
     }
  }

  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }
}
