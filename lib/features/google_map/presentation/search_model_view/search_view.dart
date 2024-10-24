
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di.dart';
import 'search_model_view.dart';
import 'search_model_view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchView extends StatelessWidget {
  static const String route = '/search';

  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchCubit(
          locationservice:
              locationservice), // Assuming locationservice is defined somewhere

      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search View'), // Added an AppBar for better UI
        ),
        body: Column(
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
                  logger
                      .debug("length: ${state.recommendplaces[0].description}");

                  logger.debug(
                      "length: ${state.recommendplaces.length.toString()}");

                  return Text(state.recommendplaces[0].description);
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
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
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            hintText: "Search here",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            fillColor: Colors.white,
            filled: true,
          ),
          onSubmitted: (value) {
            print('Searching for: $value');
          },
        ),
      ],
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