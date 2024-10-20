import 'package:eram_express/core/utils/logger.dart';
import 'package:eram_express/features/google_map/domain/services/locationservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'search_model_view_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final Locationservice _locationservice;
  final TextEditingController searchController = TextEditingController();

  SearchCubit({required Locationservice locationservice})
      : _locationservice = locationservice,
        super(SearchStateEmpty()) {
    searchController.addListener(() {
      updateSearchQuery(searchController.text);
    });
  }

  void updateSearchQuery(String query) {
    _locationservice.getsearchresult(query);
    logger.debug(query);
  }

  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }
}
