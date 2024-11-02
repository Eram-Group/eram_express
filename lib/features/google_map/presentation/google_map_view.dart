import 'dart:ui';
import 'package:eram_express/app/di.dart';
import 'package:eram_express/core/app_colors.dart';
import 'package:eram_express/features/Common/presentation/widgets/SvgIcon.dart';
import 'package:eram_express/features/google_map/presentation/views/google_map_view_model.dart';
import 'package:eram_express/features/home/presentation/widgets/top_bottom_model.dart';
import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:eram_express_shared/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../Common/presentation/widgets/customButton.dart';
import '../../home/data/models/picking_locationModel.dart';
import 'views/google_map_view_state.dart';
import 'package:provider/provider.dart';
import 'views/place_details_view/place_details_view_model.dart';
import 'views/place_details_view/place_details_view_state.dart';

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
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              PlaceDetailsViewModel(locationService: locationservice),
        ),
        BlocProvider(
          create: (context) {
            final placeDetailsViewModel = context.read<PlaceDetailsViewModel>();
            return MarkerCubit(
              locationService: locationservice,
              placeDetailsViewModel: placeDetailsViewModel,
            )..setInitialCameraPostion(googleMapViewArguments?.initialAddress);
          },
        ),
      ],
      child: BlocBuilder<MarkerCubit, MarkerState>(
        builder: (context, state) {
          logger.debug("GoogleMap is being rebuilt with state: $state");
          return SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Stack(
                children: [
                  GoogleMap(
                    onMapCreated: (controller) async {
                      context.read<MarkerCubit>().setController(controller);
                      context.read<MarkerCubit>().setmapstyle(context);
                    },
                    onCameraMove: (CameraPosition position) {
                      context
                          .read<MarkerCubit>()
                          .updateMarkerAndCamera(position);
                    },
                    onCameraIdle: () {
                      context.read<MarkerCubit>().getplacedetails();
                    },
                    //style: context.read<MarkerCubit>().mapstyle,
                    initialCameraPosition:
                        context.read<MarkerCubit>().kInitialPosition,
                    /*
                    scrollGesturesEnabled: false, // منع التحريك العمودي والأفقي
                    zoomGesturesEnabled: false, // منع التكبير والتصغير
                    rotateGesturesEnabled: false, // منع التدوير
                    tiltGesturesEnabled: false,
                    */
                  ),
                  if (!context.read<MarkerCubit>().isLoading)
                    Center(
                      child: _buildMarker(),
                    ),
                  const SearchButton(),
                  _buildAddressContainer(),
                  /*
                  if (!context
                      .read<MarkerCubit>()
                      .matching) // تحقق من قيمة inside
                    Positioned.fill(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                            sigmaX: 5.0, sigmaY: 5.0), // تعيين مستوى الضبابية
                        child: Container(
                          color: Colors.black
                              .withOpacity(0.5), // لون الطبقة مع الشفافية
                        ),
                      ),
                    ),
                    */
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAddressContainer() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: BlocBuilder<PlaceDetailsViewModel, PlaceDetailsViewState>(
        builder: (context, state) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            //height: Responsive.screenHeight! * .25,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const TopBottomModel(),
                  if (state is PlaceDetailerror)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.error),
                        Text(state.errormessege),
                      ],
                    )
                  else if (state is PlaceDetaisOutsideboundries)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.error),
                        const Text("Outside the borders of the country"),
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
                                context.tt('Pick up location', "موقع الاستلام"),
                                style: TextStyle(
                                  fontSize: Responsive.getResponsiveFontSize(
                                      context,
                                      fontSize: 16),
                                  height: 25.2 /
                                      Responsive.getResponsiveFontSize(context,
                                          fontSize: 16),
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.lightGrey,
                                ),
                              ),
                              if (state is PlaceDetailssuccess)
                                Column(children: [
                                  Text(
                                    state.placedetails.formattedAddress,
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
                                                    .read<MarkerCubit>()
                                                    .mapMarkers
                                                    .first
                                                    .position
                                                    .longitude,
                                                latitude: context
                                                    .read<MarkerCubit>()
                                                    .mapMarkers
                                                    .first
                                                    .position
                                                    .latitude,
                                              ),
                                              address: state.placedetails
                                                  .formattedAddress);
                                      Navigator.of(context).pop(
                                          pickingLocation); // Pop the current route and return the picking location
                                    },
                                  ),
                                ])
                              else // Loading placeholder
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

class SearchButton extends StatelessWidget {
  const SearchButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the search screen
        context.read<MarkerCubit>().searchButtonClick();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.transparent),
        ),
        child: const Text(
          "Search here", // Hint text
          style: TextStyle(
            color: Colors.grey, // You can customize the text color
          ),
        ),
      ),
    );
  }
}
