import 'dart:async';

import 'package:eram_express/features/google_map/data/repositories/google_map_reposirtoty.dart';
import 'package:eram_express/features/google_map/data/services/locationservice.dart';
import 'package:eram_express/features/google_map/presentation/search_model_view/search_view.dart';
import 'package:eram_express/features/home/data/models/picking_locationModel.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'google_map_view_state.dart';

class GoogleMapViewController extends Cubit<GoogleMapViewState> {

  final  GoogleMapRepository _googleMapRepository;
  final LocationService _locationService; 
  GoogleMapViewController({
    required GoogleMapRepository googleMapRepository,
    required LocationService locationService,
  })  : _locationService = locationService,
       _googleMapRepository=googleMapRepository,
        super( GoogleMapViewState(status: GoogleMapViewStatus.initial)) ;

  GoogleMapController? _controller;
  Timer? _debounce;
  final Set<Marker> mapMarkers = {};
  late String mapStyle = '';
  late CameraPosition kInitialPosition;
  double kDefaultMapZoom = 15.0;

  void setInitialCameraPosition(Point? initialAddress) 
  {
    if (initialAddress != null) {
      kInitialPosition = CameraPosition(
        target: LatLng(initialAddress.latitude, initialAddress.longitude),
        zoom: kDefaultMapZoom,
      );
    } else {
      if (_locationService.currentLocation != null) {
        kInitialPosition = CameraPosition(
          target: LatLng(_locationService.currentLocation!.point.latitude,
              _locationService.currentLocation!.point.longitude),
          zoom: kDefaultMapZoom,
        );
      } else {
        emit( GoogleMapViewState(status: GoogleMapViewStatus.loading));
        kInitialPosition = CameraPosition(
          target: const LatLng(0, 0),
          zoom: kDefaultMapZoom,
        );
        getCurrentLocation();
      }
    }
  }

  void getPlaceDetails() {
    //if (state is GoogleMapViewStateloading) return; //why?
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      emit(GoogleMapViewState(status: GoogleMapViewStatus.placeDetailsLoading));
      
     try
     {
      final placeDetails = await _googleMapRepository.getPlaceDetails(
          mapMarkers.first.position.latitude.toString(),
          mapMarkers.first.position.longitude.toString(), );
      emit(GoogleMapViewState(status: GoogleMapViewStatus.placeDetailsLoaded,placeDetails: placeDetails));
     }
     catch(e)
     {
       emit(GoogleMapViewState(
            status: GoogleMapViewStatus.placeDetailsError,
            errorMessage: "Fail to get place details"));
     }
     
    });
  }

  @override
  Future<void> close() {
    _debounce?.cancel(); 
    return super.close();
  }

  Future<void> setMapStyle(BuildContext context) async {
    mapStyle = await DefaultAssetBundle.of(context).loadString('assets/map_styles/silvermap.json');
  }

  void setController(GoogleMapController controller) {
    _controller = controller;
  }

  void getCurrentLocation() async 
  {
    emit( GoogleMapViewState(status: GoogleMapViewStatus.loading));
    try
    {
       final locationData = await _locationService.getCurrentLocation();
        kInitialPosition = CameraPosition(
          target: LatLng(locationData.latitude!, locationData.longitude!),
          zoom: kDefaultMapZoom,
        );
        updateMarkerAndCamera(kInitialPosition, moveCamera: true);
    }
    catch(e)
    {
             emit(GoogleMapViewState(status: GoogleMapViewStatus.error,errorMessage: "Fail to get current location"));
    }
    
  }

  void updateMarkerAndCamera(CameraPosition locationData, {bool moveCamera = false}) {
    emit(GoogleMapViewState( status: GoogleMapViewStatus.placeDetailsLoading,));
    var updatedPosition = locationData.target;
    mapMarkers.removeWhere((marker) => marker.markerId.value == 'myLocation');
    var myLocationMarker = Marker(
      markerId: const MarkerId('myLocation'),
      position: updatedPosition,
      draggable: true,
    );
    mapMarkers.add(myLocationMarker);
    if (moveCamera) {
      changeCameraPosition(locationData);
    }
  }

  void changeCameraPosition(CameraPosition locationData) 
  {
    _controller?.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: locationData.target, zoom: kDefaultMapZoom),
    ));
    emit(GoogleMapViewState(status: GoogleMapViewStatus.updated,markers:Set.from(mapMarkers) ));
      
  }

  void searchButtonClick(BuildContext context) async 
  {
    final result = await Navigator.pushNamed(context, SearchView.route);
    if (result is LatLng) {
      CameraPosition(target: result);
      updateMarkerAndCamera(CameraPosition(target: result), moveCamera: true);
    }
  }
}