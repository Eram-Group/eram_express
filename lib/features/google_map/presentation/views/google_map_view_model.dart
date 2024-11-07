import 'dart:async';
import 'package:eram_express/app/navigation.dart';
import 'package:eram_express/features/google_map/presentation/search_model_view/search_view.dart';
import 'package:eram_express/features/home/data/models/picking_locationModel.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../domain/services/locationservice.dart';
import '../../domain/usecases/get_current_location_usecase.dart';
import '../../domain/usecases/get_place_details_usaecase.dart';
import 'google_map_view_state.dart';

class GoogleMapViewController extends Cubit<GoogleMapViewState> {
  final GetCurrentLocationUsecase _getCurrentLocationUsecase;
  final GetPlaceDetailsUsaecase _getPlaceDetailsUsaecase;
  final Locationservice _locationService; // الي حاليا ممكن يتغير مكان current
  GoogleMapViewController({
    required GetCurrentLocationUsecase getCurrentLocationUsecase,
    required GetPlaceDetailsUsaecase getPlaceDetailsUsaecase,
    required locationService,
  })  : _locationService = locationService,
        _getPlaceDetailsUsaecase = getPlaceDetailsUsaecase,
        _getCurrentLocationUsecase = getCurrentLocationUsecase,
        super(GoogleMapViewStateInitial()) {}

  GoogleMapController? _controller;
  Timer? _debounce;
  final Set<Marker> mapMarkers = {};
  late String mapstyle = '';
  late CameraPosition kInitialPosition;
  double kDefaultMapZoom = 15.0;

  void setInitialCameraPostion(Point? initialAddress) {
    if (initialAddress != null) {
      kInitialPosition = CameraPosition(
        target: LatLng(initialAddress.latitude, initialAddress.longitude),
        zoom: kDefaultMapZoom,
      );
    } else {
      if (_locationService?.currentLocation != null) {
        kInitialPosition = CameraPosition(
          target: LatLng(_locationService.currentLocation!.point.latitude,
              _locationService.currentLocation!.point.longitude),
          zoom: kDefaultMapZoom,
        );
      } else {
        emit(GoogleMapViewStateloading());
        kInitialPosition = CameraPosition(
          target: LatLng(0, 0),
          zoom: kDefaultMapZoom,
        );
        getCurrentLocation();
      }
    }
  }

  void getPlaceDetails() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      emit(PlaceDetailsLoadingState());
      final result = await _getPlaceDetailsUsaecase.execute(
        mapMarkers.first.position.latitude.toString(),
        mapMarkers.first.position.longitude.toString(),
      );
      result.fold(
        (errorMessage) {
          emit(PlaceDetailsError(errorMessage));
        },
        (placeDetails) {
          emit(PlaceDetailsLoaded(placeDetails));
        },
      );
    });
  }

  @override
  Future<void> close() {
    _debounce?.cancel(); // Cancel debounce when cubit is closed
    return super.close();
  }

  Future<void> setmapstyle(BuildContext context) async {
    mapstyle = await DefaultAssetBundle.of(context)
        .loadString('assets/map_styles/silvermap.json');
  }

  void setController(GoogleMapController controller) {
    _controller = controller;
  }

  void getCurrentLocation() async {
    emit(GoogleMapViewStateloading());
    final result = await _getCurrentLocationUsecase.execute();
    result.fold(
      (error) => emit(GoogleMapViewStateError(error)),
      (locationData) {
        kInitialPosition = CameraPosition(
          target: LatLng(locationData.latitude!, locationData.longitude!),
          zoom: kDefaultMapZoom,
        );
        updateMarkerAndCamera(kInitialPosition!, moveCamera: true);
      },
    );
  }

  void updateMarkerAndCamera(CameraPosition locationData,
      {bool moveCamera = false}) {
    emit(PlaceDetailsLoadingState());
    var updatedPosition = locationData.target;
    mapMarkers.removeWhere((marker) => marker.markerId.value == 'myLocation');
    var myLocationMarker = Marker(
      markerId: const MarkerId('myLocation'),
      position: updatedPosition,
      draggable: true,
    );
    mapMarkers.add(myLocationMarker);

    if (moveCamera) {
      ChangeCameraPosition(locationData);
    }
  }

  void ChangeCameraPosition(CameraPosition locationData) {
    _controller?.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: locationData.target, zoom: kDefaultMapZoom),
    ));
    emit(GoogleMapViewStateUpdated(Set.from(mapMarkers)));
  }

  void searchButtonClick() async {
    final result = await Navigator.pushNamed(
        NavigationService.globalContext, SearchView.route);
    if (result is LatLng) {
      CameraPosition(target: result);
      updateMarkerAndCamera(CameraPosition(target: result), moveCamera: true);
    }
  }
}
