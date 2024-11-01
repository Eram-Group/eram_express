import 'package:eram_express/features/home/data/models/picking_locationModel.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../domain/services/locationservice.dart';
import 'google_map_view_state.dart';
import 'place_details_view/place_details_view_model.dart';

class MarkerCubit extends Cubit<MarkerState> {
  final Locationservice _locationService;
  final PlaceDetailsViewModel _placeDetailsViewModel;
  MarkerCubit({
    required locationService,
    required PlaceDetailsViewModel placeDetailsViewModel,
  })  : _locationService = locationService,
        _placeDetailsViewModel = placeDetailsViewModel,
        super(MarkerInitial()) {}

  GoogleMapController? _controller;

  final Set<Marker> mapMarkers = {};
  late String mapstyle = '';
  late CameraPosition kInitialPosition;
  bool isLoading = true;

  void setInitialCameraPostion(Point? initialAddress) {
    if (initialAddress != null) {
      logger.debug("enter in intial");
      kInitialPosition = CameraPosition(
        target: LatLng(initialAddress.latitude, initialAddress.longitude),
        zoom: 15,
      );
      updateMarkerAndCamera(kInitialPosition);
    } else {
      if (_locationService?.currentLocation != null) {
        logger.debug("enter in current");
        kInitialPosition = CameraPosition(
          target: LatLng(_locationService.currentLocation!.point.latitude,
              _locationService.currentLocation!.point.longitude),
          zoom: 15,
        );
        updateMarkerAndCamera(kInitialPosition);
      } else {
        logger.debug("enter in intial camerAAA");
        kInitialPosition = const CameraPosition(
          target: LatLng(0, 0),
          zoom: 15,
        );
        getCurrentLocation();
      }
    }
    isLoading = false;
  }

  //Question
  // كل ما بيدخل الصفحه بيرجع يجيب ال details ده عادي؟
  void getplacedetails() async {
    logger.debug("get details for mark ${mapMarkers.first.position.latitude}");
    _placeDetailsViewModel.getplacedetails(
        mapMarkers.first.position.latitude.toString(),
        mapMarkers.first.position.longitude.toString());
  }

  Future<void> setmapstyle(BuildContext context) async {
    mapstyle = await DefaultAssetBundle.of(context)
        .loadString('assets/map_styles/silvermap.json');
  }

  void setController(GoogleMapController controller) {
    _controller = controller;
  }

  void getCurrentLocation() async 
  {
    LocationData? location = await _locationService.getCurrentLocation();
    kInitialPosition = CameraPosition(
      target: LatLng(location!.latitude!, location.longitude!),
      zoom: 15,
    );

    updateMarkerAndCamera(kInitialPosition!, moveCamera: true);
  }

  void updateMarkerAndCamera(CameraPosition locationData,
      {bool moveCamera = false}) {
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
      CameraPosition(target: locationData.target, zoom: 15),
    ));
    emit(MarkerUpdated(Set.from(mapMarkers)));
  }
}
