import 'package:eram_express/app/di.dart';
import 'package:eram_express/core/app_colors.dart';
import 'package:eram_express/features/Common/presentation/widgets/SvgIcon.dart';
import 'package:eram_express/features/google_map/presentation/views/google_map_view_model.dart';
import 'package:eram_express/features/home/presentation/widgets/top_bottom_model.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:eram_express_shared/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'google_map/presentation/views/google_map_view_state.dart';

class GoogleMapView extends StatelessWidget {
  static const String route = '/google';
  final MarkerCubit markerCubit = MarkerCubit(
    locationService: locationservice,
  );

  GoogleMapView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => markerCubit..setmylocation(),
        child: BlocBuilder<MarkerCubit, MarkerState>(
          builder: (context, state) {
            if (state is MarkerInitial) {
              return CircularProgressIndicator();
            }
            logger.debug("GoogleMap is being rebuilt with state: $state");
            return SafeArea(
                child: Scaffold(
                    resizeToAvoidBottomInset: false,
                    body: Stack(children: [
                      GoogleMap(
                          onMapCreated: (controller) async {
                            context
                                .read<MarkerCubit>()
                                .setController(controller);
                            context.read<MarkerCubit>().setmapstyle(
                                context); // دي بتشتغل لما اعمل  reload
                          },
                          onCameraMove: (CameraPosition position) {
                            context.read<MarkerCubit>().updateMarkerAndCamera(
                                  position,
                                );
                          },
                          onCameraIdle: () {
                            //context.read<MarkerCubit>().printMarkers();
                          },
                          style: context.read<MarkerCubit>().mapstyle,
                          markers: context.read<MarkerCubit>().mapMarkers,
                          initialCameraPosition:
                              context.read<MarkerCubit>().kInitialPosition),
                      /*
                      Positioned(
                          top: 6,
                          left: 10,
                          right: 10,
                          child: SearchButton()),
                          */
                      _buildAddressContainer(),
                    ])));
          },
          //هو ده معناه  ان في  des _ source
          // كل ما يفتحها  هيعمل create من الاول؟
        ));
  }
}

Widget _buildAddressContainer() {
  return Positioned(
    bottom: 0,
    left: 0,
    right: 0,
    child: BlocBuilder<MarkerCubit, MarkerState>(
      builder: (context, state) {
        {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            height: Responsive.screenHeight! * .25,
            child: Padding(
              padding: const EdgeInsets.only(top: 15, left: 30, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const TopBottomModel(),
                  state is PlaceDetailerror
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.error),
                            Text(state.errormessege),
                          ],
                        )
                      : Row(
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
                                  'Pick up location',
                                  style: TextStyle(
                                    fontSize: Responsive.getResponsiveFontSize(
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
                                state is PlaceDetailssuccess
                                    ? Text(
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
                                      )
                                    : Container(
                                        width: 70,
                                        height: 10,
                                        color: Colors.grey,
                                      )
                              ],
                            )),
                          ],
                        ),
                ],
              ),
            ),
          );
        }
      },
    ),
  );
}

class SearchButton extends StatelessWidget {
  const SearchButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the search screen
        Navigator.pushNamed(
            context, '/search'); // Adjust the route name if necessary
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


// steps for create searchinggggggggggg
/*
1-text field  (this input  send to api)
2-listen to input to when input change we change input 
3-search place
4-display result
*/