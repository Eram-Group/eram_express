import 'package:either_dart/either.dart';
import 'package:eram_express/core/utils/logger.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../domain/repositories/google_map_reposirtoty.dart';
import '../../domain/services/locationservice.dart';
import 'google_map_view_state.dart';

class MarkerCubit extends Cubit<MarkerState> {
  final Locationservice _locationService;
  // Corrected naming for consistency

  MarkerCubit({
    required Locationservice locationService,
  })  : _locationService = locationService,
        super(MarkerInitial()) {
    loadcustomIcon();
  }

  late BitmapDescriptor customIcon;
  GoogleMapController? _controller;
  final Set<Marker> mapMarkers = {};

  late String mapstyle = '';
  late CameraPosition kInitialPosition;

  void printMarkers() {
    getplacedetails(mapMarkers.first.position.latitude.toString(),
        mapMarkers.first.position.longitude.toString());
  }

  void getplacedetails(String lat, String long) {
    //emit(SearchStateLoading());
    final result = _locationService.getplacedetailsresult(lat, long);
    result.fold((errorMessage) {
      emit(PlaceDetailerror("faild to get places"));
    }, (placedetails) // بيرجع ليا اكتر من واحد مش عارفه اختار ايه
        {
        logger.debug("State placeeeeeeee: ${placedetails[0].formattedAddress}");
      emit(PlaceDetailssuccess(placedetails[0]));
    });
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

  void setmylocation() async {
    LocationData? location = await _locationService.setmylocation();

    kInitialPosition = CameraPosition(
      target: LatLng(location!.latitude!, location.longitude!),
      zoom: 15,
    );
    updateMarkerAndCamera(kInitialPosition!, moveCamera: true);

    /*
    _locationService
        .getRealtimeLocation() 
        .listen(
      (currentLocation) {
        updateMarkerAndCamera(currentLocation, moveCamera: false);
      },
      
    );
    */
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
      icon: customIcon,
    );
    mapMarkers.add(myLocationMarker);

    if (moveCamera) {
      _controller?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: updatedPosition, zoom: 15),
      ));
    }
    printMarkers();
    emit(MarkerUpdated(Set.from(mapMarkers)));
  }
}
