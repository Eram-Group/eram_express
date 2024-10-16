import 'package:eram_express/features/common/presentation/widgets/custom_button.dart';
import 'package:eram_express/features/google_map/presentation/views/google_map_view_model.dart';
import 'package:eram_express/features/home/presentation/widgets/top_bottom_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'google_map/presentation/views/google_map_view_state.dart';

class GoogleMapScreen extends StatelessWidget {
  static const String route = '/google';
  final MarkerCubit markerCubit = MarkerCubit();
  final CameraPosition _kInitialPosition = const CameraPosition(
    target: LatLng(30.0383, 31.2114),
    zoom: 12,
  );
  GoogleMapScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => MarkerCubit(),
        //هو ده معناه  ان في  des _ source
        // كل ما يفتحها  هيعمل create من الاول؟
        child: BlocBuilder<MarkerCubit, MarkerState>(
          builder: (context, state) {
            return Scaffold(
                body: Stack(children: [
              GoogleMap(
                zoomControlsEnabled: false,
                onMapCreated: (controller) {
                  context.read<MarkerCubit>().setController(controller);
                   context
                      .read<MarkerCubit>()
                      .setmapstyle(context); 
                      // انا بعتها هنا علشان اقدر ابعت ليها  context 
                      // لكن المشكله ان الstyle مش بيتغير
                      // غير بعد reload
                      
                },
                style: context.read<MarkerCubit>().mapstyle,
                markers: context.read<MarkerCubit>().mapMarkers,
                initialCameraPosition: _kInitialPosition,
              ),
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

void initMapStyle(
  BuildContext context,
) async {
  var silvermood = await DefaultAssetBundle.of(context)
      .loadString('assets/map_styles/silvermap.json');
}
