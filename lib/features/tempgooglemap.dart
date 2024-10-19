import 'package:eram_express/app/di.dart';
import 'package:eram_express/features/common/presentation/widgets/custom_button.dart';
import 'package:eram_express/features/google_map/presentation/views/google_map_view_model.dart';
import 'package:eram_express/features/home/presentation/widgets/top_bottom_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../core/utils/logger.dart';
import 'google_map/presentation/views/google_map_view_state.dart';

class GoogleMapScreen extends StatelessWidget {
  static const String route = '/google';
  final MarkerCubit markerCubit = MarkerCubit
  (
    locationService : locationservice,

  );

  GoogleMapScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => markerCubit..setmylocation(), // هنا بيجيب ال current
        //هو ده معناه  ان في  des _ source
        // كل ما يفتحها  هيعمل create من الاول؟
        child: BlocBuilder<MarkerCubit, MarkerState>(
          
          builder: (context, state) {
            //CameraPosition initialCameraPosition = markerCubit.kInitialPosition;
            logger.debug("GoogleMap is being rebuilt with state: $state");
            return Scaffold(
                body: Stack(children: [
              GoogleMap(
                  zoomControlsEnabled: false,
                  onMapCreated: (controller) async {
                    context.read<MarkerCubit>().setController(controller);
                    //context.read<MarkerCubit>().setmapstyle(context); // دي بتشتغل لما اعمل  reload
                  },
                    onCameraMove: (CameraPosition position) 
                    {
                    logger.debug( "Camera is moving to: ${position.target.latitude}, ${position.target.longitude}");
                    },
                  style: context.read<MarkerCubit>().mapstyle,
                  markers: state is MarkerUpdated ? state.markers : {},
                  initialCameraPosition:
                      context.read<MarkerCubit>().kInitialPosition),
              _buildaddresscontainer(),
            ]));
          },
        ));
  }
}

Widget _buildaddresscontainer() {
  return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        height: 200,
        child: const Padding(
          padding: EdgeInsets.only(top: 15, left: 30, right: 30),
          child: Column(
            children: [
              TopBottomModel(),
              Row(
                children: [
                  Icon(Icons.recommend),
                  Column(children: [
                    Text('Pick up location'),
                  ]),
                ],
              )
            ],
          ),
        ),
      ));
}

