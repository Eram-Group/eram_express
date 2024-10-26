import 'package:eram_express/features/home/data/models/picking_locationModel.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:uuid/uuid.dart';
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
        super(MarkerInitial()) {}

  GoogleMapController? _controller;

  final Set<Marker> mapMarkers = {};
  late String mapstyle = '';
  late CameraPosition kInitialPosition;
  bool isLoading = true;

  void setInitialCameraPostion(Point? initialAddress) {
    if (initialAddress != null) {
      kInitialPosition = CameraPosition(
        target: LatLng(initialAddress.latitude, initialAddress.longitude),
        zoom: 15,
      );
      updateMarkerAndCamera(kInitialPosition);
    } else {
      kInitialPosition = const CameraPosition(
        target: LatLng(0, 0),
        zoom: 15,
      );
      getCurrentLocation();
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
 

  void getCurrentLocation() async {
    //سجليه في حته علشان ال destination
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
