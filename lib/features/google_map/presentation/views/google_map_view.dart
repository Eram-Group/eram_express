import 'dart:ui';
import 'package:eram_express/core/app_colors.dart';
import 'package:eram_express/features/Common/presentation/widgets/SvgIcon.dart';
import 'package:eram_express/features/google_map/presentation/views/google_map_view_controller.dart';
import 'package:eram_express/features/google_map/presentation/views/widgets/search_button.dart';
import 'package:eram_express/features/home/presentation/widgets/top_bottom_model.dart';
import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:eram_express_shared/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../app/ServiceLocator.dart';
import '../../../Common/presentation/widgets/customButton.dart';
import '../../../home/data/models/picking_locationModel.dart';

import 'google_map_view_state.dart';

class GoogleMapViewArguments {
  final Point? initialAddress;

  const GoogleMapViewArguments({
    this.initialAddress,
  });
}

class GoogleMapView extends StatelessWidget {
  static const String route = '/google';
  final GoogleMapViewArguments? googleMapViewArguments;
  const GoogleMapView({super.key, this.googleMapViewArguments});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<GoogleMapViewController>(
      create: (context) => sl<GoogleMapViewController>()
        ..setInitialCameraPosition(googleMapViewArguments?.initialAddress),
      child: BlocBuilder<GoogleMapViewController, GoogleMapViewState>(
        //To prevent rebuilding on every action
        buildWhen: (previous, current) {
          return (current.status == GoogleMapViewStatus.updated ||
              current.status == GoogleMapViewStatus.loading);
        },
        builder: (context, state) {
          logger.debug("GoogleMap is being rebuilt with state: $state");
          return SafeArea(
              child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Opacity(
              opacity: state.isLoading ? 0.5 : 1,
              child: Stack(
                children: [
                  GoogleMap(
                    onMapCreated: (controller) async {
                      context
                          .read<GoogleMapViewController>()
                          .setController(controller);
                    },
                    onCameraMove: (CameraPosition position) {
                      context
                          .read<GoogleMapViewController>()
                          .updateMarkerAndCamera(position);
                    },
                    onCameraIdle: () {
                      context.read<GoogleMapViewController>().getPlaceDetails();
                    },
                    initialCameraPosition: context
                        .read<GoogleMapViewController>()
                        .kInitialPosition,
                  ),
                  if (!(state.isLoading)) ...[
                    Center(
                      child: _buildMarker(),
                    ),
                    const SearchButton(),
                    _buildAddressContainer(),
                  ],
                ],
              ),
            ),
          ));
        },
      ),
    );
  }

  Widget _buildAddressContainer() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: BlocBuilder<GoogleMapViewController, GoogleMapViewState>(
        builder: (context, state) {
          logger.debug(state.toString());
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () {
                  context.read<GoogleMapViewController>().getCurrentLocation();
                },
                backgroundColor: Colors.white,
                child: const Icon(
                  Icons.my_location,
                  color: Colors.blue,
                ),
              ),
              const Gap(20),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const TopBottomModel(),
                      if (state.isPlaceDetailsError)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.error),
                            Text(state.errorMessage!),
                          ],
                        )
                      else
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SvgIcon(asset: 'record-circle'),
                            SizedBox(
                              width: Responsive.getResponsiveFontSize(context,
                                  fontSize: 20),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    context.tt(
                                        'Pick up location', "موقع الاستلام"),
                                    style: TextStyle(
                                      fontSize:
                                          Responsive.getResponsiveFontSize(
                                              context,
                                              fontSize: 16),
                                      height: 25.2 /
                                          Responsive.getResponsiveFontSize(
                                              context,
                                              fontSize: 16),
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.lightGrey,
                                    ),
                                  ),
                                  if (state.isPlaceDetailsLoaded)
                                    Column(children: [
                                      Text(
                                        state.placeDetails!.formattedAddress,
                                        style: TextStyle(
                                          fontSize:
                                              Responsive.getResponsiveFontSize(
                                                  context,
                                                  fontSize: 14),
                                          height: 18.2 /
                                              Responsive.getResponsiveFontSize(
                                                  context,
                                                  fontSize: 14),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const Gap(30),
                                      CustomButton(
                                        padding: const EdgeInsets.all(15),
                                        text: context.tt(
                                            "Select location", "حدد الموقع"),
                                        onPressed: () {
                                          PickingLocationModel pickingLocation =
                                              PickingLocationModel(
                                                  point: Point(
                                                    longitude: context
                                                        .read<
                                                            GoogleMapViewController>()
                                                        .mapMarkers
                                                        .first
                                                        .position
                                                        .longitude,
                                                    latitude: context
                                                        .read<
                                                            GoogleMapViewController>()
                                                        .mapMarkers
                                                        .first
                                                        .position
                                                        .latitude,
                                                  ),
                                                  address: state.placeDetails!
                                                      .formattedAddress);
                                          Navigator.of(context)
                                              .pop(pickingLocation);
                                        },
                                      ),
                                    ])
                                  else
                                    Container(
                                      width: 70,
                                      height: 10,
                                      color: Colors.grey, // Loading
                                    ),
                                  const Gap(30),
                                ],
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMarker() {
    return const SvgIcon(
      asset: "marker",
      size: 150,
    );
  }
}
