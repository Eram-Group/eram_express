import 'dart:ui';
import 'package:eram_express/features/google_map/data/models/placeModel.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'google_map_view_state.dart';

class MarkerCubit extends Cubit<MarkerState> {
  MarkerCubit() : super(MarkerInitial()) {
    intialmarker();
  }

  late BitmapDescriptor customIcon;
  late GoogleMapController _controller;
  final Set<Marker> mapMarkers = {};
  late Location location;
  late String mapstyle = '';
  void intialmarker() async {
    customIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(150, 150)),
      'assets/icons/Destination.png',
    );
    addInitialMarker();
  }

  void setmapstyle(BuildContext context) async {
    mapstyle = await DefaultAssetBundle.of(context)
        .loadString('assets/map_styles/silvermap.json');
  }

  void addInitialMarker() {
    PlaceModel place = PlaceModel(
      id: 1,
      name: 'My Place',
      lat: 30.0383,
      long: 31.2114,
    );

    mapMarkers.add(
      Marker(
        markerId: MarkerId(place.id.toString()),
        position: LatLng(place.lat, place.long),
        icon: customIcon,
      ),
    );

    emit(MarkerComplete(place));
  }

  void setController(GoogleMapController controller) {
    _controller = controller;
  }

  Future<void> selectPlace(PlaceModel place) async {
    mapMarkers.add(
      Marker(
        markerId: MarkerId(place.id.toString()),
        position: LatLng(place.lat, place.long),
        //icon: customIcon,
        infoWindow: InfoWindow(
          title: 'My Marker',
          snippet: 'Custom Marker',
        ),
      ),
    );

    emit(MarkerComplete(place));
  }

  void checkAndRequestLocationService() async {
    var isserviceEnabled = await location.serviceEnabled();
    if (!isserviceEnabled) {
      isserviceEnabled = await location.requestService();
    }
    if (!isserviceEnabled) {
      // ممكن نعرض ايرور بار
    }
  }

  void checkAndRequestLocationPermission() async {
    var permisionstatus = await location.hasPermission();
    if (permisionstatus == PermissionStatus.denied) {
      permisionstatus = await location.requestPermission();
    }
    if (permisionstatus != PermissionStatus.granted) {
      // show error barrrrrrrrrrrrrrrrrrrrrrrr
    }
  }
}
