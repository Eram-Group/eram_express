import 'dart:async';
import 'package:eram_express/app/navigation.dart';
import 'package:eram_express/features/authentication/data/respositories/authentication_repository_impl.dart';
import 'package:eram_express/features/customer/data/models/customer_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import '../../../authentication/data/respositories/authentication_repository.dart';
import '../../data/repositories/google_map_reposirtoty.dart';
import 'search_model_view_state.dart';

class SearchViewController extends Cubit<SearchState> {
 final GoogleMapRepository _googleMapRepository;
 final AuthenticationRepository _authenticationRepository;
  final TextEditingController searchController = TextEditingController();
  String? sessionToken;
  Timer? debounce;
  SearchViewController(
      {required GoogleMapRepository googleMapRepository,
      required AuthenticationRepositoryImpl authenticationRepository})
      : _googleMapRepository = googleMapRepository,
        _authenticationRepository = authenticationRepository,
        super(const SearchState(status: SearchStateStatus.initial)) {
    searchController.addListener(() {
      if (debounce?.isActive ?? false) {
        debounce?.cancel();
      }
      debounce = Timer(const Duration(milliseconds: 500), () 
      {
        sessionToken ??= const Uuid().v4(); // check it
        updateSearchQuery(searchController.text);
      });
    });
  }

  Future<void> updateSearchQuery(String query) async {
    if (query.isNotEmpty && query.trim().isNotEmpty)
     {
      CustomerModel? user =await _authenticationRepository.authenticatedCustomer;
       try {
        final data = await _googleMapRepository.getPredictionPlaces(
            query, sessionToken!, user!.country.code);
        data.isEmpty
            ? emit(const SearchState(status: SearchStateStatus.empty))
            : emit(SearchState(status: SearchStateStatus.success,recommendPlaces: data));
      } catch (e) {
        emit(const SearchState(status: SearchStateStatus.error,errorMessage: "Fail to get result"));
      }
    } 
    else {
      emit(const SearchState(status: SearchStateStatus.initial ));
    }
  }

  Future<void> getCoordinatesForAddress(String address) async {
    try
    {
      final result = await  _googleMapRepository.getCoordinatesForAddress(address);
      LatLng(result.lat!, result.long!);
      Navigator.pop(NavigationService.globalContext, LatLng(result.lat!, result.long!));
    }
    catch(e)
    {
                emit(const SearchState(
          status: SearchStateStatus.error, errorMessage: "Fail to get result"));
    }
   
  }

  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }
}
