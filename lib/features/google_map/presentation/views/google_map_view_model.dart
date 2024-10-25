import 'package:either_dart/either.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:eram_express_shared/core/utils/responsive.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../domain/repositories/google_map_reposirtoty.dart';
import '../../domain/services/locationservice.dart';
import 'google_map_view_state.dart';
import 'place_details_view/place_details_view_model.dart';

class MarkerCubit extends Cubit<MarkerState> {
  final Locationservice _locationService;
  final PlaceDetailsViewModel _placeDetailsViewModel;

  MarkerCubit({
    required Locationservice locationService,
    required PlaceDetailsViewModel placeDetailsViewModel,
  })  : _locationService = locationService,
        _placeDetailsViewModel = placeDetailsViewModel,
        super(MarkerInitial()) {
    setInitialCameraPostion();
  }

  GoogleMapController? _controller;
  final Set<Marker> mapMarkers = {};
  late String mapstyle = '';
  late CameraPosition kInitialPosition;

  void setInitialCameraPostion() {
    kInitialPosition = const CameraPosition(
      target: LatLng(40.7128, -74.0060),
      zoom: 12.0,
    );
  }

  void getplacedetails() async {
    logger.debug("enter in get deatils");
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

  void getCurrentLocation() async {
    LocationData? location = await _locationService.getCurrentLocation();

    kInitialPosition = CameraPosition(
      target: LatLng(location!.latitude!, location.longitude!),
      zoom: 15,
    );
    updateMarkerAndCamera(kInitialPosition!, moveCamera: true);
  }

  void updateMarkerAndCamera(CameraPosition locationData,
      {bool moveCamera = false}) {
    logger.debug("entern in updateMarkerAndCamera");
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
    getplacedetails();
    emit(MarkerUpdated(Set.from(mapMarkers)));
  }
}
