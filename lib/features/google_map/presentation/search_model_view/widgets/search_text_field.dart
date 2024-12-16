import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../search_model_view.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: context.read<SearchViewController>().searchController,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
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
