import 'package:eram_express/core/utils/logger.dart';
import 'package:eram_express/features/google_map/data/models/placeModel.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../domain/services/locationservice.dart';
import 'google_map_view_state.dart';

class MarkerCubit extends Cubit<MarkerState> {
  final Locationservice _locationService;

  MarkerCubit({required Locationservice locationService})
      : _locationService = locationService,
        super(MarkerInitial()) {
    loadcustomIcon();
    setInitialCameraPosition();
    setmylocation();
  }

  late BitmapDescriptor customIcon;
  GoogleMapController? _controller;
  final Set<Marker> mapMarkers = {};
  late String mapstyle = '';
  late CameraPosition kInitialPosition;

  void setInitialCameraPosition() {
    kInitialPosition = const CameraPosition(
      target: LatLng(0, 0),
      zoom: 0,
    );
  }

  void loadcustomIcon() async {
    customIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(150, 150)),
      'assets/icons/Destination.png',
    );
  }

  Future<void> setmapstyle(BuildContext context) async {
    mapstyle = await DefaultAssetBundle.of(context)
        .loadString('assets/map_styles/silvermap.json');
  }

  void setController(GoogleMapController controller) {
    _controller = controller;
  }

  void getRealtimeLocation() {
    _locationService
        .getRealtimeLocation()
        .listen((LocationData currentLocation) {
      logger.debug(
          "Current Location: ${currentLocation.latitude}, ${currentLocation.longitude}");
      updateMarkerAndCamera(currentLocation); // هنا بتحدّث المكان والكاميرا
    });
  }

  void updateMarkerAndCamera(LocationData locationData) {
    var updatedPosition =LatLng(locationData.latitude!, locationData.longitude!);
    mapMarkers.removeWhere((marker) => marker.markerId.value == 'myLocation');

    var myLocationMarker = Marker(
      markerId: const MarkerId('myLocation'),
      position: updatedPosition,
      icon: customIcon,
    );

    mapMarkers.add(myLocationMarker);

    _controller?.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: updatedPosition, zoom: 15),
    ));

    emit(MarkerUpdated(mapMarkers));
  }

  void setmylocation() async {
   _locationService.setmylocation();
  }
}
