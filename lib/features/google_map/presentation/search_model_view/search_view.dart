import 'package:eram_express/core/app_colors.dart';
import 'package:eram_express/features/Common/presentation/widgets/SvgIcon.dart';
import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../app/di.dart';
import '../../data/models/place_auto_complete_model.dart';
import 'search_model_view.dart';
import 'search_model_view_state.dart';
import 'widgets/search_text_field.dart';

class SearchView extends StatelessWidget {
  static const String route = '/search';
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchViewController(
        googleMapRepository: googleMapRepository,
        authenticationRepository: authenticationRepository,
         ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Search View',
            style: TextStyle(
              fontFamily: "outfit",
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            children: [
              const SearchTextField(),
              BlocBuilder<SearchViewController, SearchState>(
                builder: (context, state) {
                  if (state is SearchStateError) {
                    return  const Center(child: Text("Error occurred"));
                  } else if (state is SearchStateEmpty) {
                    return _buildEmptyState(context);
                  } else if (state is SearchStateSuccess) {
                    return _buildDisplayResult(state.recommendPlaces);
                  }
                  return const SizedBox.shrink(); // defualt emptyscreen
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildEmptyState(BuildContext context) {
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SvgIcon(asset: "no_result", size: 200),
        const Gap(2),
        Text(
          context.tt("No Result found", "لم يتم العثور على نتائج"),
          style: TextStyle(
            fontFamily: "outfit",
            fontSize: 16,
            color: AppColor.blackText,
          ),
        ),
        const Gap(2),
        Text(
          context.tt("Please choose another location", "يرجى اختيار موقع آخر"),
          style: const TextStyle(
            fontFamily: "outfit",
            fontSize: 16,
            color: AppColor.lightGrey,
          ),
        )
      ],
    ),
  );
}

Widget _buildDisplayResult(List<PlaceAutocompleteModel> recommendPlaces) {
  return Expanded(
      child: Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: ListView.builder(
      itemCount: recommendPlaces.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: ()
           {
            context.read<SearchViewController>().getCoordinatesForAddress(recommendPlaces[index].description);
          },
          child: _buildSearchItemCard(recommendPlaces[index].description),
        );
      },
    ),
  ));
}

Widget _buildSearchItemCard(String place) {
  return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(Icons.location_on),
            const Gap(5),
            Expanded(
                child: Text(
              place,
              style: const TextStyle(
                fontFamily: "outfit",
                fontSize: 16.0,
                color: Colors.black,
              ),
            )),
          ]));
}
