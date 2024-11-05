import 'package:eram_express/features/authentication/presentation/views/modals/registered_successfully_modal.dart';
import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../app/di.dart';
import '../../data/models/place_auto_complete_model.dart';
import '../../domain/usecases/get_longlat_place_usecase.dart';
import '../../domain/usecases/get_search_result_usecase.dart';
import 'search_model_view.dart';
import 'search_model_view_state.dart';

class SearchView extends StatelessWidget {
  static const String route = '/search';

  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchCubit(
          getLonglatPlaceUsecase:
              GetLonglatPlaceUsecase(googleMapRepository: googlemapRepository),
          getSearchResultUsecase: GetSearchResultUsecase(
              googleMapRepository: googlemapRepository,
              authenticationRepository: authenticationRepository)),
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
              const SearchButton(),
              BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchStateError) {
                    return Center(child: Text("Error occurred"));
                  } else if (state is SearchStateLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SearchStateEmpty) {
                    return const Center(child: Text("empty state"));
                  } else if (state is SearchStateSuccess) {
                    if (state.recommendplaces.length == 0) {
                      return const Center(child: Text("No result Found"));
                    } else {
                      return _builddisplayresult(state.recommendplaces);
                    }
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

Widget _builddisplayresult(List<PlaceAutocompleteModel> recommendplaces) {
  return Expanded(
      child: Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: ListView.builder(
      itemCount: recommendplaces.length,
      itemBuilder: (context, index) {
        final place = recommendplaces[index];

        return GestureDetector(
          onTap: () {
            context.read<SearchCubit>().getlonglat(place.description);
          },
          child: _buildsearchcontainer(place.description),
        );
      },
    ),
  ));
}

Widget _buildsearchcontainer(String place) {
  return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
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
            Icon(Icons.location_on),
            Gap(5),
            Expanded(
                child: Text(
              place,
              style: TextStyle(
                fontFamily: "outfit",
                fontSize: 16.0,
                color: Colors.black,
              ),
            )),
          ]));
}

class SearchButton extends StatelessWidget {
  const SearchButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchCubit = context.read<SearchCubit>();

    return Column(
      children: [
        TextField(
          controller: searchCubit.searchController,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            hintText: context.tt("Search... ", " .. البحث"),
            fillColor: Colors.white,
            filled: true,
            border: customOutlineInputBorder,
            focusedBorder: customOutlineInputBorder,
          ),
          onSubmitted: (value) {},
        )
      ],
    );
  }
}

const OutlineInputBorder customOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(20)),
  borderSide: BorderSide(color: Colors.grey),
);
